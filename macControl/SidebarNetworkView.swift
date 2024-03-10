//
//  SidebarNetworkView.swift
//  macControl
//
//  Created by Alejandro Garcia on 23/8/23.
//

import SwiftUI

struct SidebarNetworkView: View {
    @Environment(AppData.self) private var appData
    
    var body: some View {
        VStack{
            Text("Network:")
            
            Divider()
            Text("...")
            Spacer()
        }
    }
}

#Preview {
    SidebarNetworkView()
}
