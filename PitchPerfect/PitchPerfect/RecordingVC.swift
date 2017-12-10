//
//  RecordingVC.swift
//  PitchPerfect
//
//  Created by Vinizzle on 12/6/17.
//  Copyright © 2017 OkraLabs. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingVC: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopRecordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(sender: AnyObject) {
        print("Record button was pressed!")
        recordingLabel.text = "Recording in Progress"
        recordButton.isEnabled = false
        stopRecordButton.isEnabled = true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        
        let pathArray = [dirPath, recordingName]
        
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        print(filePath?.absoluteURL as Any)
        
        let session = AVAudioSession.sharedInstance()
                
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath! as URL, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecording(sender: AnyObject) {
        print("Stop record was pressed!")
        recordingLabel.text = "Recording Stopped"
        recordButton.isEnabled = true
        stopRecordButton.isEnabled = false
        audioRecorder.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            print("Finished recording")
            performSegue(withIdentifier: "stopRecordingg", sender: audioRecorder.url)
        } else {
            print("Something went wrong with recording.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Pre")
        print(segue.identifier)
        if (segue.identifier == "stopRecordingg") {
            let playingVC = segue.destination as! PlayingVC
            let recordedAudioURL = sender as! NSURL
            
            playingVC.recordedAudioURL = recordedAudioURL
        }
    }
}

