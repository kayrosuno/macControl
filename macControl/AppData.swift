//
//  AppData.swift
//  qping-gui
//
//  Created by Alejandro Garcia on 18/2/24.
//

import Foundation
import SwiftUI
import SwiftData





//Los tipos de VistaActiva
enum TipoVistaActiva
{
    case network //Vista del networking
    case storage //Vista del storage
    case start    //Vista inicial
    case daemons //Vista agents & daemons
}



///
///Datos de la apliucación, observable.
@Observable
class AppData: Identifiable, ObservableObject {
   
    var showAboutView = false
    var showReloadView = false
    var vistaActiva = TipoVistaActiva.network
    var controller = Controller()
    
    //var showProgressQPing = false
    var runPing = false  //Ejecutar el QpingClient
    var path: NavigationPath
//    var vistaActiva = TipoVistaActiva.root
//    var selectedCluster: ClusterK8SData?
//    var editCluster: ClusterK8SData?
//    var clusterRunning: ClusterK8S?
    var QUIC_UDP = true
    //var estadoCluster = "Stop"
    //var qpingOutputNode = ""
    var sendInterval = 1000.0 //ms, default 1000ms=1seg
    var sidebarbackground: (any View)?
    var selectionProtocol = "QUIC+UDP"
   // var nodeSelected = ""
    
    //Para visualizar, datos en clusterk8s
    var actualRTT = 0.0  //Min RTT del cluster
//    var minRTT = 0.0  //Min RTT del cluster
//    var medRTT = 0.0
//    var maxRTT = 100.0  //Max RTT del cluster
//    //var muestras = 100.0  //Max RTT del cluster
    
    init(path: NavigationPath){
        self.path = path
    }
}


extension Formatter {
    static let number = NumberFormatter()
}

extension FloatingPoint {
    func fractionDigitsRounded(to digits: Int, roundingMode:  NumberFormatter.RoundingMode = .halfEven) -> String {
        Formatter.number.roundingMode = roundingMode
        Formatter.number.minimumFractionDigits = digits
        Formatter.number.maximumFractionDigits = digits
        return Formatter.number.string(for:  self) ?? ""
    }
}
