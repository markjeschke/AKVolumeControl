//
//  FreePlayView.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/10/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ComponentLayoutView()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        DetailsView()
                    } label: {
                        Text("Details View \(Image(systemName: "chevron.forward"))")
                    }
                }
            }
            .navigationTitle("Main View")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct FreePlayView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Conductor())
            .preferredColorScheme(.light)
            .previewDisplayName("Main View Light Mode")
        MainView()
            .environmentObject(Conductor())
            .preferredColorScheme(.dark)
            .previewDisplayName("Main View Dark Mode")
    }
}
