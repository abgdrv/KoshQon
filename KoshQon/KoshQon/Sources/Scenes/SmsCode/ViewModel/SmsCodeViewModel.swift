//
//  SmsCodeViewModel.swift
//  KoshQon
//
//  Created by Almat Begaidarov on 22.02.2024.
//

import Foundation
import Combine

final class SmsCodeViewModel {
    
    // MARK: - Properties
    
    @Published private(set) var seconds = 60
    var timeString: String {
        let prodMinutes = seconds / 60 % 60
        let prodSeconds = seconds % 60
        return String(format: "%02d:%02d", prodMinutes, prodSeconds)
    }
    
    func secondsDecrement() {
        seconds -= 1
    }
    
    func isTimerRunning() -> Bool {
        return seconds > 0
    }
    
    func resetTimer() {
        seconds = 60
    }
    
}
