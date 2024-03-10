//
//  AboutView.swift
//  macControl
//
//  Created by Alejandro Garcia on 23/8/23.
//

import SwiftUI


struct AboutView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading){
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("macControl v1.0")
            Text("Alejandro Garcia - alejandro.garciad75@icloud.com")
            Text("kayros.uno")
            Text("\n\nThis program is a test to control mac systems \n\n")
            
            HStack(alignment: .center)
            {
                Spacer()
                Button("OK", role: .cancel) { dismiss() }
                Spacer()
            }
        }.padding(.all)
    }
}

#Preview {
    AboutView()
}
