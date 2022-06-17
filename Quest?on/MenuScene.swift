//
//  MenuScene.swift
//  Quest?on
//
//  Created by 李嘉凌 on 2022/5/20.
//

import UIKit
import SpriteKit
import SceneKit

class MenuScene: SKScene, SCNSceneRendererDelegate {
    var touchCount: Int?
    //let touchMusic = SKAction.playSoundFileNamed("pianoE.mp3", waitForCompletion: false)
    let record = UserDefaults.standard
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
        
        let menu = SKSpriteNode(imageNamed: "MENU_"+styleList[style])
        menu.position = CGPoint(x: self.frame.midX, y: self.frame.midY * 1.8)
        
        /* 練習模式 */
        let practiceButton = SKSpriteNode(imageNamed: "practice_"+styleList[style])
        practiceButton.name = "practice"
        practiceButton.position = CGPoint(x: self.frame.midX, y: menu.position.y - 90)
        
        /* 經典模式 */
        let classicButton = SKSpriteNode(imageNamed: "classic_"+styleList[style])
        classicButton.name = "classic"
        classicButton.position = CGPoint(x: self.frame.midX, y: practiceButton.position.y - 90)
        
        /* 挑戰模式 */
        let challengeButton = SKSpriteNode(imageNamed: "challenge_"+styleList[style])
        challengeButton.name = "challenge"
        challengeButton.position = CGPoint(x: self.frame.midX, y: classicButton.position.y - 90)
        
        /* 遊戲紀錄 */
        let recordButton = SKSpriteNode(imageNamed: "record_"+styleList[style])
        recordButton.name = "record"
        recordButton.position = CGPoint(x: self.frame.midX, y: challengeButton.position.y - 90)
        
        /* 遊戲說明 */
        let tutorialButton = SKSpriteNode(imageNamed: "tutorial_"+styleList[style])
        tutorialButton.name = "tutorial"
        tutorialButton.position = CGPoint(x: self.frame.midX, y: recordButton.position.y - 90)
        
        /* 回封面 */
        let homeButton = SKSpriteNode(imageNamed: "icons8-home")
        homeButton.name = "home"
        homeButton.position = CGPoint(x: self.frame.midX * 1.8, y: homeButton.size.height)
        
        /* 設定 */
        let settingButton = SKSpriteNode(imageNamed: "icons8-setting")
        settingButton.name = "setting"
        settingButton.position = CGPoint(x: homeButton.position.x - 60, y: settingButton.size.height)
        
        self.addChild(bg)
        self.addChild(menu)
        self.addChild(practiceButton)
        self.addChild(classicButton)
        self.addChild(challengeButton)
        self.addChild(recordButton)
        self.addChild(tutorialButton)
        self.addChild(settingButton)
        self.addChild(homeButton)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch?.location(in: self)   // get position

        switch atPoint(touchLocation!).name{
        case "practice":
            //run(touchMusic)
            let practiceScene = PracticeMode(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(practiceScene, transition: .fade(withDuration: 1))
        case "classic":
            //run(touchMusic)
            let classicScene = ClassicMode(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(classicScene, transition: .fade(withDuration: 1))
        case "challenge":
            //run(touchMusic)
            let challengeScene = ChallengeMode(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(challengeScene, transition: .fade(withDuration: 1))
        case "record":
            //run(touchMusic)
            let recordScene = GameRecord(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(recordScene, transition: .fade(withDuration: 1))
        case "tutorial":
            //run(touchMusic)
            let tutorialScene = TutorialMode(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(tutorialScene, transition: .fade(withDuration: 1))
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
        default:
            break
        }
    }
    
}
