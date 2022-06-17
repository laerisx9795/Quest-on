//
//  PracticeMode.swift
//  Quest?on
//
//  Created by 李嘉凌 on 2022/5/20.
//

import UIKit
import SpriteKit
import SceneKit

class PracticeMode: SKScene {
    
    var octahedronMode: Int = 0
    let arthmetic_oprators = ["+", "-", "✕", "÷", "%"]
    let relational_operators = [">", "<", "="]
    var answer: String = ""
    var question: String = ""
    var result: Bool = true
    var numOfQuestion: Int = 0
    var numOfCorrectAns: Int = 0
    var backgroundMusic: SKAudioNode!
    //let touchMusic = SKAction.playSoundFileNamed("pianoE.mp3", waitForCompletion: false)
    let record :UserDefaults = UserDefaults.standard
    let styleList = ["mintchocolate", "polarbear", "strawberrymilk"]
    var style: Int!
    
    override func didMove(to view: SKView) {
        createScene()
        createGestureRecognizer()
        createQuestion()
        
        if let musicURL = Bundle.main.url(forResource: "National Express - Dan Bodan", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            backgroundMusic.name = "BGM"
            let vol = record.object(forKey: "volOfBGM") as! Float
            backgroundMusic.run(SKAction.changeVolume(to: vol, duration: 0))
            //self.addChild(backgroundMusic)
        }
    }
    
    func createScene(){
        style = record.object(forKey: "Style") as? Int
        //let bg = SKSpriteNode(imageNamed: "background_mintchocolate")
        let bg = SKSpriteNode(imageNamed: "background_"+styleList[style])
        bg.size.width = self.size.width
        bg.size.height = self.size.height
        bg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bg.zPosition = -1
        
        let octahedronSize = min(self.size.height * 0.5, self.size.width)
        let octahedronNode = SK3DNode(viewportSize: CGSize(width: octahedronSize, height: octahedronSize))
        octahedronNode.name = "octahedron"
        octahedronNode.scnScene = SCNScene(named: "gameassets.scnassets/octahedron.dae")
        octahedronNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY * 0.75)
        
