//
//  SidebarView.swift
//  macControl
//
//  Created by Alejandro Garcia on 24/8/23.
//

import SwiftUI

struct SidebarView: View {
    @Environment(AppData.self) private var appData
    
    var body: some View {
        switch (appData.vistaActiva)
        {
        case TipoVistaActiva.network:
            SidebarNetworkView()
            
        case TipoVistaActiva.storage:
            SidebarStorageView()
            
        case TipoVistaActiva.daemons:
            SidebarDaemonsView()
        
        case .start:
            Text("?")
        }
    }
}

#Preview {
    SidebarView()
}
