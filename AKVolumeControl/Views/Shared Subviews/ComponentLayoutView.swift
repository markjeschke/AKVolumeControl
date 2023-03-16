//
//  PlayerLayoutView.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/13/23.
//

import SwiftUI

struct ComponentLayoutView: View {

    @Environment(\.verticalSizeClass) private var verticalSizeClass

    var mixerViewType: MixerViewType = .main
    
    var body: some View {
        VStack {
            Spacer()
            if verticalSizeClass == .regular {
                VStack(spacing: Constant.verticalStackSpacing) {
                    VolumeMeterView(mixerViewType: mixerViewType)
                    VolumeLabelView()
                    VolumeSliderView()
                    UIPlaybackButtons()
                }
            } else {
                HStack {
                    Spacer()
                    VolumeMeterView(mixerViewType: mixerViewType)
                        .padding(.vertical
                        )
                    VStack(spacing: Constant.verticalStackSpacing) {
                        VolumeLabelView()
                        VolumeSliderView()
                        UIPlaybackButtons()
                    }
                }
            }
        }
    }
}

struct ComponentLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentLayoutView()
            .environmentObject(Conductor())
    }
}
