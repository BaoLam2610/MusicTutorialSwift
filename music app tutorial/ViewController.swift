//
//  ViewController.swift
//  music app tutorial
//
//  Created by Lâm Bảo on 11/05/2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var btnPlaySong: UIButton!
    @IBOutlet weak var seekBar: UISlider!
    
    var player : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = Bundle.main.url(forResource: "CanWeKissForever", withExtension: "mp3")
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url!, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSeekBar), userInfo: nil, repeats: true)
    }
    
    @IBAction func onClickPlaySong(_ sender: Any) {
        
        if player.isPlaying {
            player.stop()
            btnPlaySong.setTitle("Pause", for: .normal)
        } else {
            player.play()
            btnPlaySong.setTitle("Play", for: .normal)
            seekBar.maximumValue = Float(player.duration)
        }
        
    }
    
    @objc func updateSeekBar() {
        seekBar.value = Float(player.currentTime)
    }
    
    @IBAction func onSeekBarChangeListener(_ sender: Any) {
        player.stop()
        player.currentTime = TimeInterval(seekBar.value)
        player.prepareToPlay()
        player.play()
    }
}

