//
//  CircularButton.swift
//  MicroBreaks
//
//  Created by LA on 30.1.2023.
//

import SwiftUI

import SwiftUI

struct CircularButton: View {
    
    let icon: String
    let title: String
    let backgroundColor: Color
    let onPress: () -> Void
    
    var body: some View {
        Button(
          action: {
              onPress()
          }
        ) {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .foregroundColor(Color.black)
                    .font(.system(size: 13, weight: .medium))
            }
            .padding(12)
            .background(backgroundColor)
        }
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(Color.black)
            .cornerRadius(30)
    }
}

struct CircularButton_Previews: PreviewProvider {
    static var previews: some View {
        CircularButton(icon:"ble",title: "TestTitle",backgroundColor: Color.red, onPress: {})
    }
}
