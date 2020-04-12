//
//  VideoListViewController.swift
//  TestVideoList
//
//  Created by Vitaliy on 11.04.2020.
//  Copyright © 2020 KorefeyGroup. All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var listBaseArr = [VideoListBase]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        updateVideoList()
    }

    @IBAction func updateButtonAction(_ sender: Any) {
        self.mainCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        updateVideoList()
    }
    
    func updateVideoList() {
        if !self.searchTextField.text!.isEmpty {
            HttpClient.shared.getSearchGifs(searchString: self.searchTextField.text!, completion: { (VideoListArray) in
                self.listBaseArr = VideoListArray.listBaseArr
                self.mainCollectionView.reloadData()
            })
        }
    }
    
}

extension VideoListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return listBaseArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: VideoListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoListCollectionViewCell", for: indexPath) as! VideoListCollectionViewCell
        cell.videoListTitleLabel.text = listBaseArr[indexPath.row].title
        cell.videoListUserLabel.text = listBaseArr[indexPath.row].username
        if !listBaseArr[indexPath.row].imageUrl.isEmpty {
            cell.videoListImageView.load(url: URL(string: listBaseArr[indexPath.row].imageUrl)!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.bounds.size.width - 32, height: 82)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


