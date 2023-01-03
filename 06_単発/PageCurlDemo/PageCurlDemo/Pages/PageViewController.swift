
import SwiftUI
import UIKit

/// The UIPageViewController in charge of the pages.
@available(iOS 13.0, *)
struct PageViewController: UIViewControllerRepresentable {

    @Binding var currentPage: Int

    var navigationOrientation: UIPageViewController.NavigationOrientation
    var transitionStyle: UIPageViewController.TransitionStyle
    var bounce: Bool
    var wrap: Bool
    var onDelete: () -> ()
    var controllers: [UIViewController]

    func makeCoordinator() -> PagesCoordinator {
        PagesCoordinator(self)
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: self.transitionStyle,
            navigationOrientation: self.navigationOrientation
        )
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        pageViewController.view.backgroundColor = .clear

        for view in pageViewController.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = context.coordinator
                break
            }
        }

        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        let previousPage = context.coordinator.parent.currentPage
        context.coordinator.parent = self

        pageViewController.setViewControllers(
            [controllers[currentPage]],
            direction: currentPage - previousPage > 0 ? .forward : .reverse,
            animated: false
        )
    }

}

// MARK: - PagesCoordinator

@available(iOS 13.0, *)
class PagesCoordinator: NSObject, UIPageViewControllerDataSource,
                             UIPageViewControllerDelegate {
    var parent: PageViewController

    init(_ pageViewController: PageViewController) {
        self.parent = pageViewController
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let index = parent.controllers.firstIndex(of: viewController) else {
            return nil
        }
        return index == 0 ? (self.parent.wrap ? parent.controllers.last : nil) : parent.controllers[index - 1]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let index = parent.controllers.firstIndex(of: viewController) else {
            return nil
        }
        return index == parent.controllers.count - 1 ? (self.parent.wrap ? parent.controllers.first : nil) : parent.controllers[index + 1]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if completed,
        let visibleViewController = pageViewController.viewControllers?.first,
        let index = parent.controllers.firstIndex(of: visibleViewController) {
            parent.currentPage = index
            if parent.currentPage == 1 {
                parent.onDelete()
            }
        }
    }
}

@available(iOS 13.0, *)
extension PagesCoordinator: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !parent.bounce {
            if parent.navigationOrientation == .horizontal {
                disableHorizontalBounce(scrollView)
            } else {
                disableVerticalBounce(scrollView)
            }
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollViewDidScroll(scrollView)
    }

    private func disableHorizontalBounce(_ scrollView: UIScrollView) {
        if parent.currentPage == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width ||
           parent.currentPage == self.parent.controllers.count - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }

    private func disableVerticalBounce(_ scrollView: UIScrollView) {
        if parent.currentPage == 0 && scrollView.contentOffset.y < scrollView.bounds.size.height ||
           parent.currentPage == self.parent.controllers.count - 1 && scrollView.contentOffset.y > scrollView.bounds.size.height {
            scrollView.contentOffset = CGPoint(x: 0, y: scrollView.bounds.size.height)
        }
    }
}
