//
//  Conductor.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/10/23.
//

import AudioKit
import AVFoundation
import Foundation

enum MixerViewType {
    case main
    case details
    case settings
}

final class Conductor: ObservableObject {

    let engine = AudioEngine()
    var fullTrack = AudioPlayer()
    @Published var isTrackPlaying: Bool = false

    // Save the last modified fullTrackVolume level in UserDefaults.
    @Published var fullTrackVolume: Float {
        didSet{
            UserDefaults.standard.set(fullTrackVolume,
                                      forKey: "Full Track Volume")
        }
    }

    // Save the recent track volume level in UserDefaults, if the app closes when the mute toggle has been enabled.
    var recentTrackVolume: Float {
        didSet{
            UserDefaults.standard.set(recentTrackVolume,
                                      forKey: "Recent Track Volume")
        }
    }

    // Save whether isTrackLooping is toggled on or off in UserDefaults.
    @Published var isTrackLooping: Bool {
        didSet{
            UserDefaults.standard.set(isTrackLooping,
                                      forKey: "Loop Track")
        }
    }

    var fileName = "Groove"
    
    var mainViewMixerOutput = Mixer()
    var detailViewMixerOutput = Mixer()
    var settingsViewMixerOutput = Mixer()

    init() {

        // Importing AVFoundation is required in order to access the AVAudioSession settings.
        do {
            Settings.bufferLength = .medium
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
        isTrackLooping = UserDefaults.standard.object(forKey: "Loop Track") as? Bool ?? true // <- Loop the track by default.
        recentTrackVolume = UserDefaults.standard.object(forKey: "Recent Track Volume") as? Float ?? 1.0 // <- The initial volume level is 1.0

        fullTrackVolume = recentTrackVolume
        fullTrack.volume = fullTrackVolume
        fullTrack.isLooping = isTrackLooping
        fullTrack.completionHandler = commenceWhenCompleted

        mainViewMixerOutput = Mixer(fullTrack)
        detailViewMixerOutput = Mixer(mainViewMixerOutput)
        settingsViewMixerOutput = Mixer(detailViewMixerOutput)

        engine.output = settingsViewMixerOutput
        loadFile()

        try? engine.start()
    }

    func loadFile() {
        do {
            if let fileURL = Bundle.main.url(forResource: "Samples/\(fileName)", withExtension: "m4a") {
                try fullTrack.load(url: fileURL)
            } else {
                Log("Could not find file")
            }
        } catch {
            Log("Could not load full track")
        }
    }

    // MARK: Call this when the track is completed

    func commenceWhenCompleted() {
        if !isTrackLooping {
            stopTrack()
        }
    }

    func stopTrack() {
        fullTrack.stop()
        isTrackPlaying = false
    }

    // MARK: User Intents triggered from the views

    func stopPlayer() {
        if isTrackPlaying {
            fullTrack.stop()
            fullTrack.play()
        } else {
            stopTrack()
        }
    }

    func playPausePlayerToggle() {
        isTrackPlaying
        ? fullTrack.pause()
        : fullTrack.play()
        isTrackPlaying.toggle()
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

    func loopTrackToggle() {
        fullTrack.isLooping = isTrackLooping
        ? false
        : true
        isTrackLooping.toggle()
    }

    // Triggered from the volume slider
    func getRecentTrackVolume() {
        recentTrackVolume = fullTrackVolume
    }
}
