//
//  RecordSoundViewController.swift
//  PerfectPichApp
//
//  Created by Omar Azookari on 3/28/15.
//  Copyright (c) 2015 Omar Azookari. All rights reserved.
//

import UIKit
import AVFoundation
class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder:AVAudioRecorder!
    @IBOutlet weak var startrecordingButton: UIButton!
    @IBOutlet weak var stoprecordingButton: UIButton!
    @IBOutlet weak var recordingLable: UILabel!
    var recordedAudio:FileName!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib. 
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func recording(sender: AnyObject) {
        recordingLable.hidden=false
        recordingLable.text = "recording"
        stoprecordingButton.hidden=false
        startrecordingButton.enabled=false
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if(flag){
            recordedAudio = FileName.init(givenPath:recorder.url,givenTitle:recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio )
        }else{
            println("failed to record sound")
            stoprecordingButton.hidden=false
            startrecordingButton.enabled=true
        }
    }
    override  func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="stopRecording"){
            let playSoundVC:PlaySoundViewController = segue.destinationViewController as PlaySoundViewController
            let data = sender as FileName
            playSoundVC.recordedAudio = data
        }
    }
    @IBAction func stopRecording(sender: AnyObject) {
        audioRecorder.stop()
        recordingLable.hidden=true
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
    override func viewWillAppear(animated: Bool) {
        stoprecordingButton.hidden=true
        startrecordingButton.enabled=true
        recordingLable.text = "Tap to record"
        recordingLable.hidden=false
    }

}

