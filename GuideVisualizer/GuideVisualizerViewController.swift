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
    
    var analyzer: AKAudioAnalyzer!
    let microphone = AKMicrophone()
    
    let analysisSequence = AKSequence()
    let updateAnalysis = AKEvent()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        if let scene = GuideScene(fileNamed:"GuideScene")
//        {
//            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
//            skView.ignoresSiblingOrder = true
//            scene.scaleMode = .AspectFill
//            
//            //match scene size to view size
//            scene.size = skView.bounds.size
//            
//            skView.presentScene(scene)
//        }
        
        AKSettings.shared().audioInputEnabled = true
        analyzer = AKAudioAnalyzer(input: microphone.output)
        
        AKOrchestra.addInstrument(microphone)
        AKOrchestra.addInstrument(analyzer)
        
        _ = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateFrequency", userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        analyzer.start()
        microphone.start()
    }
    
    func updateFrequency() {
        print(analyzer.trackedFrequency.value)
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
