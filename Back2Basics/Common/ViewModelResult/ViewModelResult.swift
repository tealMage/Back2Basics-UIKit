//
//  ViewModelResult.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/10/21.
//

import Foundation
enum ViewModelResult<LoadedObject: Equatable>: Equatable {
    case loading
    case loaded(LoadedObject)
    case failed(String)
}

enum ViewModelResultWithPrompt<LoadedObject: Equatable>: Equatable {
    case needsConfirmation   // Prompt the user before starting process.  i.e. Do you want to delete?
    case loading
    case loaded(LoadedObject)
    case failed(String)
}
