//
//  Coordinatable.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import Foundation

import SwiftUI

// implemented by routes enum inside each view
protocol Routing: Equatable {}

// implemented by the view that has routes
protocol Coordinatable: View {
  associatedtype Route: Routing
}
