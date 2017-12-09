//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Vinizzle on 12/6/17.
//  Copyright © 2017 OkraLabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopRecordButton: UIButton!
    
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
    }

    @IBAction func stopRecording(sender: AnyObject) {
        print("Stop record was pressed!")
        recordingLabel.text = "Recording Stopped"
        recordButton.enabled = true
        stopRecordButton.enabled = false
    }
    
}

