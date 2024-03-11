//
//  mainView.swift
//  macControl
//
//  Created by Alejandro Garcia on 17/8/23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject  var appData: AppData
    
    var body: some View {
        NavigationSplitView(
            sidebar: {SidebarView()},
            detail:  {NavigationStack (path: $appData.path) {
                
                Text("Choose one activity")
                
                    .navigationDestination(for: TipoVistaActiva.self) { tipo in
                        switch (tipo)
                        {
                        case TipoVistaActiva.network:
                           // NavigationSplitView(sidebar: {SidebarNetworkView()}, detail:{
                            NetworkView()//})
                            .navigationSubtitle("Network")
                            .navigationBarBackButtonHidden(true)
                            
                        case TipoVistaActiva.storage:
                           //NavigationSplitView(sidebar: {SidebarStorageView()}, detail:{
                            StorageView()//})
                            .navigationSubtitle("Storage")
                            .navigationBarBackButtonHidden(true)
                            
                        case TipoVistaActiva.daemons:
                            //NavigationSplitView(sidebar: {SidebarDaemonsView()}, detail:{
                                DaemonsView()//})
                                .navigationSubtitle("Daemons")
                               .navigationBarBackButtonHidden(true)
                            
                        default:
                            Text("Otro")
                        }
                    }
                    .navigationTitle("macControl")
            }
                
            })
        
    }
        
}
