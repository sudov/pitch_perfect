//
//  PlayingVC.swift
//  PitchPerfect
//
//  Created by Vinizzle on 12/9/17.
//  Copyright © 2017 OkraLabs. All rights reserved.
//

import UIKit
import AVFoundation

class PlayingVC: UIViewController {
    
    var recordedAudioURL: NSURL!
    
    @IBOutlet weak var slowButton: UIButton!
    
    @IBOutlet weak var fastButton: UIButton!
    
    @IBOutlet weak var highPitchButton: UIButton!
    
    @IBOutlet weak var lowPitchButton: UIButton!
    
    @IBOutlet weak var echoButton: UIButton!
    
    @IBOutlet weak var reverbButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, highPitch, lowPitch, echo, reverb
    }
    
    
    @IBAction func playSoundForButton(sender: UIButton) {
        print("Play Sound Button Pressed")
        switch (ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .highPitch:
            playSound(pitch:1000)
        case .lowPitch:
            playSound(pitch:-1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(playState: .playing)
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
        print("Stop Audio Button Pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let microPhoneStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
        
        switch microPhoneStatus {
        case .authorized:
            print("Authorized") // Has access
            break
        case .denied:
            print("Denied") // No access granted
            break
        case .restricted:
            print("Restricted") // Microphone disabled in settings
            break
        case .notDetermined:
            print("Not Determined") // Didn't request access yet
            break
        }
        print(recordedAudioURL.absoluteURL as Any)
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(playState: .notPlaying)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