        //octahedronNode.scnScene?.rootNode.childNodes.first?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "gameassets.scnassets/octahedron_mintchocolate.png")
        octahedronNode.scnScene?.rootNode.childNodes.first?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "gameassets.scnassets/octahedron_"+styleList[style]+".png")
        
        /* 回封面 */
        let homeButton = SKSpriteNode(imageNamed: "icons8-home")
        homeButton.name = "home"
        homeButton.position = CGPoint(x: self.frame.midX * 1.8, y: homeButton.size.height)
        
        /* 設定 */
        let settingButton = SKSpriteNode(imageNamed: "icons8-setting")
        settingButton.name = "setting"
        settingButton.position = CGPoint(x: homeButton.position.x - 60, y: settingButton.size.height)
        
        /* 返回 */
        let leftButton = SKSpriteNode(imageNamed: "icons8-left")
        leftButton.name = "left"
        leftButton.position = CGPoint(x: 0 + leftButton.size.width , y: self.frame.maxY - leftButton.size.height * 1.5)
        
        self.addChild(bg)
        self.addChild(octahedronNode)
        self.addChild(settingButton)
        self.addChild(homeButton)
        self.addChild(leftButton)
    }
    
    func createGestureRecognizer(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeRight.direction = .right
        self.view?.addGestureRecognizer(swipeRight)
        //self.scene?.view?.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeLeft.direction = .left
        self.view?.addGestureRecognizer(swipeLeft)
        //self.scene?.view?.addGestureRecognizer(swipeLeft)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.childNode(withName: "result")?.alpha = 0
        let touch = touches.first
        let touchLocation = touch?.location(in: self)
        
        switch atPoint(touchLocation!).name{
        case "octahedron":
            let node = atPoint(touchLocation!)
            let range = node.frame.height * 0.8 / 2 //  distance between center and vertex
            let maxDistance = range / 2 * pow(2, 0.5)  //  height of each region
            let distance = pow(pow(touchLocation!.x - node.position.x, 2) + pow(touchLocation!.y - node.position.y, 2), 0.5)
            if distance <= maxDistance {    // in the octahedron
                //run(touchMusic)
                numOfQuestion += 1
                let area = areaOfTouched(touchLocation!, node.position)
                checkUserAnswer(area)
            }
        case "home":
            //run(touchMusic)
            writeRecord()
            let scene = HelloScene(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(scene, transition: .fade(withDuration: 1))
        case "setting":
            //run(touchMusic)
            writeRecord()
            let settingScene = SettingScene(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(settingScene, transition: .fade(withDuration: 1))
        case "left":
            //run(touchMusic)
            writeRecord()
            let scene = MenuScene(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(scene, transition: .fade(withDuration: 1))
        default:
            break
        }
    }
    
    @objc func handleSwipeGesture(_ sender: UISwipeGestureRecognizer){
        self.childNode(withName: "result")?.alpha = 0
        let octahedron = self.childNode(withName: "octahedron") as! SK3DNode
        switch sender.direction{
        case UISwipeGestureRecognizer.Direction.right:
            print("Right.")
            let rotate = SCNAction.rotateBy(x: 0, y: (45 * .pi)/180, z: 0, duration: 0.5)
            octahedron.scnScene?.rootNode.runAction(rotate)
            octahedronMode += 1
            octahedronMode = octahedronMode % 4
            print(octahedronMode)
        case UISwipeGestureRecognizer.Direction.left:
            print("Left.")
            let rotate = SCNAction.rotateBy(x: 0, y: (-45 * .pi)/180, z: 0, duration: 0.5)
            octahedron.scnScene?.rootNode.runAction(rotate)
            octahedronMode -= 1
            if(octahedronMode < 0){
                octahedronMode = 3
            }
            print(octahedronMode)
        default:
            break
        }
    }
    
    func areaOfTouched(_ point: CGPoint, _ center: CGPoint) -> Int {
        if(point.x <= center.x){
            if(point.y <= center.y){
                //  左下
                return 3
            }else{
                //  左上
                return 0
            }
        }else{
            if(point.y <= center.y){
                //  右下
                return 2
            }else{
                //  右上
                return 1
            }
        }
    }
    
    func checkUserAnswer(_ area: Int){
        var userAns : String = ""
        switch area{
        case 0:
            userAns = operatorOfLeftUp(octahedronMode)
        case 1:
            userAns = operatorOfRightUp(octahedronMode)
        case 2:
            userAns = operatorOfRightDown(octahedronMode)
        case 3:
            userAns = operatorOfLeftDown(octahedronMode)
        default:
            userAns = ""
        }
        
        //let node = self.childNode(withName: "question") as! SKLabelNode
        if userAns == answer{
            print("CORRECT.")
            result = true
            numOfCorrectAns += 1
        }else{
            print("INCORRECT.")
            result = false
        }
        
        
        //self.childNode(withName: "question")?.removeFromParent()
        //createQuestion()
        presentResult()
    }
    
    func presentResult(){
        if let node = self.childNode(withName: "result") as? SKSpriteNode{
            if result {
                node.texture = SKTexture(imageNamed: "CORRECT_"+styleList[style])
            }else{
                node.texture = SKTexture(imageNamed: "INCORRECT_"+styleList[style])
            }
        }else{
            if result {
                let resultNode = SKSpriteNode(imageNamed: "CORRECT_"+styleList[style])
                resultNode.name = "result"
                resultNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY * 1.25)
                self.addChild(resultNode)
            }else{
                let resultNode = SKSpriteNode(imageNamed: "INCORRECT_"+styleList[style])
                resultNode.name = "result"
                resultNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY * 1.25)
                self.addChild(resultNode)
            }
        }
        self.childNode(withName: "result")?.alpha = 1
        //let fade = SKAction.fadeOut(withDuration: 1)
        //let remove = SKAction.removeFromParent()
        //let actionSequence = SKAction.sequence([fade, remove])
        //self.childNode(withName: "result")?.run(fade)
        self.childNode(withName: "question")?.removeFromParent()
        createQuestion()
    }
    
    func operatorOfLeftUp(_ mode: Int) -> String {
        switch mode {
        case 0:
            print("✕")
            return "✕"
        case 1:
            print("-")
            return "-"
        case 2:
            print("+")
            return "+"
        case 3:
            print("÷")
            return "÷"
        default:
            return ""
        }
    }
    
    func operatorOfLeftDown(_ mode: Int) -> String {
        switch mode{
        case 0:
            print("<")
            return "<"
        case 1:
            print(">")
            return ">"
        case 2:
            print("%")
            return "%"
        case 3:
            print("=")
            return "="
        default:
            return ""
        }
    }
    
    func operatorOfRightUp(_ mode: Int) -> String {
        switch mode {
        case 0:
            print("÷")
            return "÷"
        case 1:
            print("✕")
            return "✕"
        case 2:
            print("-")
            return "-"
        case 3:
            print("+")
            return "+"
        default:
            return ""
        }
    }
    
    func operatorOfRightDown(_ mode: Int) -> String {
        switch mode{
        case 0:
            print("=")
            return "="
        case 1:
            print("<")
            return "<"
        case 2:
            print(">")
            return ">"
        case 3:
            print("%")
            return "%"
        default:
            return ""
        }
    }
    
    func createQuestion(){
        let op = arthmetic_oprators.randomElement()! // 隨機選擇運算子
        var relation = relational_operators.randomElement()!    //  隨機選擇關係運算子
        let type = Bool.random()    //  隨機選擇題型
        var operand1 = Int.random(in: 2..<100) //  隨機產生兩個運算元
        var operand2 = Int.random(in: 2..<100)
        var result: Int = 0
        
        //  計算結果
        switch op{
        case "+":
            result = operand1 + operand2
        case "-":
            while(operand1 == operand2){
                operand2 = Int.random(in: 2..<100)
            }
            if(operand1 < operand2){
                let temp = operand1
                operand1 = operand2
                operand2 = temp
            }
            result = operand1 - operand2
        case "✕":
            result = operand1 * operand2
        case "÷":
            while(operand1 <= operand2 || ((operand1 - operand2) == (operand1 / operand2))){
                operand2 = Int.random(in: 2..<100)
            }
            result = operand1 / operand2
        case "%":
            while(operand1 <= operand2 || ((operand1 - operand2) == (operand1 % operand2))){
                operand2 = Int.random(in: 2..<100)
            }
            result = operand1 % operand2
        default:
            break
        }
        
        if(type){   //  猜運算子
            relation = "="
            answer = op
            question = String(operand1) + " □ " + String(operand2) + " " + relation + " " + String(result)
        }else{      //  猜關係運算子
            switch relation{
            case ">":
                result = result - Int.random(in: 1..<(result/2)+2)
            case "<":
                result = result + Int.random(in: 1..<(result/2)+2)
            default:
                break
            }
            answer = relation
            question = String(operand1) + " " + op + " " + String(operand2) + " □ " + String(result)
        }
        
        presentQuestion()
    }
    
    func presentQuestion(){
        let questionLabel = SKLabelNode(text: question)
        questionLabel.name = "question"
        questionLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY * 1.5)
        questionLabel.fontSize = 48
        questionLabel.fontColor = UIColor(red: 0.24, green: 0.20, blue: 0.13, alpha: 1.00)
        
        self.addChild(questionLabel)
    }
    
    func writeRecord(){
        //  累計答題數
        let totalNumOfQuestion = record.object(forKey: "totalNumOfPracticeQuestion") as! Int?
        if totalNumOfQuestion == nil{
            record.set(numOfQuestion, forKey: "totalNumOfPracticeQuestion")
        }else{
            record.set(numOfQuestion + totalNumOfQuestion!, forKey: "totalNumOfPracticeQuestion")
            if totalNumOfQuestion! < numOfQuestion {
                record.set(numOfQuestion, forKey: "largestNumOfPracticeContinueAns")
            }
        }
        //  累計答對題數
        let totalNumOfAns = record.object(forKey: "totalNumOfPracticeCorrectAns") as! Int?
        if totalNumOfAns == nil{
            record.set(numOfCorrectAns, forKey: "totalNumOfPracticeCorrectAns")
        }else{
            record.set(numOfCorrectAns + totalNumOfAns!, forKey: "totalNumOfPracticeCorrectAns")
            
        }
        record.synchronize()
    }
}
