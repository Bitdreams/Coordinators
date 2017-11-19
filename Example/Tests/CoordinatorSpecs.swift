// https://github.com/Quick/Quick

import UIKit
import Quick
import Nimble
import Coordinators

class CoordinatorSpecs: QuickSpec {
    
    class CoordinatorA: UICoordinator {  }
    class CoordinatorB: UICoordinator {  }
    class CoordinatorC: UICoordinator {
        override var hasModalViewController: Bool { return true }
    }
    
    override func spec() {
        
        var window: UIWindow!
        var navigationController: UINavigationController!
        
        beforeEach {
            navigationController = UINavigationController()
            window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        
        describe("initialization") {
            
            describe("start") {
                
                context("doesn't have modal view controller") {
                    
                    it("should push the rootViewController to the navigationController view stack") {
                        let sut = CoordinatorA(navigationController: navigationController)
                        sut.start(with: nil)
                    expect(navigationController.visibleViewController!).to(equal(sut.rootViewController))
                    }
                    
                }
                
                context("has modal view controller") {
                    
                    it("should present the coordinator rootViewController") {
                        let sut = CoordinatorC(navigationController: navigationController)
                        sut.start(with: nil)
                        expect(navigationController.presentedViewController!).to(equal(sut.rootViewController))
                    }
                    
                }
                
                
            }
            
        }
        
    }
    
}
