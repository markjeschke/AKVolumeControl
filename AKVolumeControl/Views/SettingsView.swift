//
//  SettingslView.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/12/23.
//

import SwiftUI

struct SettingsView: View {

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            ComponentLayoutView(mixerViewType: .settings)
            // For some reason, modal backgrounds in dark mode appear in dark gray, instead of black.
            .background(colorScheme == .dark
                        ? Color.black
                        : Color(uiColor: .systemBackground))
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    .frame(minWidth: 50, minHeight: 44)
                }
            }
            .navigationTitle("Settings View")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Conductor())
            .preferredColorScheme(.light)
            .previewDisplayName("Settings View Light Mode")
        SettingsView()
            .environmentObject(Conductor())
            .preferredColorScheme(.dark)
            .previewDisplayName("Settings View Dark Mode")
    }
}
