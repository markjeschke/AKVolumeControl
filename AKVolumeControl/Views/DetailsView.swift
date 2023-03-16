//
//  DetailsView.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/12/23.
//

import SwiftUI

struct DetailsView: View {

    @State private var isModalOpen: Bool = false

    var body: some View {
        ComponentLayoutView(mixerViewType: .details)
        .sheet(isPresented: $isModalOpen) {
            SettingsView()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isModalOpen.toggle()
                } label: {
                    Text("Settings View \(Image(systemName: "gearshape"))")
                }
            }
        }
        .navigationTitle("Details View")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsView()
                .environmentObject(Conductor())
        }
        .preferredColorScheme(.light)
        .previewDisplayName("Details View Light Mode")
        NavigationView {
            DetailsView()
                .environmentObject(Conductor())
        }
        .preferredColorScheme(.dark)
        .previewDisplayName("Details View Dark Mode")
    }
}
