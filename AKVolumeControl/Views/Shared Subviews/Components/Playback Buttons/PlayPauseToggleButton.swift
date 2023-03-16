//
//  PlayStopToggleButtonView.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/12/23.
//

import SwiftUI

struct PlayPauseToggleButton: View {

    @EnvironmentObject var conductor: Conductor

    var body: some View {
        Button(action: {
            conductor.playPausePlayerToggle()
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        }) {
            Image(systemName: conductor.isTrackPlaying
                  ? "pause.fill"
                  : "play.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .frame(maxWidth: Constant.minimumPlayStopButtonDimensions,
                       maxHeight: Constant.minimumPlayStopButtonDimensions)
        }
        .accessibility(label: Text("Play and pause audio toggle."))
        .padding()
    }
}

struct PlayPauseToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayPauseToggleButton()
            .environmentObject(Conductor())
    }
}
