//
//  GameViewController.swift
//  FlamePrototype
//
//  Created by Andrew Campoli on 8/27/15.
//  Copyright (c) 2015 Harmony. All rights reserved.
//

import UIKit
import SpriteKit

class GuideVisualizerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GuideScene(fileNamed:"GuideScene")
        {
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .AspectFill
            
            //match scene size to view size
            scene.size = skView.bounds.size
            
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
