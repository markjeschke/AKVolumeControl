//
//  VolumeSliderView.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/12/23.
//

import SwiftUI

struct VolumeSliderView: View {

    @EnvironmentObject var conductor: Conductor

    var body: some View {
        HStack {
            muteToggleButton
            volumeSlider
            unmuteVolumeButton
        }
        .background(.thinMaterial)
        .font(.body)
        .cornerRadius(Constant.cornerRadiusAmount)
        .padding(.horizontal)
    }

    private var muteToggleButton: some View {
        Button {
            withAnimation {
                conductor.muteTrackVolume()
            }
        } label: {
            Image(systemName: conductor.fullTrackVolume == 0
                  ? "speaker.slash.fill"
                  : "speaker.slash")
        }
        .frame(minWidth: Constant.minimumButtonDimensions,
               minHeight: Constant.minimumButtonDimensions)
    }

    private var volumeSlider: some View {
        Slider(value: $conductor.fullTrackVolume,
               in: 0...1.0) { _ in
            conductor.getRecentTrackVolume()
        }
       .onChange(of: conductor.fullTrackVolume) { newValue in
           conductor.fullTrack.volume = newValue
       }
    }

    private var unmuteVolumeButton: some View {
        Button {
            withAnimation {
                conductor.unmuteTrackVolume()
            }
        } label: {
            Image(systemName: conductor.fullTrackVolume == 0
                  ? "speaker.3"
                  : "speaker.3.fill")
        }
        .frame(minWidth: Constant.minimumButtonDimensions,
               minHeight: Constant.minimumButtonDimensions)
    }
}

struct VolumeSliderView_Previews: PreviewProvider {
    static var previews: some View {
        VolumeSliderView()
            .environmentObject(Conductor())
    }
}
