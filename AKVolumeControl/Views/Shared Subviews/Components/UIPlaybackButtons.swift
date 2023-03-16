//
//  VolumeButtons.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/13/23.
//

import SwiftUI

struct UIPlaybackButtons: View {
    var body: some View {
        HStack(spacing: 0) {
            RewindBackButton()
            PlayPauseToggleButton()
            LoopToggleButton()
        }
    }
}

struct VolumeButtons_Previews: PreviewProvider {
    static var previews: some View {
        UIPlaybackButtons()
            .environmentObject(Conductor())
    }
}
