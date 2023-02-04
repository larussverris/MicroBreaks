//
//  AllowNotificationsMessage.swift
//  MicroBreaks
//
//  Created by LA on 1.2.2023.
//

import SwiftUI

struct AllowNotificationsMessage: View {
    var body: some View {
        HStack {
            Image(systemName: "info.circle.fill")
            Text("In order to get the most out of the app, we recommend enabling notifications in the system settings.")
        }
        .padding(.top, 1)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct AllowNotificationsMessage_Previews: PreviewProvider {
    static var previews: some View {
        AllowNotificationsMessage()
    }
}
