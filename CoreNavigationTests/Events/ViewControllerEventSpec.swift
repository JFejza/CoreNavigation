import UIKit
import Quick
import Nimble

@testable import CoreNavigation

private class MockViewController: UIViewController {}

class ViewControllerEventsSpec: QuickSpec {
    override func spec() {
        describe("View controller events") {
            context("when presenting view controllers", {
                let mockViewController = MockViewController()

                var loadView = 0
                var viewDidLoad = 0
                var viewWillAppear = 0
                var viewDidAppear = 0
                var viewWillDisappear = 0
                var viewDidDisappear = 0
                var viewWillTransition = 0
                var viewWillLayoutSubviews = 0
                var viewDidLayoutSubviews = 0
                var updateViewConstraints = 0
                var willMoveTo = 0
                var didMoveTo = 0
                var didReceiveMemoryWarning = 0
                var applicationFinishedRestoringState = 0
                var viewLayoutMarginsDidChange = 0
                var viewSafeAreaInsetsDidChange = 0

                Navigate.present({ $0
                    .to(mockViewController)
                    .on(.viewController(.loadView { _ in
                        loadView.invoke()
                    }))
                    .on(.viewController(.viewDidLoad { _ in
                        viewDidLoad.invoke()
                    }))
                    .on(.viewController(.viewWillAppear({ (_, _) in
                        viewWillAppear.invoke()
                    })))
                    .on(.viewController(.viewDidAppear({ (_, _) in
                        viewDidAppear.invoke()
                    })))
                    .on(.viewController(.viewWillDisappear({ (_, _) in
                        viewWillDisappear.invoke()
                    })))
                    .on(.viewController(.viewDidDisappear({ (_, _) in
                        viewDidDisappear.invoke()
                    })))
                    .on(.viewController(.viewWillTransition({ (_, _, _) in
                        viewWillTransition.invoke()
                    })))
                    .on(.viewController(.viewWillLayoutSubviews({ (_) in
                        viewWillLayoutSubviews.invoke()
                    })))
                    .on(.viewController(.viewDidLayoutSubviews({ (_) in
                        viewDidLayoutSubviews.invoke()
                    })))
                    .on(.viewController(.updateViewConstraints({ (_) in
                        updateViewConstraints.invoke()
                    })))
                    .on(.viewController(.willMoveTo({ (_, _) in
                        willMoveTo.invoke()
                    })))
                    .on(.viewController(.didMoveTo({ (_, _) in
                        didMoveTo.invoke()
                    })))
                    .on(.viewController(.didReceiveMemoryWarning({ (_) in
                        didReceiveMemoryWarning.invoke()
                    })))
                    .on(.viewController(.applicationFinishedRestoringState({ (_) in
                        applicationFinishedRestoringState.invoke()
                    })))
                    .on(.viewController(.viewLayoutMarginsDidChange({ (_) in
                        viewLayoutMarginsDidChange.invoke()
                    })))
                    .on(.viewController(.viewSafeAreaInsetsDidChange({ (_) in
                        viewSafeAreaInsetsDidChange.invoke()
                    })))
                    .completion {
                        mockViewController.updateViewConstraints()
                        mockViewController.willMove(toParentViewController: UIViewController())
                        mockViewController.didMove(toParentViewController: UIViewController())
                        mockViewController.didReceiveMemoryWarning()
                        mockViewController.applicationFinishedRestoringState()
                        mockViewController.viewWillTransition(to: CGSize(width: 100, height: 100), with: MockCoordinator())
                        mockViewController.dismiss(animated: false, completion: nil)
                    }
                    .unsafely()
                    .inWindow(MockWindow())
                })

                it("are called", closure: {
                    expect(loadView.isInvokedOnce).toEventually(beTrue())
                    expect(viewDidLoad.isInvokedOnce).toEventually(beTrue())
                    expect(viewWillAppear.isInvokedOnce).toEventually(beTrue())
                    expect(viewDidAppear.isInvokedOnce).toEventually(beTrue())
                    expect(viewWillDisappear.isInvokedOnce).toEventually(beTrue())
                    expect(viewDidDisappear.isInvokedOnce).toEventually(beTrue())
                    expect(viewWillTransition.isInvokedOnce).toEventually(beTrue())
                    expect(viewWillLayoutSubviews.isInvokedOnce).toEventually(beTrue())
                    expect(viewDidLayoutSubviews.isInvokedOnce).toEventually(beTrue())
                    expect(updateViewConstraints.isInvokedOnce).toEventually(beTrue())
                    expect(willMoveTo.isInvokedOnce).toEventually(beTrue())
                    expect(didMoveTo.isInvokedOnce).toEventually(beTrue())
                    expect(didReceiveMemoryWarning.isInvokedOnce).toEventually(beTrue())
                    expect(applicationFinishedRestoringState.isInvokedOnce).toEventually(beTrue())
                    expect(viewLayoutMarginsDidChange.isInvokedOnce).toEventually(beTrue())
                    expect(viewSafeAreaInsetsDidChange.isInvokedOnce).toEventually(beTrue())
                })
            })
        }
    }
}

private class MockCoordinator: NSObject, UIViewControllerTransitionCoordinator {
    var isAnimated: Bool = false

    var presentationStyle: UIModalPresentationStyle = .fullScreen

    var initiallyInteractive: Bool = false

    var isInterruptible: Bool = false

    var isInteractive: Bool = false

    var isCancelled: Bool = false

    var transitionDuration: TimeInterval = 0

    var percentComplete: CGFloat = 0

    var completionVelocity: CGFloat = 0

    var completionCurve: UIViewAnimationCurve = .easeIn

    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        return nil
    }

    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        return nil
    }

    var containerView: UIView = UIView()

    var targetTransform: CGAffineTransform = .init()

    func animate(alongsideTransition animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?, completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil) -> Bool {
        return false
    }

    func animateAlongsideTransition(in view: UIView?, animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?, completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil) -> Bool {
        return false
    }

    func notifyWhenInteractionEnds(_ handler: @escaping (UIViewControllerTransitionCoordinatorContext) -> Void) {

    }

    func notifyWhenInteractionChanges(_ handler: @escaping (UIViewControllerTransitionCoordinatorContext) -> Void) {

    }

}
