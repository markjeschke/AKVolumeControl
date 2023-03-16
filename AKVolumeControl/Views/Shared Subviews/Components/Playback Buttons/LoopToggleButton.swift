//
//  LoopToggleButton.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/13/23.
//

import SwiftUI

struct LoopToggleButton: View {

    @EnvironmentObject var conductor: Conductor
    
    var body: some View {
        Button(action: {
            conductor.loopTrackToggle()
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        }) {
            Image(systemName: "repeat")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .background(conductor.isTrackLooping
                            ? Color.blue : Color.clear)
                .cornerRadius(20)
                .foregroundColor(conductor.isTrackLooping ? .white : .blue)
                .frame(maxWidth: Constant.minimumPlayStopButtonDimensions,
                       maxHeight: Constant.minimumPlayStopButtonDimensions)
        }
        .accessibility(label: Text("Loop toggle. Looping is \(conductor.isTrackLooping ? "enabled" : "disabled")"))
        .padding()
    }
}

struct LoopToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        LoopToggleButton()
            .environmentObject(Conductor())
    }
}
