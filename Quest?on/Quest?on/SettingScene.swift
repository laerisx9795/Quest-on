//
//  SettingScene.swift
//  Quest?on
//
//  Created by 李嘉凌 on 2022/5/24.
//

import UIKit
import SpriteKit
import SceneKit

class SettingScene: SKScene {
    //var vol : Float!
    var nowStyle: Int!
    let styleList = ["mintchocolate", "polarbear", "strawberrymilk"]
    //let touchMusic = SKAction.playSoundFileNamed("pianoE.mp3", waitForCompletion: false)
    let record = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        createScene()
    }
    
    func createScene(){
        nowStyle = record.object(forKey: "Style") as? Int
        let bg = SKSpriteNode(imageNamed: "background_"+styleList[nowStyle])
        bg.size.width = self.size.width
        bg.size.height = self.size.height
        bg.name = "bg"
        bg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bg.zPosition = -1
        
        let settingNode = SKSpriteNode(imageNamed: "SETTING_"+styleList[nowStyle])
        settingNode.name = "setting"
        settingNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY * 1.8)
        
        /* BGM */
        /*let BGMNode = SKLabelNode(text: "BGM")
        BGMNode.name = "BGM"
        BGMNode.position = CGPoint(x: self.frame.midX * 0.5, y: self.frame.midY * 1.6)
        BGMNode.fontSize = 28
        BGMNode.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        let BGMdown = SKLabelNode(text: "◀︎")
        BGMdown.name = "down"
        BGMdown.position = CGPoint(x: self.frame.midX * 1.2, y: self.frame.midY * 1.6)
        BGMdown.fontSize = 28
        BGMdown.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        let BGMup = SKLabelNode(text: "▶︎")
        BGMup.name = "up"
        BGMup.position = CGPoint(x: self.frame.midX * 1.8, y: self.frame.midY * 1.6)
        BGMup.fontSize = 28
        BGMup.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        vol = record.object(forKey: "volOfBGM") as? Float
        let BGMVolume = SKLabelNode(text: String(vol))
        BGMVolume.name = "vol"
        BGMVolume.position = CGPoint(x: self.frame.midX * 1.5, y: self.frame.midY * 1.5)
        BGMVolume.fontSize = 24
        BGMVolume.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)*/
        
        /* SE */
        
        /* Style */
        let StyleNode = SKLabelNode(text: "Style")
        StyleNode.name = "StyleName"
        StyleNode.position = CGPoint(x: self.frame.midX * 0.5, y: self.frame.midY)
        StyleNode.fontSize = 28
        StyleNode.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        let Styledown = SKLabelNode(text: "◀︎")
        Styledown.name = "left"
        Styledown.position = CGPoint(x: self.frame.midX * 0.8, y: self.frame.midY)
        Styledown.fontSize = 28
        Styledown.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        let Styleup = SKLabelNode(text: "▶︎")
        Styleup.name = "right"
        Styleup.position = CGPoint(x: self.frame.midX * 1.8, y: self.frame.midY)
        Styleup.fontSize = 28
        Styleup.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        nowStyle = record.object(forKey: "Style") as? Int
        let style = SKLabelNode(text: styleList[nowStyle])
        style.name = "style"
        style.position = CGPoint(x: self.frame.midX * 1.3, y: self.frame.midY)
        style.fontSize = 24
        style.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        
        /* 回封面 */
        let homeButton = SKSpriteNode(imageNamed: "icons8-home")
        homeButton.name = "home"
        homeButton.position = CGPoint(x: self.frame.midX * 1.8, y: homeButton.size.height)
        
        /* 返回 */
        let leftButton = SKSpriteNode(imageNamed: "icons8-left")
        leftButton.name = "return"
        leftButton.position = CGPoint(x: 0 + leftButton.size.width , y: self.frame.maxY - leftButton.size.height * 1.5)
        
        self.addChild(bg)
        self.addChild(settingNode)
        self.addChild(homeButton)
        self.addChild(leftButton)
        /*self.addChild(BGMNode)
        self.addChild(BGMdown)
        self.addChild(BGMup)
        self.addChild(BGMVolume)*/
        self.addChild(StyleNode)
        self.addChild(Styledown)
        self.addChild(Styleup)
        self.addChild(style)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch?.location(in: self)   // get position

        switch atPoint(touchLocation!).name{
        /*case "down":
            vol -= 1
            if(vol < 0){
                vol = 0
            }
            record.set(vol / 10.0, forKey: "volOfBGM")
        case "up":
            vol += 1
            if(vol > 10){
                vol = 10
            }
            record.set(vol / 10.0, forKey: "volOfBGM")*/
        case "left":
            nowStyle -= 1
            if(nowStyle < 0){
                nowStyle = 0
            }
            record.set(nowStyle, forKey: "Style")
            changeStyle()
        case "right":
            nowStyle += 1
            if(nowStyle >= styleList.count){
                nowStyle = styleList.count - 1
            }
            record.set(nowStyle, forKey: "Style")
            changeStyle()
        case "home":
            //run(touchMusic)
            let scene = HelloScene(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(scene, transition: .fade(withDuration: 1))
        case "return":
            //run(touchMusic)
            let scene = MenuScene(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(scene, transition: .fade(withDuration: 1))
        default:
            break
        }
    }
    
    func changeStyle(){
        let bgnode = self.childNode(withName: "bg") as! SKSpriteNode
        bgnode.texture = SKTexture.init(imageNamed: "background_"+styleList[nowStyle])
        
        let settingNode = self.childNode(withName: "setting") as! SKSpriteNode
        settingNode.texture = SKTexture.init(imageNamed: "SETTING_"+styleList[nowStyle])
        
        let styleNode = self.childNode(withName: "style") as! SKLabelNode
        styleNode.text = styleList[nowStyle]
    }
}
