//
//  VolumeMeterView.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/13/23.
//

import AudioKitUI
import SwiftUI

struct VolumeMeterView: View {

    @EnvironmentObject var conductor: Conductor

    var mixerViewType: MixerViewType = .main

    var body: some View {
        switch mixerViewType {
        case .main:
            FFTView(conductor.mainViewMixerOutput,
                    includeCaps: false,
                    barCount: 20)
        case .details:
            FFTView(conductor.detailViewMixerOutput,
                    includeCaps: false,
                    barCount: 20)
        case .settings:
            FFTView(conductor.settingsViewMixerOutput,
                    includeCaps: false,
                    barCount: 20)
        }
    }
}

struct VolumeMeterView_Previews: PreviewProvider {
    static var previews: some View {
        VolumeMeterView()
            .environmentObject(Conductor())
    }
}
