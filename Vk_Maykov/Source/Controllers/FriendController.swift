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
    let mng = DataManager()
    var ownerId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !mng.getUserPhotos(ownerId: Int(ownerId) ?? 0) {
            print("Логирование:  чтение из кэш страничка друга - Ошибка!!!")
        }
        
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
        /*
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
            cell.preloader.isHidden = true
        }
        */
        
        guard let url = URL(string: usersPhotos[indexPath.row].urlSmalPhoto) else {
            cell.friendPhoto.image = UIImage(named: "noimgvk") ?? UIImage.empty
            return cell
        }
        mng.downLoadImage(url: url, completion: { img in
            cell.friendPhoto.image = img ?? UIImage(named: "noimgvk") ?? UIImage.empty
        })
        
        return cell
    }
    
    
    //MARK: - запрос на сервер и обработка данных
    var photosOffset: Int = 0
    var photosCount: Int = 200
    func getDataFromRequest() {
        getAPI.photosGetAll(ownerId: ownerId, offset: photosOffset, count: photosCount) { qResult in
            guard let apiData: [PhotosGetAllModel.PhotosItems] = qResult.response.items else {
                print("Ошибка. Нет массива с данными!")
                return
            }
            self.usersPhotos.removeAll()
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
            DispatchQueue.global().async {
                if !self.mng.setUserPhotos(items: self.usersPhotos, Int(self.ownerId) ?? 0) {
                    print("Логирование:  запись в кэш страница друга - Ошибка!!!")
                }
            }
        }
    }
    
    
}
