//
//  LearnCollectionViewCell.swift
//  Alphabet Game
//
//  Created by Zeeshan Suleman on 15/04/2023.
//

import UIKit

class LearnCollectionViewCell: UICollectionViewCell {
    static let identifier = "LearnCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alphabetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
