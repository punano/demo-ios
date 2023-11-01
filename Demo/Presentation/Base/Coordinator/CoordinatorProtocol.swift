//
//  CoordinatorProtocol.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import SwiftUI

protocol DestinationProtocol: Equatable {
  associatedtype Destination: View
  var content: Destination { get }
  var transition: Transition { get }
}

protocol CoordinatorProtocol: View {
  associatedtype MainContent: Coordinatable
  associatedtype Destination: DestinationProtocol
  var mainView: MainContent { get }
  var activeRoute: Destination? { get }
}
