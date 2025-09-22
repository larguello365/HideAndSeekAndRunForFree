//
//  StoryPageViewController.swift
//  HideAndSeekAndRunForFree
//
//  Created by Lester Arguello on 4/7/25.
//

import UIKit

class StoryPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var pages: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pageOne = storyboard.instantiateViewController(withIdentifier: "PageOneViewController")
        let pageTwo = storyboard.instantiateViewController(withIdentifier: "PageTwoViewController")
        let pageThree = storyboard.instantiateViewController(withIdentifier: "PageThreeViewController")
        let pageFour = storyboard.instantiateViewController(withIdentifier: "PageFourViewController")
        let pageFive = storyboard.instantiateViewController(withIdentifier: "PageFiveViewController")
        let pageSix = storyboard.instantiateViewController(withIdentifier: "PageSixViewController")
        let pageSeven = storyboard.instantiateViewController(withIdentifier: "PageSevenViewController")
        let pageEight = storyboard.instantiateViewController(withIdentifier: "PageEightViewController")
        let finalPage = storyboard.instantiateViewController(withIdentifier: "EndingViewController")
        return [pageOne, pageTwo, pageThree, pageFour, pageFive, pageSix, pageSeven, pageEight, finalPage]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Page View Controller Data Source
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
}
