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
    let mng = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !mng.getUsers() {
            print("Логирование:  чтение из кэш списка друзей - Ошибка!!!")
            friendsList.append(FriendModel(userId: -1, userName: "", userAvatar: UIImage.empty, urlImgSmall: "", urlImgBig: "", userEmail: ""))
        }
        getDataFromRequest()
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsCell
        cell.friendNameLabel.text = friendsList[indexPath.row].userName
        //cell.avatarView.image = friendsList[indexPath.row].userAvatar ?? UIImage.empty

        if friendsList[indexPath.row].userId == -1 {
            cell.preloader.isHidden = false
            cell.avatarView.isHidden = true
        } else {
            cell.preloader.isHidden = true
            cell.avatarView.isHidden = false
        }
        
        guard let url = URL(string: friendsList[indexPath.row].urlImgBig)
            else {
                cell.avatarView.image = UIImage(named: "noimgvk") ?? UIImage.empty
                return cell
        }
        mng.downLoadImage(url: url, completion: { img in
            cell.avatarView.image = img ?? UIImage(named: "noimgvk") ?? UIImage.empty
        })
        
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
                guard let selRow = tableView.indexPathForSelectedRow?.row else { return }
                
                friendVC.ownerId = String(friendsList[selRow].userId)
            }
        }
    }
    
    //MARK: - запрос на сервер и обработка данных
    func getDataFromRequest() {
        getAPI.getFriends { qResult in
            guard let apiData: [FriendsGetModel.FriendsItems] = qResult.response.items else {
                print("Ошибка. Нет массива с данными!")
                return
            }
            self.friendsList.removeAll()
            if apiData.count > 0 {
                let sortItems = apiData.sorted(by: { ($0.lastName ?? "") < ($1.lastName ?? "")})
                for i in sortItems {
                    self.friendsList.append(FriendModel(
                        userId: i.id,
                        userName: (i.lastName ?? "") + " " + (i.firstName ?? ""),
                        userAvatar: UIImage.empty,      //UIImage.fromUrl(url: URL(string: i.photo50!)!),
                        urlImgSmall: i.photo50 ?? "",
                        urlImgBig: i.photo100 ?? "",
                        userEmail: ""
                        )
                    )
                }
            }
            self.tableView.reloadData()
            DispatchQueue.global().async {
                if !self.mng.setUsers(items: self.friendsList) {
                    print("Логирование:  запись в кэш списка друзей - Ошибка!!!")
                }
            }
        }


    }


}
