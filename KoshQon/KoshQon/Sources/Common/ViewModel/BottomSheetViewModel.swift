//
//  BottomSheetViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 19.04.2024.
//

import Foundation

final class BottomSheetViewModel {
    
    // MARK: - Properties
    
    private let type: NavigationCellType
    
    private var options: [NavigationCellViewModel] = []
    
    private var items: [NavigationCellType] {
        return type.associatedCases
    }
        
    // MARK: - Object Lifecycle
    
    init(type: NavigationCellType) {
        self.type = type
    }
        
}

private extension BottomSheetViewModel {
    func getOptions() {
        options = makeCellViewModels(items: items)
    }
    
    func makeCellViewModels(items: [NavigationCellType]) -> [NavigationCellViewModel] {
        return items.compactMap { NavigationCellViewModel(type: $0) }
    }
}
