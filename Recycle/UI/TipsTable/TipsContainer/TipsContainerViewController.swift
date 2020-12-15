//
//  TipsContainerViewController.swift
//  Recycle
//
//  Created by Babaev Mikhail on 15.12.2020.
//

import UIKit

class TipsContainerViewController: UIPageViewController {
    
    var pageController: UIPageViewController? {
        self
    }
    
    var controllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        dataSource = self
        
        if let first = controllers.first {
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension TipsContainerViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = controllers.firstIndex(of: viewController) else {
            return nil
        }
                
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard controllers.count > previousIndex else {
            return nil
        }
        
        return controllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = controllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = controllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return controllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        controllers.count
    }
}
