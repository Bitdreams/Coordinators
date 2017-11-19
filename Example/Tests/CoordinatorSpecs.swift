// https://github.com/Quick/Quick

import UIKit
import Quick
import Nimble
import Coordinators

class CoordinatorSpecs: QuickSpec {
    
    class CoordinatorA: UICoordinator {  }
    class CoordinatorB: UICoordinator {
        
        var wasChieldCoordinatorDidFinishCalled: (Bool, Coordinator?) = (false, nil)
        
        override func childCoordinatorDidFinish(coordinator: Coordinator) {
            super.childCoordinatorDidFinish(coordinator: coordinator)
            wasChieldCoordinatorDidFinishCalled = (true, coordinator)
        }
        
    }
    class CoordinatorC: UICoordinator {
        override var hasModalViewController: Bool { return true }
        
        var wasFinishCalled = false
        
        override func finish(_ animated: Bool) {
            super.finish(animated)
            wasFinishCalled = true
        }
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
                
                context("starting a child coordinator") {
                    
                    it("should register the child coordinator with the parent") {
                        let parent = CoordinatorA(navigationController: navigationController)
                        parent.start(with: nil)
                        let sut = CoordinatorB(navigationController: navigationController)
                        sut.start(with: parent)
                        expect(parent.childCoordinators.contains(sut)).to(beTrue())
                        expect(sut.parent!).to(equal(parent))
                    }
                    
                }
                
                
            }
            
        }
        
        describe("finish") {
            
            it("should remove itself from the parent's child coordinators") {
                let parent = CoordinatorA(navigationController: navigationController)
                parent.start(with: nil)
                let sut = CoordinatorB(navigationController: navigationController)
                sut.start(with: parent)
                sut.finish(true)
                expect(parent.childCoordinators.contains(sut)).to(beFalse())
            }
            
            it("should also finish any child coordinators that might exist") {
                let a = CoordinatorA(navigationController: navigationController)
                a.start(with: nil)
                let b = CoordinatorB(navigationController: navigationController)
                b.start(with: a)
                let c = CoordinatorC(navigationController: navigationController)
                c.start(with: b)
                b.finish(true)
                expect(c.wasFinishCalled).to(beTrue())
            }
            
            it("should correctly communicate the parent that the child coordinator finished") {
                let a = CoordinatorA(navigationController: navigationController)
                a.start(with: nil)
                let b = CoordinatorB(navigationController: navigationController)
                b.start(with: a)
                let c = CoordinatorC(navigationController: navigationController)
                c.start(with: b)
                b.finish(true)
                expect(b.wasChieldCoordinatorDidFinishCalled.0).to(beTrue())
                expect(b.wasChieldCoordinatorDidFinishCalled.1).to(equal(c))
            }
            
        }
        
        describe("instance members") {
            
            describe("rootCoordinator") {
                it("should correctly return the root coordinator of a given coordinator hierarchy") {
                    let a = CoordinatorA(navigationController: navigationController)
                    a.start(with: nil)
                    let b = CoordinatorB(navigationController: navigationController)
                    b.start(with: a)
                    let c = CoordinatorC(navigationController: navigationController)
                    c.start(with: b)
                    expect(c.rootCoordinator).to(equal(a))
                }
            }
            
        }
        
    }
    
}
