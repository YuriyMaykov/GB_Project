//
//  FriendController.swift
//  Vk_Maykov
//
//  Created by Юрий on 03/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "friendCell"

class FriendController: UICollectionViewController {

    let getAPI = GetVKAPI()
    var usersPhotos = UserPhotosList.shared.items
    var ownerId: String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromRequest()
    }

    @IBAction func likeBtnClick(_ sender: LikeButton, forEvent event: UIEvent) {
        guard let cell = sender.superview!.superview as? FriendCell else { return }
        guard let indx: Int = collectionView.indexPath(for: cell)?.row else { return }
        
        if (cell.likeButton.backgroundColor == UIColor.red){
            cell.likeButton.backgroundColor = UIColor.gray
            usersPhotos[indx].likesCount -= 1
            cell.likeCount.textColor = UIColor.gray
            cell.likeCount.text = String(usersPhotos[indx].likesCount)
        } else {
            cell.likeButton.backgroundColor = UIColor.red
            usersPhotos[indx].likesCount += 1
            cell.likeCount.textColor = UIColor.red
            cell.likeCount.text = String(usersPhotos[indx].likesCount)
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendCell
        cell.likeCount.textColor = UIColor.gray
        cell.likeButton.backgroundColor = UIColor.gray
        cell.likeCount.text = String(usersPhotos[indexPath.row].likesCount)

        //cell.friendPhoto.image = usersPhotos[indexPath.row].itemImage
        DispatchQueue.main.async {
            var err = false
            if let url = URL(string: self.usersPhotos[indexPath.row].urlSmalPhoto) {
                if let data = try? Data(contentsOf: url){
                    cell.friendPhoto.image = UIImage(data: data)
                } else {
                    err = true
                }
            } else {
                err = true
            }
            if err {
                cell.friendPhoto.image = UIImage(named: "noimgvk")
            }
            
        }
        cell.preloader.isHidden = true
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    }
    */

    //MARK: - запрос на сервер и обработка данных
    var photosOffset: Int = 0
    var photosCount: Int = 200
    func getDataFromRequest() {
        getAPI.photosGetAll(ownerId: ownerId, offset: photosOffset, count: photosCount) { qResult in
            guard let apiData: [PhotosGetAllModel.photosItems] = qResult.response.items else {
                 print("Ошибка. Нет массива с данными!")
                 return
             }
             //self.usersPhotos.removeAll()
             if apiData.count > 0 {
                 for i in apiData {
                    var photo = i.sizes.filter { $0.type == "o" }
                    if photo.count == 0 {
                        photo = [i.sizes[0]]
                    }
                    
                    self.usersPhotos.append(FriendPageModel(
                        itemId: i.id,
                        userId: i.ownerId ?? 0,
                        itemImage: UIImage.empty, //UIImage.fromUrl(url: URL(string: photo[0].url)!),
                        likesCount: i.likes.likesCount,
                        notis: i.text ?? "",
                        urlSmalPhoto: photo[0].url,
                        urlBigPhoto: photo[0].url
                        )
                     )
                     
                 }
             }
             self.collectionView.reloadData()
         }
    }


}
