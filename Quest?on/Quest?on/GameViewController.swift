//
//  GameViewController.swift
//  Quest?on
//
//  Created by 李嘉凌 on 2022/5/19.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFAudio

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* initialize data */
        /* only once */
        let record = UserDefaults.standard
        let initialized = record.bool(forKey: "initialized")
        
        if !initialized{
            record.set(nil, forKey: "totalNumOfPracticeQuestion")
            record.set(nil, forKey: "totalNumOfPracticeCorrectAns")
            record.set(nil, forKey: "totalNumOfClassicQuestion")
            record.set(nil, forKey: "totalNumOfClassicCorrectAns")
            record.set(nil, forKey: "largestNumOfClassicClearedQuestion")
            record.set(nil, forKey: "timeOfClassicCleared")
            record.set(nil, forKey: "totalNumOfChallengeQuestion")
            record.set(nil, forKey: "totalNumOfChallengeCorrectAns")
            record.set(nil, forKey: "largestNumOfChallengeClearedQuestion")
            record.set(nil, forKey: "timeOfChallengeCleared")
            record.set(nil, forKey: "shortestTimeOfChallengeClear")

            record.set(1.0, forKey: "volOfBGM")
            record.set(0, forKey: "Style")
            
            record.set(true, forKey: "initialized")
        }
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = HelloScene(size: view.bounds.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFit
            // Present the scene
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

}
