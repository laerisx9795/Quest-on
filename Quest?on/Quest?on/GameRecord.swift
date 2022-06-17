//
//  GameRecord.swift
//  Quest?on
//
//  Created by 李嘉凌 on 2022/5/24.
//

import UIKit
import SpriteKit
import SceneKit

class GameRecord: SKScene {
    
    //let touchMusic = SKAction.playSoundFileNamed("pianoE.mp3", waitForCompletion: false)
    let record = UserDefaults.standard  //  get data
    let styleList = ["mintchocolate", "polarbear", "strawberrymilk"]
    
    override func didMove(to view: SKView) {
        createScene()
    }
    
    func createScene(){
        let style = record.object(forKey: "Style") as! Int
        //let bg = SKSpriteNode(imageNamed: "background_mintchocolate")
        let bg = SKSpriteNode(imageNamed: "background_"+styleList[style])
        bg.size.width = self.size.width
        bg.size.height = self.size.height
        bg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bg.zPosition = -1
        
        //let recordNode = SKSpriteNode(imageNamed: "RECORDtitle_mintchocolate")
        let recordNode = SKSpriteNode(imageNamed: "RECORDtitle_"+styleList[style])
        recordNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY * 1.8)
        
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
        self.addChild(recordNode)
        self.addChild(homeButton)
        self.addChild(settingButton)
        self.addChild(leftButton)
        
        //  Practice
        let practice = SKLabelNode(text: "練習模式")
        practice.position = CGPoint(x: self.frame.midX * 0.5, y: self.frame.midY * 1.6)
        practice.fontSize = 28
        practice.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        self.addChild(practice)
        //  累計答對題數 / 累計答題數
        let practiceTQNode = SKLabelNode(text: "累計答對題數 / 答題數")
        practiceTQNode.position = CGPoint(x: self.frame.midX * 0.8, y: practice.position.y - 60)
        practiceTQNode.fontSize = 24
        practiceTQNode.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        self.addChild(practiceTQNode)
        
        if let practiceTotal = record.object(forKey: "totalNumOfPracticeQuestion") as? Int {
            if let practiceCorrect = record.object(forKey: "totalNumOfPracticeCorrectAns") as? Int{
                let practiceTQ = SKLabelNode(text: String(practiceCorrect) + " / " + String(practiceTotal))
                practiceTQ.position = CGPoint(x: self.frame.midX * 1.5, y: practiceTQNode.position.y - 30)
                practiceTQ.fontSize = 24
                practiceTQ.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
                self.addChild(practiceTQ)
            }
        }
        
        
        //  Classic
        let classic = SKLabelNode(text: "經典模式")
        classic.position = CGPoint(x: self.frame.midX * 0.5, y: practiceTQNode.position.y - 60)
        classic.fontSize = 28
        classic.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        self.addChild(classic)
        //  累計答對題數 / 累計答題數
        let classicTQNode = SKLabelNode(text: "累計答對題數 / 答題數")
        classicTQNode.position = CGPoint(x: self.frame.midX * 0.8, y: classic.position.y - 60)
        classicTQNode.fontSize = 24
        classicTQNode.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        self.addChild(classicTQNode)
        
        if let classicTotal = record.object(forKey: "totalNumOfClassicQuestion") as? Int {
            if let classicCorrect = record.object(forKey: "totalNumOfClassicCorrectAns") as? Int {
                let classicTQ = SKLabelNode(text: String(classicCorrect) + " / " + String(classicTotal))
                classicTQ.position = CGPoint(x: self.frame.midX * 1.5, y: classicTQNode.position.y - 30)
                classicTQ.fontSize = 24
                classicTQ.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
                self.addChild(classicTQ)
            }
        }
        
        
        //  最長連續通關數 ＆ 通關時間
        let classicLCQNode = SKLabelNode(text: "最長連續答題數 / 時間")
        classicLCQNode.position = CGPoint(x: self.frame.midX * 0.8, y: classicTQNode.position.y - 60)
        classicLCQNode.fontSize = 24
        classicLCQNode.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        self.addChild(classicLCQNode)
        
