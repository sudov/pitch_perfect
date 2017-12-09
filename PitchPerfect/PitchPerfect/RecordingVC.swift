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
        stopRecordButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(sender: AnyObject) {
        print("Record button was pressed!")
        recordingLabel.text = "Recording in Progress"
        recordButton.enabled = false
        stopRecordButton.enabled = true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        
        let pathArray = [dirPath, recordingName]
        
        let filePath = NSURL(string: pathArray.joinWithSeparator("/"))
        
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: .DefaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    @IBAction func stopRecording(sender: AnyObject) {
        print("Stop record was pressed!")
        recordingLabel.text = "Recording Stopped"
        recordButton.enabled = true
        stopRecordButton.enabled = false
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            print("Finished recording")
            performSegueWithIdentifier("stopRecordingg", sender: audioRecorder.url)
        } else {
            print("Something went wrong with recording.")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue == "stopRecording") {
            let playingVC = segue.destinationViewController as! PlayingVC
            let recordedAudioURL = sender as! NSURL
            playingVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}

