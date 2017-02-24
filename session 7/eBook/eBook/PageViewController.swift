//
//  PageViewController.swift
//  eBook
//
//  Created by Petar Cvijic on 2/1/17.
//  Copyright © 2017 iosWorkshop2017. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    private lazy var pageViewControllers: [UIViewController] = {
        
        // Create an array of VCs used in pageVC
        var viewControllers = [UIViewController]()
        for animal in Animals.allAnimals {
            viewControllers.append(self.newAtlasViewController(item: animal))
        }
        
        return viewControllers
    }()
    
    private func newAtlasViewController(item: AtlasItem) -> UIViewController {
        let atlasVC =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AtlasVC") as! AtlasViewController
        atlasVC.item = item
        return atlasVC
    }
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstViewController = pageViewControllers.first {
            
            // Present the first VC
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK:- Page VC dataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllers.index(of: viewController) else {
            return nil
        }
        
        let pageCount = pageViewControllers.count
        let previousIndex = (viewControllerIndex + pageCount-1) % pageCount
        
        return pageViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllers.index(of: viewController) else {
            return nil
        }
        
        let pageCount = pageViewControllers.count
        let nextIndex = (viewControllerIndex + 1) % pageCount
        
        return pageViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int  {
        return pageViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = pageViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
