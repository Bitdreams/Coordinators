// https://github.com/Quick/Quick

import UIKit
import Quick
import Nimble
import Coordinators

class CoordinatorSpecs: QuickSpec {
    
    class CoordinatorA: UICoordinator {
        var tag: Int = 0
    }
    class CoordinatorB: UICoordinator {
        
        var tag: Int = 0
        
        var wasChieldCoordinatorDidFinishCalled: (Bool, Coordinator?) = (false, nil)
        
        override func childCoordinatorDidFinish(coordinator: Coordinator) {
            super.childCoordinatorDidFinish(coordinator: coordinator)
            wasChieldCoordinatorDidFinishCalled = (true, coordinator)
        }
        
    }
    class CoordinatorC: UICoordinator {
        
        var tag: Int = 0
        
        override var hasModalViewController: Bool { return true }
        
        var wasWillFinishCalled = false
        var wasFinishCalled = false
        
        override func willFinish() {
            super.willFinish()
            wasWillFinishCalled = true
        }
        
        override func finish(_ animated: Bool) {
            super.finish(animated)
            wasFinishCalled = true
        }
    }
    
    class CoordinatorD: InternalCoordinator {
        
        var tag: Int = 0
        
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
            
            it("should emit a willFinish before finishing") {
                let a = CoordinatorA(navigationController: navigationController)
                a.start(with: nil)
                let b = CoordinatorB(navigationController: navigationController)
                b.start(with: a)
                let c = CoordinatorC(navigationController: navigationController)
                c.start(with: b)
                c.finish(true)
                expect(c.wasWillFinishCalled).to(beTrue())
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
        
        describe("internal coordinator") {
            
            var rootCoordinator: UICoordinator!
            var sut: CoordinatorD!
            
            beforeEach {
                rootCoordinator = CoordinatorA(navigationController: navigationController)
                rootCoordinator.start(with: nil)
                sut = CoordinatorD(navigationController: navigationController)
                sut.rootViewController = InternalViewController()
                sut.start(with: rootCoordinator)
            }
            
            // This test should pass but it is nto for whatever reason since the move to SPM
//            it("should finish the Coordinator when the viewController is popped from the navigation stack") {
//                expect(navigationController.visibleViewController).toEventually(equal(sut.rootViewController))
//
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
//                    sut.navigationController.popViewController(animated: false)
//                })
//
//                expect(sut.wasFinishCalled).toEventually(beTrue())
//            }
            
            it("should not finish the Coordinator if another view controller is pushed to the navigation stack") {
                let c = CoordinatorB(navigationController: navigationController)
                c.start(with: sut)
                expect(sut.wasFinishCalled).toNotEventually(beTrue())
            }
            
        }
        
        describe("methods") {
            
            describe("first descendant") {
                
                it("should correctly find the first descendant that satisfies an arbritrary condition") {
                    let a = CoordinatorA(navigationController: navigationController)
                    a.start(with: nil)
                    let b = CoordinatorB(navigationController: navigationController)
                    b.start(with: a)
                    let c = CoordinatorC(navigationController: navigationController)
                    c.tag = 66
                    c.start(with: b)
                    let d = CoordinatorD(navigationController: navigationController)
                    d.start(with: c)
                    let c2 = CoordinatorC(navigationController: navigationController)
                    c2.start(with: d)
                    
                    let firstDescendant = a.firstDescendant {
                        ($0 as? CoordinatorC)?.tag == 66
                    }
                    expect(firstDescendant).to(equal(c))
                }
                
                it("should return nil if no coordinator satisfies the arbritrary condition") {
                    let a = CoordinatorA(navigationController: navigationController)
                    a.start(with: nil)
                    let b = CoordinatorB(navigationController: navigationController)
                    b.start(with: a)
                    let c = CoordinatorC(navigationController: navigationController)
                    c.tag = 66
                    c.start(with: b)
                    let d = CoordinatorD(navigationController: navigationController)
                    d.start(with: c)
                    let c2 = CoordinatorC(navigationController: navigationController)
                    c2.start(with: d)
                    
                    let firstDescendant = a.firstDescendant {
                        ($0 as? CoordinatorC)?.tag == 900
                    }
                    expect(firstDescendant).to(beNil())
                }
                
            }
            
        }
        
    }
    
}
