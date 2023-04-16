//
//  TestCollectionViewCell.swift
//  Alphabet Game
//
//  Created by Zeeshan Suleman on 15/04/2023.
//

import UIKit

protocol TestCollectionViewCellDelegate{
    func onOptionSelection(isCorrect: Bool)
}

class TestCollectionViewCell: UICollectionViewCell {
    static let identifier = "TestCollectionViewCell"
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    @IBOutlet weak var alphabetLabel: UILabel!
    
    var delegate: TestCollectionViewCellDelegate?
    
    var finalOptions: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(options: [String], alphabet: String){
        finalOptions = []
        alphabetLabel.text = alphabet
        
        var updatedOptions = options
        for index in 0..<3 {
            let option = updatedOptions.randomElement()!
            finalOptions.append(option)
            updatedOptions = updatedOptions.filter{ $0 != option }
            if index == 0 {
                imageView1.image = UIImage(named: option)
            } else if index == 1 {
                imageView2.image = UIImage(named: option)
            } else {
                imageView3.image = UIImage(named: option)
            }
        }
    }

    @IBAction func firstImageAction(_ sender: UIButton) {
        if finalOptions[0] == alphabetLabel.text{
            delegate?.onOptionSelection(isCorrect: true)
        }else{
            delegate?.onOptionSelection(isCorrect: false)
        }
    }
    
    @IBAction func secondImageAction(_ sender: UIButton) {
        if finalOptions[1] == alphabetLabel.text{
            delegate?.onOptionSelection(isCorrect: true)
        }else{
            delegate?.onOptionSelection(isCorrect: false)
        }
    }
    
    @IBAction func thirdImageAction(_ sender: UIButton) {
        if finalOptions[2] == alphabetLabel.text{
            delegate?.onOptionSelection(isCorrect: true)
        }else{
            delegate?.onOptionSelection(isCorrect: false)
        }
    }
    
}
