//
//  SmartTourPageViewController.swift
//  AlarmClock
//
//  Created by Bene on 08.11.16.
//  Copyright © 2016 ReneUser. All rights reserved.
//

import UIKit

class SmartTourPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var viewArray: [UIViewController] = {
        return [
            self.viewInstance(name: "CalendarSelectionView"),
            self.viewInstance(name: "HomeSelectionView"),
            self.viewInstance(name: "OffsetSelectionView"),
            self.viewInstance(name: "SoundSelectionView"),
            self.viewInstance(name: "OverviewView")
            ]
    }()
    
    var alarmObject = TransportationObject()
    
    private func viewInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        if let firstView = viewArray.first {
            setViewControllers([firstView], direction: .forward, animated: false, completion: nil)
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewArray.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < viewArray.count else {
            return nil
        }
        
        guard viewArray.count > nextIndex else {
            return nil
        }
        
        return viewArray[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewArray.index(of: viewController) else {
            return nil
        }
        
        let previewIndex = viewControllerIndex - 1
        
        guard previewIndex >= 0 else {
            return nil
        }
        
        guard viewArray.count > previewIndex else {
            return nil
        }
        
        return viewArray[previewIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = viewArray.index(of: firstViewController) else {
            return 0
        }
        
        return firstViewControllerIndex
    }

}
