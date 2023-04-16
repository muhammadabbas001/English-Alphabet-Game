//
//  LearnViewController.swift
//  Alphabet Game
//
//  Created by Zeeshan Suleman on 15/04/2023.
//

import UIKit

class LearnViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    let alphabets = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let names = ["Apple", "Ball", "Cat", "Dog", "Egg", "Fish", "Goat", "Hen", "Iron", "Jug", "Kite", "Lamp", "Monkey", "Note Book", "Orange", "Parrot", "Queen", "Rebbit", "Sun", "Towel", "Umbrella", "Van", "Watch", "Xailophone", "Yugurt", "Zebra"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        layoutCollectionView()
    }
    
    /// Initial View Setup
    func setupView(){
        navigationController?.setNavigationBarHidden(true, animated: false)
        collectionView.register(
            UINib(
                nibName: LearnCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: LearnCollectionViewCell.identifier
        )
    }
    
    func layoutCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = collectionView.bounds.size
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    /// Reverse image slider
    func backSlider(){
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
        if nextItem.row < 26 && nextItem.row >= 0{
            self.collectionView.scrollToItem(at: nextItem, at: .right, animated: true)
        }else{
            let nextItem: IndexPath = IndexPath(item: 25, section: 0)
            self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
        }
    }
    
    /// Forward image slider
    func forwardSlider(){
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        if nextItem.row < 26 {
            self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
        }else{
            let nextItem: IndexPath = IndexPath(item: 0, section: 0)
            self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
        }
    }

    @IBAction func dismissButtonAction(_ sender: UIButton) {
        popVC()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        backSlider()
    }
    
    @IBAction func forwardButtonAction(_ sender: UIButton) {
        forwardSlider()
    }
    
}


// MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension LearnViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alphabets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LearnCollectionViewCell.identifier, for: indexPath) as? LearnCollectionViewCell else {
            return UICollectionViewCell()
        }
        let imageName = alphabets[indexPath.row]
        cell.imageView.image = UIImage(named: imageName)
        cell.alphabetLabel.text = imageName
        cell.nameLabel.text = names[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
