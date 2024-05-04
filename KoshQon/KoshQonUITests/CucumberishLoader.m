//
//  CucumberishLoader.m
//  KoshQonUITests
//
//  Created by Almat Begaidarov on 20.04.2024.
//

#import "KoshQonUITests-Swift.h"

__attribute__((constructor))
void CucumberishInit(void) {
    
    [CucumberishInitializer setupCucumberish];
}
