//
//  VolumeLabelAmount.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/12/23.
//

import SwiftUI

struct VolumeLabelView: View {

    @EnvironmentObject var conductor: Conductor
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Volume".uppercased())
                .font(.caption)
                .fontWeight(.semibold)
            Text(Formatter().floatToPercentage(with: conductor.fullTrackVolume))
                .font(.title)
        }
    }
}

struct VolumeLevelAmount_Previews: PreviewProvider {
    static var previews: some View {
        VolumeLabelView()
            .environmentObject(Conductor())
    }
}
