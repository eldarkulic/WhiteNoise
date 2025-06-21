//
//  ViewController.swift
//  WhiteNoiseApp
//
//  Created by Eldar on 21. 6. 2025..
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let circleView = UIView()
    let playButton = UIButton(type: .system)
    let stopButton = UIButton(type: .system)
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Krug
        circleView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        circleView.layer.cornerRadius = 100
        circleView.layer.borderWidth = 4
        circleView.layer.borderColor = UIColor.systemGray4.cgColor
        circleView.backgroundColor = .clear
        view.addSubview(circleView)

        // Play button
        playButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let playImage = UIImage(systemName: "play.fill",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        playButton.setImage(playImage, for: .normal)
        playButton.tintColor = .white
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        view.addSubview(playButton)

        // Stop button
        stopButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let stopImage = UIImage(systemName: "stop.fill",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        stopButton.setImage(stopImage, for: .normal)
        stopButton.tintColor = .white
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        stopButton.isHidden = true // sakrij dok se ne pusti
        view.addSubview(stopButton)

        setupAudioSession()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        circleView.center = view.center
        playButton.center = view.center
        stopButton.center = view.center
    }

    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }

    @objc func playButtonTapped() {
        guard let url = Bundle.main.url(forResource: "whiteNoise", withExtension: "wav") else {
            print("Audio file not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()

            // UI update
            playButton.isHidden = true
            stopButton.isHidden = false

        } catch {
            print("Error initializing audio player: \(error)")
        }
    }

    @objc func stopButtonTapped() {
        audioPlayer?.stop()

        // UI update
        stopButton.isHidden = true
        playButton.isHidden = false
    }
}
