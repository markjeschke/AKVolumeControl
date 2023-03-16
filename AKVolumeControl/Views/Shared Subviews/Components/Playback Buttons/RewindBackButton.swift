//
//  StopButton.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/13/23.
//

import SwiftUI

struct RewindBackButton: View {

    @EnvironmentObject var conductor: Conductor
    
    var body: some View {
        Button(action: {
            conductor.stopPlayer()
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        }) {
            Image(systemName: "backward.end.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .frame(maxWidth: Constant.minimumPlayStopButtonDimensions,
                       maxHeight: Constant.minimumPlayStopButtonDimensions)
        }
        .accessibility(label: Text("Rewind to the start."))
        .padding()
    }
}

struct StopButton_Previews: PreviewProvider {
    static var previews: some View {
        RewindBackButton()
            .environmentObject(Conductor())
    }
}
