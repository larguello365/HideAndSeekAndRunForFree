//
//  ViewController.swift
//  HideAndSeekAndRunForFree
//
//  Created by Lester Arguello on 4/6/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var storyButton: UIButton!
    @IBOutlet var settingsButton: UIButton!
    @IBOutlet var authorButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authorButton.addTarget(self, action: #selector(authorButtonTapped), for: .touchUpInside)
        
        storyButton.addTarget(self, action: #selector(storyButtonTapped), for: .touchUpInside)
    }

    @objc func authorButtonTapped() {
        let authorVC = AuthorViewController()
        self.navigationController?.pushViewController(authorVC, animated: true)
    }
    
    @objc func storyButtonTapped() {
        let pageController = StoryPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        
        // Find the active scene's key window and replace its rootViewController
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = pageController
            window.makeKeyAndVisible()
        }
    }
}



