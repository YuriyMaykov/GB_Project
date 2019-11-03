//
//  FriendsController.swift
//  Vk_Maykov
//
//  Created by Юрий on 02/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class FriendsController: UITableViewController {
    
    let getAPI = GetVKAPI()
    var friendsList = FriendsList.shared.items

    override func viewDidLoad() {
        super.viewDidLoad()
        friendsList.append(FriendModel(userId: -1, userName: "", userAvatar: UIImage.empty, userEmail: ""))
        
        //MARK: - запрос на сервер и обработка данных
        getAPI.getFriends { qResult in
            guard let apiData:[ParsModels.items] = qResult.response.items else {
                print("Ошибка. Нет массива с данными!")
                return
            }
            self.friendsList.removeAll()
            print("=====пришел ответ от севера=====")
            print(apiData.count)
            
            if apiData.count > 0 {
                for i in apiData {
                    self.friendsList.append(FriendModel(
                        userId: i.id,
                        userName: (i.lastName ?? "") + " " + (i.firstName ?? ""),
                        userAvatar: UIImage.fromUrl(url: URL(string: i.photo50!)!),
                        userEmail: ""
                        )
                    )
                }
            }
            self.tableView.reloadData()
        }
        print("=====послали запрос на сервер, ждем данных ...=====")

    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("=====tableView return items count=====")
        return friendsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("=====Generate cell data=====")
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsCell
        cell.friendNameLabel.text = friendsList[indexPath.row].userName
        cell.avatarView.image = friendsList[indexPath.row].userAvatar ?? UIImage.empty
        if friendsList[indexPath.row].userId == -1 {
            cell.preloader.isHidden = false
            cell.avatarView.isHidden = true
        } else {
            cell.preloader.isHidden = true
            cell.avatarView.isHidden = false
        }
        
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let friendVC = segue.destination as? FriendController {
            if (segue.identifier == "toFriend") {
                guard let selRow = tableView.indexPathForSelectedRow?.row else {return}
                friendVC.friend.insert(FriendPageModel(
                    itemId: 0,
                    userId: friendsList[selRow].userId,
                    itemImage: friendsList[selRow].userAvatar ?? UIImage.empty,
                    likesCount: 0,
                    notis: friendsList[selRow].userName),
                at: 0)
            }
        }
    }
    


}
