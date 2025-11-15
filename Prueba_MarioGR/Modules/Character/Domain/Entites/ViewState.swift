//
//  ViewState.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/12/25.
//

enum ViewState: Equatable {
    case idle
    case loading
    case loaded
    case empty
    case error(String)
}
