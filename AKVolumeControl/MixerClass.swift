//
//  MixerClass.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/10/23.
//

import AudioKit
import AVFoundation
import Foundation

class Conductor: ObservableObject {

    let engine = AudioEngine()
    var fullTrack = AudioPlayer()
    @Published var isFullTrackPlaying: Bool = false
    // Persist the last fullTrackVolume setting in UserDefaults, even if you quit and restart the app.
    @Published var fullTrackVolume: Float {
        didSet{
            UserDefaults.standard.set(fullTrackVolume, forKey: "Full Track Volume")
        }
    }
    
    @Published var recentTrackVolume: Float = 1.0

    init() {
        // Importing AVFoundation is required in order to access the AVAudioSession settings.
        do {
            Settings.bufferLength = .short
            try AVAudioSession.sharedInstance().setPreferredIOBufferDuration(Settings.bufferLength.duration)
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord,
                                                            options: [.defaultToSpeaker,
                                                                      .mixWithOthers,
                                                                      .allowBluetoothA2DP])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let err {
            print(err)
        }

        fullTrackVolume = UserDefaults.standard.object(forKey: "Full Track Volume") as? Float ?? 1.0 // <- The initial volume level is 1.0
        fullTrack.isLooping = true
        fullTrack.volume = fullTrackVolume
        engine.output = fullTrack
        loadFiles()

        try? engine.start()
    }

    func loadFiles() {
        do {
            if let fileURL = Bundle.main.url(forResource: "Samples/Isolated-Association", withExtension: "m4a") {
                try fullTrack.load(url: fileURL)
            } else {
                Log("Could not find file")
            }
        } catch {
            Log("Could not load full track")
        }
    }

    func playStopPlayerToggle() {
        isFullTrackPlaying ? fullTrack.stop() : fullTrack.start()
        isFullTrackPlaying.toggle()
    }

    func muteTrackVolume() {
        if fullTrackVolume != 0 {
            fullTrackVolume = 0
            fullTrack.volume = fullTrackVolume
        } else {
            unmuteTrackVolume()
        }
    }

    func unmuteTrackVolume() {
        fullTrackVolume = recentTrackVolume
        fullTrack.volume = fullTrackVolume
    }

    func setTrackVolume() {
        recentTrackVolume = fullTrackVolume
        fullTrack.volume = fullTrackVolume
    }
}
