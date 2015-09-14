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
    
    var guideScene: GuideScene!

    var analyzer: AKAudioAnalyzer!
    let microphone = AKMicrophone()
    
    var visualizerTimer: NSTimer!
    var frequency: CGFloat!
    var amplitude: CGFloat!
    
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
            
            guideScene = scene
        }
        
        AKSettings.shared().audioInputEnabled = true
        analyzer = AKAudioAnalyzer(input: microphone.output)
        
        AKOrchestra.addInstrument(microphone)
        AKOrchestra.addInstrument(analyzer)
        
        performSelector("beginVisualizer", withObject: self, afterDelay: 2.0)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        analyzer.start()
        microphone.start()
    }
    
    func beginVisualizer() {
        
        visualizerTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateVisualizer", userInfo: nil, repeats: true)
    }
    
    func updateVisualizer() {
        
        frequency = CGFloat(analyzer.trackedFrequency.value)
        amplitude = CGFloat(analyzer.trackedAmplitude.value)
        
        let amplitudeConstant: CGFloat = 750.0
        
        guideScene.guideEmitterController.animateWidth(amplitude * amplitudeConstant, bounciness: 10.0, speed: 20.0)
        guideScene.guideEmitterController.animateHeight(amplitude * amplitudeConstant, bounciness: 10.0, speed: 20.0)
        
        let frequencyColor = UIColor(red: frequency / 255, green: 0.5, blue: 0.5, alpha: 1.0)
        
        guideScene.animateLastColorInColorRamp(frequencyColor)
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
