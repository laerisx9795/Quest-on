//
//  TutorialMode.swift
//  Quest?on
//
//  Created by 李嘉凌 on 2022/5/24.
//

import UIKit
import SpriteKit
import SceneKit

class TutorialMode: SKScene {
    let record = UserDefaults.standard
    //let touchMusic = SKAction.playSoundFileNamed("pianoE.mp3", waitForCompletion: false)
    var page = 0
    let styleList = ["mintchocolate", "polarbear", "strawberrymilk"]
    let title = ["基本說明","練習模式","經典模式","挑戰模式","多人連線"]
    let contentList = ["base_content", "practice_content", "classic_content", "challenge_content", "connect_content"]
    
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
        
        //  基本說明
        let titleNode = SKLabelNode(text: title[page])
        titleNode.name = "title"
        titleNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY * 1.8)
        titleNode.fontSize = 40
        titleNode.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        
        let content = SKSpriteNode(imageNamed: contentList[page])
        content.name = "content"
        content.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        content.size = content.texture!.size()
        
        
        //  頁面切換
        let prevPage = SKLabelNode(text: "◀︎")
        prevPage.name = "prev"
        prevPage.position = CGPoint(x: self.frame.midX - 40, y: self.frame.midY * 0.25)
        prevPage.fontSize = 28
        prevPage.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        let nextPage = SKLabelNode(text: "▶︎")
        nextPage.name = "next"
        nextPage.position = CGPoint(x: self.frame.midX + 40, y: self.frame.midY * 0.25)
        nextPage.fontSize = 28
        nextPage.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        let currPage = SKLabelNode(text: String(page+1) + " / 4")
        currPage.name = "page"
        currPage.position = CGPoint(x: self.frame.midX, y: self.frame.midY * 0.25)
        currPage.fontSize = 24
        currPage.fontColor = UIColor(red: 0.38, green: 0.33, blue: 0.27, alpha: 1.00)
        
        //  返回
        let leftButton = SKSpriteNode(imageNamed: "icons8-left")
        leftButton.name = "left"
        leftButton.position = CGPoint(x: 0 + leftButton.size.width , y: self.frame.maxY - leftButton.size.height * 1.5)
        
        //  首頁
        let homeButton = SKSpriteNode(imageNamed: "icons8-home")
        homeButton.name = "home"
        homeButton.position = CGPoint(x: self.frame.midX * 1.8, y: homeButton.size.height)
        
        /* 設定 */
        let settingButton = SKSpriteNode(imageNamed: "icons8-setting")
        settingButton.name = "setting"
        settingButton.position = CGPoint(x: homeButton.position.x - 60, y: settingButton.size.height)
        
        self.addChild(bg)
        self.addChild(titleNode)
        self.addChild(content)
        self.addChild(homeButton)
        self.addChild(settingButton)
        self.addChild(leftButton)
        self.addChild(prevPage)
        self.addChild(nextPage)
        self.addChild(currPage)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch?.location(in: self)   // get position

        switch atPoint(touchLocation!).name{
        case "prev":
            page -= 1
            if(page < 0){
                page = 0
            }
            changePage()
        case "next":
            page += 1
            if(page >= title.count - 1){
                page = title.count - 2
            }
            changePage()
        case "home":
            //run(touchMusic)
            let scene = HelloScene(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(scene, transition: .fade(withDuration: 1))
        case "setting":
            //run(touchMusic)
            let settingScene = SettingScene(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(settingScene, transition: .fade(withDuration: 1))
        case "left":
            //run(touchMusic)
            let scene = MenuScene(size: self.size)
            self.removeAllChildren()
            self.view?.presentScene(scene, transition: .fade(withDuration: 1))
        default:
            break
        }
    }
    
    func changePage(){
        //  更新頁碼
        let node = self.childNode(withName: "page") as! SKLabelNode
        node.text = String(page+1) + " / 4"
        //  更新標題
        let titlenode = self.childNode(withName: "title") as! SKLabelNode
        titlenode.text = title[page]
        //  更新內容
        let contentnode = self.childNode(withName: "content") as! SKSpriteNode
        contentnode.texture = SKTexture.init(imageNamed: contentList[page])
        contentnode.size = (contentnode.texture?.size())!
    }
}
