//
//  FilterPacketProvider.swift
//  kancerbero
//
//  Created by Alejandro Garcia on 17/8/23.
//

import NetworkExtension
import os

class FilterPacketProvider: NEFilterPacketProvider {
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "uno.kayros.macControl", category: "extension")
    
    override func startFilter(completionHandler: @escaping (Error?) -> Void) {

		packetHandler = { (context, interface, direction, packetBytes, packetLength) in
			return .allow
		}
		completionHandler(nil)
        
        logger.notice("kancerbero started")
    }
    
    override func stopFilter(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {

		// Add code here to tear down the filter
        completionHandler()
        logger.notice("kancerbero  stopped")
    }
}
