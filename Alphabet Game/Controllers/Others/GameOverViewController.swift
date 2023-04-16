//
//  GameOverViewController.swift
//  Alphabet Game
//
//  Created by Zeeshan Suleman on 15/04/2023.
//

import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        view.backgroundColor = .clear
        scoreLabel.text = "Score: \(score ?? 0)"
    }

    @IBAction func goBackToHomeButtonAction(_ sender: UIButton) {
        self.dismissVC(animated: false)
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
    }
}
