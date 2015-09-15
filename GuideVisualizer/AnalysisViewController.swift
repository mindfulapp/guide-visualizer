//
//  AnalysisViewController.swift
//  AudioKitDemo
//
//  Created by Nicholas Arner on 3/1/15.
//  Copyright (c) 2015 AudioKit. All rights reserved.
//
import AVFoundation

class AnalysisViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet var amplitudePlot: AKInstrumentPropertyPlot!

    let microphone = AKMicrophone()
    var analyzer: AKAudioAnalyzer!

    let analysisSequence = AKSequence()
    let updateAnalysis = AKEvent()
    
    var audioPlayer: AVAudioPlayer!
    
    let audioFile = "beta-2"
    let audioFileType = "wav"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        
        let file = NSBundle.mainBundle().pathForResource(audioFile + "A", ofType: audioFileType)
        let fileTable = AKSoundFileTable(filename: file)
        
        let looper = AKMonoSoundFileLooper(soundFile: fileTable)
        looper.loopMode = AKMonoSoundFileLooper.loopRepeats()
        analyzer = AKAudioAnalyzer(input: looper)

        AKOrchestra.addInstrument(analyzer)
        amplitudePlot.property = analyzer.trackedAmplitude
        
        setupAudioPlayer()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        analyzer.start()
        audioPlayer.play()
    }

    func setupAudioPlayer() {
        do {
            if let URL = NSBundle.mainBundle().URLForResource(audioFile, withExtension: "m4a")
            {
                try audioPlayer = AVAudioPlayer(contentsOfURL: URL)
                audioPlayer.delegate = self
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
            }
            else
            {
                print("url failed")
            }
        } catch {
            print("AudioPlayer failed to initialize.")
        }
    }
}
