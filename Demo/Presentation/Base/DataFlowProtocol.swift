//
//  DataFlowProtocol.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import Foundation

protocol DataFlowProtocol {
    associatedtype InputType
    func apply(_ input: InputType)
}
