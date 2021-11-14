//
//  CViewControllerSpecs.swift
//  Coordinators_Tests
//
//  Created by Raphael Cruzeiro on 18/07/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Quick
import Nimble
import Coordinators

class CViewControllerSpecs: QuickSpec {
    
    class SUTViewController: CViewController {
        
        var wasSetupCalled = false
        var wasSetupStyleCalled = false
        var wasSetupStringsCalled = false
        var wasSetupLayoutCalled = false
        
        override func setup() {
            super.setup()
            wasSetupCalled = true
        }
        
        override func setupStyle() {
            super.setupStyle()
            wasSetupStyleCalled = true
        }
        
        override func setupStrings() {
            super.setupStrings()
            wasSetupStringsCalled = true
        }
        
        override func setupLayout() {
            super.setupLayout()
            wasSetupLayoutCalled = true
        }
        
    }
    
    override func spec() {
        
        describe("CViewControllwe lifecycle") {
            
            var window: UIWindow!
            var sut: SUTViewController!
            
            beforeEach {
                window = UIWindow()
                window.becomeKey()
                sut = SUTViewController()
                let nav = UINavigationController(rootViewController: sut)
                window.rootViewController = nav
                sut.view.backgroundColor = .white // Do something with the view just so that it's initialised
            }
            
            it("should call the setup method") {
                expect(sut.wasSetupCalled).to(beTrue())
            }
            
            it("should call the setup style") {
                expect(sut.wasSetupStyleCalled).to(beTrue())
            }
            
            it("should call the setup strings") {
                expect(sut.wasSetupStringsCalled).to(beTrue())
            }
            
            it("should call the setup layout") {
                expect(sut.wasSetupLayoutCalled).to(beTrue())
            }
            
        }
        
    }
    
}
