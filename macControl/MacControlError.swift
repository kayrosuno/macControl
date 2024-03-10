//
//  MacControlError.swift
//  macControl
//
//  Created by Alejandro Garcia on 26/8/23.
//

import Foundation

struct MacControlError: Error {
    enum MCError {
        case general
        case internalError
        case fileNotFound
    }


    let stringError: String
    let kind: MCError
//    let column: Int
//    let kind: ErrorKind
}
//
//enum MCError: Error
//{
//        case general
//}
