//
//  SettingsView.swift
//  macControl
//
//  Created by Alejandro Garcia on 23/8/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack{
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("kayros.uno")
            Text( "SETTINGS ")
            
        }.frame(width: CGFloat(exactly: 600), height: CGFloat(400),alignment: Alignment.center)
 
    }
}

#Preview {
    SettingsView()
}
