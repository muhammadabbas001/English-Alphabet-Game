//
//  ViewController.swift
//  Alphabet Game
//
//  Created by Zeeshan Suleman on 15/04/2023.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func learningModeButtonAction(_ sender: UIButton) {
        let vc = LearnViewController.create(storyboard: StoryBoards.main)
        push(vc)
    }
    
    @IBAction func testingModeButtonAction(_ sender: UIButton) {
        let vc = TestViewController.create(storyboard: StoryBoards.main)
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        present(nc)
    }
    
    
}

