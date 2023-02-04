//
//  GitHubSettingsFooter.swift
//  MicroBreaks
//
//  Created by LA on 30.1.2023.
//

import SwiftUI

struct GitHubFooter: View {
    @Environment(\.openURL) var openURL
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
            openURL(
                URL(string: "https://github.com/larussverris/MicroBreaks")!
            )
        }) {
            
            Image(
                colorScheme == .dark
                ? "logo-github-light"
                : "logo-github-dark"
            )
                .resizable()
                .frame(width: 32.0, height: 32.0)
        }
        .padding()
        .buttonStyle(PlainButtonStyle())
        
        Text("Built with open-source love. Contributions welcome.")
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct GitHubFooter_Previews: PreviewProvider {
    static var previews: some View {
        GitHubFooter()
    }
}
