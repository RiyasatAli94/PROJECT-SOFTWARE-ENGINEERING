//
//  ListHabbitsViewController.swift
//  FamTracker
//
//  Created by Riyasat  on 16/05/22.
//

import UIKit

class ListHabbitsViewController: UIViewController {
    @IBOutlet weak var listHabitsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listHabitsCollection.delegate = self
        listHabitsCollection.dataSource = self
        
    }

    
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    

}

extension ListHabbitsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitsName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListHabbitCollectionViewCell", for: indexPath) as! ListHabbitCollectionViewCell
        cell.icon.image = habitsiCons[indexPath.row]
        cell.superView.backgroundColor = colorCode[indexPath.row]
        cell.titleLabel.text = habitsName[indexPath.row]
        cell.superView.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftAndRightPaddings: CGFloat = 10.0
        let numberOfItemsPerRow: CGFloat = 2.0
        
        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if habitsName[indexPath.row] == "Yoga"{
            ScreensManager.shared.yogaPase(on: self, modal: true, animated: false)
        }else{
            ScreensManager.shared.createYourOwnShow(img: habitsiCons[indexPath.row]!, title: habitsName[indexPath.row], on: self, modal: true, animated: false)
        }
    }
    
}
