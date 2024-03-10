//
//  main.swift
//  kancerbero
//
//  Created by Alejandro Garcia on 17/8/23.
//

import Foundation
import NetworkExtension

autoreleasepool {
    NEProvider.startSystemExtensionMode()
    IPCConnection.shared.startListener()
}

dispatchMain()