        if let classicLongest = record.object(forKey: "largestNumOfClassicClearedQuestion") as? Int {
            if let classicTime = record.object(forKey: "timeOfClassicCleared") as? Int {
                let classicLCQ = SKLabelNode(text: String(classicLongest) + " / " + secondFormat(classicTime))
                classicLCQ.position = CGPoint(x: self.frame.midX * 1.5, y: classicLCQNode.position.y - 30)
                classicLCQ.fontSize = 24
                classicLCQ.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
                self.addChild(classicLCQ)
            }
        }
        
        
        //  Challenge
        let challenge = SKLabelNode(text: "挑戰模式")
        challenge.position = CGPoint(x: self.frame.midX * 0.5, y: classicLCQNode.position.y - 60)
        challenge.fontSize = 28
        challenge.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        self.addChild(challenge)
        //  累計答對題數 / 累計答題數
        let challengeTQNode = SKLabelNode(text: "累計答對題數 / 答題數")
        challengeTQNode.position = CGPoint(x: self.frame.midX * 0.8, y: challenge.position.y - 60)
        challengeTQNode.fontSize = 24
        challengeTQNode.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        self.addChild(challengeTQNode)
        
        if let challengeTotal = record.object(forKey: "totalNumOfChallengeQuestion") as? Int {
            if let challengeCorrect = record.object(forKey: "totalNumOfChallengeCorrectAns") as? Int {
                let challengeTQ = SKLabelNode(text: String(challengeCorrect) + " / " + String(challengeTotal))
                challengeTQ.position = CGPoint(x: self.frame.midX * 1.5, y: challengeTQNode.position.y - 30)
                challengeTQ.fontSize = 24
                challengeTQ.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
                self.addChild(challengeTQ)
            }
        }
        
        
        //  最長連續答題數 ＆ 通關時間
        let challengeLCQNode = SKLabelNode(text: "最長連續答題數 / 時間")
        challengeLCQNode.position = CGPoint(x: self.frame.midX * 0.8, y: challengeTQNode.position.y - 60)
        challengeLCQNode.fontSize = 24
        challengeLCQNode.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        self.addChild(challengeLCQNode)
        
        if let challengeLongest = record.object(forKey: "largestNumOfChallengeClearedQuestion") as? Int {
            if let challengeTime = record.object(forKey: "timeOfChallengeCleared") as? Int {
                let challengeLCQ = SKLabelNode(text: String(challengeLongest) + " / " + secondFormat(challengeTime))
                challengeLCQ.position = CGPoint(x: self.frame.midX * 1.5, y: challengeLCQNode.position.y - 30)
                challengeLCQ.fontSize = 24
                challengeLCQ.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
                self.addChild(challengeLCQ)
            }
        }
        
        //  最短答題時間
        let challengSTNode = SKLabelNode(text: "最短答題時間")
        challengSTNode.position = CGPoint(x: self.frame.midX * 0.8, y: challengeLCQNode.position.y - 60)
        challengSTNode.fontSize = 24
        challengSTNode.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        self.addChild(challengSTNode)
        
        if let challengeTime = record.object(forKey: "shortestTimeOfChallengeClear") as? Int {
            let challengST = SKLabelNode(text: secondFormat(challengeTime))
            challengST.position = CGPoint(x: self.frame.midX * 1.5, y: challengSTNode.position.y - 30)
            challengST.fontSize = 24
            challengST.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
            self.addChild(challengST)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch?.location(in: self)   // get position

        switch atPoint(touchLocation!).name{
        case "setting":
            //run(touchMusic)
            let settingScene = SettingScene(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(settingScene, transition: .fade(withDuration: 1))
        case "home":
            //run(touchMusic)
            let scene = HelloScene(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(scene, transition: .fade(withDuration: 1))
        case "left":
            //run(touchMusic)
            let scene = MenuScene(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(scene, transition: .fade(withDuration: 1))
        default:
            break
        }
    }
    
    func secondFormat(_ time: Int) -> String {
        var result = ""
        let min = "0" + String(time / 60)
        let sec = time % 60
        
        if sec < 10{
            result = min + ":0" + String(sec)
        }else{
            result = min + ":" + String(sec)
        }
        
        return result
    }
}
