//
//  CHostingViewControllerSpecs.swift
//  Coordinators_Tests
//
//  Created by Raphael Cruzeiro on 18/07/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Quick
import Nimble
import Coordinators

class CHostingViewControllerSpecs: QuickSpec {
    
    class SUTView: UIView {
        
    }
    
    class SUTViewController: CHostingViewController<SUTView> {
        
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
            }
            
            it("should have correct view type") {
                expect(sut.view).to(beAnInstanceOf(SUTView.self))
            }
            
            it("should have the convinience property for getting the view with the correct type") {
                expect(sut.hostedView).to(beAnInstanceOf(SUTView.self))
            }
            
            it("should ensure to reuse the same view object") {
                sut.hostedView.backgroundColor = .red
                expect(sut.hostedView.backgroundColor).to(equal(.red))
            }
            
        }
        
    }
    
}
