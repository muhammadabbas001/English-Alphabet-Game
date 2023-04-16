//
//  TestViewController.swift
//  Alphabet Game
//
//  Created by Zeeshan Suleman on 15/04/2023.
//

import UIKit
import Lottie
import AVFoundation

class TestViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let alphabets = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var score = 0
    
    /// Animation view for lottie animation
    private let animationView = LottieAnimationView()
    
    /// Correct sound audio player
    var correctAudioPlayer: AVAudioPlayer?
    /// Wrong sound audio player
    var wrongAudioPlayer: AVAudioPlayer?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        layoutCollectionView()
        setupAnimationView()
        configureCorrectSound()
        configureWrongSound()
    }
    
    /// Initial View Setup
    func setupView(){
        navigationController?.setNavigationBarHidden(true, animated: false)
        collectionView.register(
            UINib(
                nibName: TestCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: TestCollectionViewCell.identifier
        )
    }
    
    /// Setup Lottie Animation View
    func setupAnimationView(){
        animationView.frame = view.bounds
        view.addSubview(animationView)
        animationView.isHidden = true
    }
    
    func layoutCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = collectionView.bounds.size
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    func slideForward(){
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        if nextItem.row < 26 {
            self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
        }else{
            presentGameOverController()
        }
    }
    
    func playAnimation(animationName: String = "up"){
        animationView.isHidden = false
        let animation = LottieAnimation.named(animationName)
        animationView.animation = animation
        animationView.animationSpeed = 1.5
        animationView.loopMode = .playOnce
        animationView.play{ _ in
            self.animationView.isHidden = true
            self.slideForward()
        }
    }
    
    /// Game Over Popup
    func presentGameOverController(){
        let vc = GameOverViewController.create(storyboard: StoryBoards.main)
        vc.score = score
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .overCurrentContext
        present(nc, animated: false)
    }
    
    /// Configuring Sound for correct answer
    private func configureCorrectSound(){
        let soundURL = Bundle.main.url(forResource: "correct", withExtension: "mp3")!
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord)
            correctAudioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            correctAudioPlayer?.volume = 200
            correctAudioPlayer?.prepareToPlay()
        } catch let error {
            print("Error loading sound: \(error.localizedDescription)")
        }
    }
    
    /// Configuring Sound for wrong answer
    private func configureWrongSound(){
        let soundURL = Bundle.main.url(forResource: "wrong", withExtension: "mp3")!
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord)
            wrongAudioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            wrongAudioPlayer?.volume = 200
            wrongAudioPlayer?.prepareToPlay()
        } catch let error {
            print("Error loading sound: \(error.localizedDescription)")
        }
    }
    
    @IBAction func dismissButtonAction(_ sender: UIButton) {
        dismissVC()
    }
    
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension TestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alphabets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCollectionViewCell.identifier, for: indexPath) as? TestCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let alphabet = alphabets[indexPath.row]
        var otherAlphabets = alphabets.filter{ $0 != alphabet }
        
        var optionsList = [alphabet]
        
        for _ in 0...1{
            let option = otherAlphabets.randomElement()!
            otherAlphabets = otherAlphabets.filter{ $0 != option }
            optionsList.append(option)
        }
        
        cell.configure(options: optionsList, alphabet: alphabet)
        cell.delegate = self
        
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

// MARK: - TestCollectionViewCellDelegate
extension TestViewController: TestCollectionViewCellDelegate{
    func onOptionSelection(isCorrect: Bool) {
        if isCorrect{
            score += 1
            scoreLabel.text = "Score: \(score)"
            playAnimation()
            correctAudioPlayer?.play()
        }else{
            playAnimation(animationName: "down")
            wrongAudioPlayer?.play()
        }
    }
}
