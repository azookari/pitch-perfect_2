//
//  PlaySoundViewController.swift
//  PerfectPichApp
//
//  Created by Omar Azookari on 4/5/15.
//  Copyright (c) 2015 Omar Azookari. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    var player:AVAudioPlayer!
    var recordedAudio:FileName!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recordedAudio.filePathUrl, error: nil)

        player = AVAudioPlayer(contentsOfURL: recordedAudio.filePathUrl, error: nil)
        player.enableRate = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: AnyObject) {
   
     playCommon(0.5)
        
    }
    @IBAction func soundEffectChip(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }
    @IBAction func playFast(sender: AnyObject) {
     playCommon(2.0)
    }
    func playCommon(rate: Float) {
        audioEngine.stop()
        audioEngine.reset()
        player.stop()
        player.currentTime=0.0
        player.rate = rate
        player.play()
        
    }

    @IBAction func stopPlaying(sender: AnyObject) {
        player.stop()
        audioEngine.stop()
        audioEngine.reset()
        player.currentTime=0.0
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        player.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    @IBAction func playDarth(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
