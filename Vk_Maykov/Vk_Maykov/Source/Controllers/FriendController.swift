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

    var friend: [FriendPageModel] = []
    
    private func friendGetData() {
        if (friend.count > 0){
            let item: FriendPageModel = friend[0]
            friend.removeAll()
            friend.append(item)
        }
        
        friend.append(
            FriendPageModel(
                itemId: 2,
                userId: (friend.count > 0) ? friend[0].userId : 0,
                itemImage: UIImage(named: "s800") ?? UIImage.empty,
                likesCount: 256,
                notis: "Прикольная собака!"
            )
        )
        friend.append(
            FriendPageModel(
                itemId: 3,
                userId: (friend.count > 0) ? friend[0].userId : 0,
                itemImage: UIImage(named: "s800") ?? UIImage.empty,
                likesCount: 25,
                notis: "собака"
            )
        )

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        friendGetData()
        self.collectionView.reloadData()
    }

    @IBAction func likeBtnClick(_ sender: LikeButton, forEvent event: UIEvent) {
        guard let cell = sender.superview!.superview as? FriendCell else { return }
        guard let indx: Int = collectionView.indexPath(for: cell)?.row else { return }
        
        if (cell.likeButton.backgroundColor == UIColor.red){
            cell.likeButton.backgroundColor = UIColor.gray
            friend[indx].likesCount -= 1
            cell.likeCount.textColor = UIColor.gray
            cell.likeCount.text = String(friend[indx].likesCount)
        } else {
            cell.likeButton.backgroundColor = UIColor.red
            friend[indx].likesCount += 1
            cell.likeCount.textColor = UIColor.red
            cell.likeCount.text = String(friend[indx].likesCount)
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendCell
        cell.friendAvatar.image = friend[indexPath.row].itemImage
        cell.likeCount.textColor = UIColor.gray
        cell.likeButton.backgroundColor = UIColor.gray
        cell.likeCount.text = String(friend[indexPath.row].likesCount)

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
}
