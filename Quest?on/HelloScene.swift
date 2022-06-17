//
//  HelloScene.swift
//  Quest?on
//
//  Created by 李嘉凌 on 2022/5/19.
//

import UIKit
import SpriteKit
import SceneKit
import AVFoundation

class HelloScene: SKScene {
    
    //let touchMusic = SKAction.playSoundFileNamed("pianoE.mp3", waitForCompletion: false)
    let record = UserDefaults.standard
    let styleList = ["mintchocolate", "polarbear", "strawberrymilk"]
    
    override func didMove(to view: SKView) {    // when the scene is about to presented by GameViewController(SKView)
        createScene()
    }
    
    func createScene(){ // scene initailization
        let style = record.object(forKey: "Style") as! Int
        //let bg = SKSpriteNode(imageNamed: "cover_mintchocolate")
        let bg = SKSpriteNode(imageNamed: "cover_"+styleList[style])
        bg.size.width = self.size.width
        bg.size.height = self.size.height
        bg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bg.zPosition = -1
        
        let octahedronNode = SK3DNode(viewportSize: CGSize(width: 350, height: 350))
        octahedronNode.name = "octahedron"
        octahedronNode.scnScene = SCNScene(named: "gameassets.scnassets/octahedron.dae")!
        octahedronNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY * 1.5)
        //octahedronNode.scnScene?.rootNode.childNodes.first?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "gameassets.scnassets/octahedron_mintchocolate.png")
        octahedronNode.scnScene?.rootNode.childNodes.first?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "gameassets.scnassets/octahedron_"+styleList[style]+".png")
        
        let rotateAction = SCNAction.sequence([SCNAction.rotateTo(x: 0, y: (30 * .pi)/180, z: 0, duration: 0), SCNAction.rotateBy(x: 0, y: 0, z: (40 * .pi)/180, duration: 0)])
        octahedronNode.scnScene?.rootNode.runAction(rotateAction)
        
        let rotateForever = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: .pi, z: 0, duration: 10))
        octahedronNode.scnScene?.rootNode.runAction(rotateForever)
       
        
        self.addChild(bg)
        self.addChild(octahedronNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //run(touchMusic)
        let objectNode = self.childNode(withName: "octahedron")
        let wait = SKAction.wait(forDuration: 0.1)
        let remove = SKAction.removeFromParent()
        let movesequence = SKAction.sequence([wait, remove])
        objectNode?.run(movesequence, completion: {
            let menuScene = MenuScene(size: self.size)
            self.view?.presentScene(menuScene, transition: .fade(withDuration: 1))
        })
    }
}
