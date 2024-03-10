//
//  macControlApp.swift
//  macControl
//
//  Created by Alejandro Garcia on 17/8/23.
//

import SwiftUI
import SwiftData
import os

@main
struct macControlApp: App {
    @State private var appData = AppData()
    @State var path = NavigationPath()
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "uno.kayros.macControl", category: "app")
    
    
    var body: some Scene {
        WindowGroup {
            RootView(path: $path)
            //.modelContainer(for: Item.self)
                .environment(appData)
                .sheet(isPresented: $appData.showAboutView){ AboutView() }
                .toolbar{
                    ToolbarItem(placement: .principal)  //Network
                    {
                        Button {
                            if !path.isEmpty { path.removeLast() }
                            path.append(TipoVistaActiva.network)
                            appData.vistaActiva = TipoVistaActiva.network
                            
                        } label: {
                            HStack{
                                Image(systemName: "network")
                                Text("Network")
                            }
                        }
                        
                        .background(appData.vistaActiva == TipoVistaActiva.network ? Color.accentColor : Color.clear).cornerRadius(8)
                    }
                    
                    ToolbarItem(placement: .principal)  //Storage
                    {
                        Button {
                            if !path.isEmpty { path.removeLast() }
                            path.append(TipoVistaActiva.storage)
                            appData.vistaActiva = TipoVistaActiva.storage
                            
                        } label: {
                            HStack{
                                Image(systemName: "internaldrive")
                                Text("Storage")
                            }
                        }
                        .background(appData.vistaActiva == TipoVistaActiva.storage ? Color.accentColor : Color.clear).cornerRadius(8)
                        
                    }
                    ToolbarItem(placement: .principal)  //Daemons
                    {
                        Button {
                            if !path.isEmpty { path.removeLast() }
                            path.append(TipoVistaActiva.daemons)
                            appData.vistaActiva = TipoVistaActiva.daemons
                            
                        } label: {
                            HStack{
                                Image(systemName: "cpu")
                                Text("Daemons")
                            }
                        }
                        .background(appData.vistaActiva == TipoVistaActiva.daemons ? Color.accentColor : Color.clear).cornerRadius(8)
                        
                    }
                    
                    //                    ToolbarItem()  //Spacer
                    //                    {
                    //                       Spacer()
                    //                    }
                    ToolbarItem(placement: .cancellationAction,
                                content: //Info
                                {
                        Button(action: {
                            appData.showAboutView = true
                        },label: {Image(systemName: "info.circle")})
                    }
                    )
                    
                    
                } //toolbar
            //Primera vista
                .onAppear{path.append(TipoVistaActiva.network)
                    logger.notice("macControl starting and showing")
                }
            
        }
        .commands {
            //            CommandGroup(after: .appInfo) {
            //                SparkleView(updater: updaterController.updater)
            //                Divider()
            //                Button("open.setup") {
            //                    showSetup = true
            //                }
            //            }
            //            CommandGroup(after: .newItem) {
            //                Button("open.bottle") {
            //                    let panel = NSOpenPanel()
            //                    panel.canChooseFiles = false
            //                    panel.canChooseDirectories = true
            //                    panel.allowsMultipleSelection = false
            //                    panel.canCreateDirectories = false
            //                    panel.begin { result in
            //                        if result == .OK {
            //                            if let url = panel.urls.first {
            //                                BottleVM.shared.bottlesList.paths.append(url)
            //                                BottleVM.shared.bottlesList.encode()
            //                                BottleVM.shared.loadBottles()
            //                            }
            //                        }
            //                    }
            //                }
            //                .keyboardShortcut("I", modifiers: [.command])
            //            }
            CommandGroup(after: .importExport) {
                Button("Open Logs") {
                    macControlApp.openLogsFolder()
                }
                .keyboardShortcut("L", modifiers: [.command])
                //                Button("kill.bottles") {
                //                    WhiskyApp.killBottles()
                //                }
                //                .keyboardShortcut("K", modifiers: [.command, .shift])
                //                Button("wine.clearShaderCaches") {
                //                    WhiskyApp.killBottles() // Better not make things more complicated for ourselves
                //                    WhiskyApp.wipeShaderCaches()
                //                }
                
            }
            
            
            
        }//commands
        
        
        
        //Otro grupo de ventanas
        WindowGroup("Content2") {
            ContentView2()
        }
        
#if os(macOS)
        //Ventana Settings
        Settings() {
            SettingsView()
        }
#endif
    }
    
    
    
    static func openLogsFolder() {
        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: Log.logsFolder.path)
    }
} //struct



@Observable
class AppData: Identifiable {
    //var path = NavigationPath()
    var showAboutView = false
    var showReloadView = false
    var vistaActiva = TipoVistaActiva.network
}

//Los tipos de VistaActiva
enum TipoVistaActiva
{
    case network //Vista del networking
    case storage //Vista del storage
    case start    //Vista inicial
    case daemons //Vista agents & daemons
}
