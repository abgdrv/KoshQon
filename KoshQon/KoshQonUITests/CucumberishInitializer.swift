//
//  CucumberishInitializer.swift
//  KoshQonUITests
//
//  Created by Almat Begaidarov on 20.04.2024.
//

import XCTest
import Foundation
import Cucumberish

class CucumberishInitializer: NSObject {
    
    @objc class func setupCucumberish() {
        
        before { _ in
            
            Given("I am a user of the application") { args, _ in
                XCTAssert(true)
            }
            
            When("I launch the application") { args, _ in
                XCUIApplication().launch()
            }
            
            But("I have already been logged in the system") { args, _ in
                XCTAssert(true)
            }
            
            Then("I should be taken to the PIN code page") { args, _ in
                XCTAssert(true)
            }
            
        }
        
        let bundle = Bundle(for: CucumberishInitializer.self)
        Cucumberish.executeFeatures(
            inDirectory: "Features",
            from: bundle,
            includeTags: nil,
            excludeTags: nil
        )
        
    }
    
}
