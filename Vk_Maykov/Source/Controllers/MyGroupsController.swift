//
//  MyGroupsController.swift
//  Vk_Maykov
//
//  Created by Юрий on 06/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class MyGroupsController: UITableViewController {
    
    let getAPI = GetVKAPI()
    var groupsList = GroupsList.shared.items
    let mng = DataManager()
    var userIdForGroups: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "wwwww"
        
        if !mng.getMyGroups() {
            print("Логирование:  чтение из кэш списка моих групп - Ошибка!!!")
            groupsList.append(GroupModel(groupId: -1, groupName: "", groupImage: UIImage.empty, groupDesc: "", groupImgUrl: ""))
        }
        getDataFromRequest()
    }

    @IBAction func returnToMyGroups(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "addGroup" {
            guard let allGroupsController = unwindSegue.source as? AllGroupsController else { return }
            guard let indexPath = allGroupsController.tableView.indexPathForSelectedRow else { return }
            
            let group = allGroupsController.allGroups[indexPath.row]
            if !groupsList.contains(where: { $0.groupName == group.groupName }) {
                groupsList.append(allGroupsController.allGroups[indexPath.row])
                tableView.insertRows(at: [IndexPath(row: groupsList.count - 1, section: 0)], with: .fade)
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myGroup", for: indexPath) as! MyGroupsCell
        cell.myGroupNameLabel.text = groupsList[indexPath.row].groupName
        //cell.myGroupImage.image = groupsList[indexPath.row].groupImage ?? UIImage.empty
        if groupsList[indexPath.row].groupId == -1 {
            cell.preloader.isHidden = false
            cell.myGroupImage.isHidden = true
        } else {
            cell.preloader.isHidden = true
            cell.myGroupImage.isHidden = false
        }
        
        guard let url = URL(string: groupsList[indexPath.row].groupImgUrl)
            else {
                cell.myGroupImage.image = UIImage(named: "noimgvk") ?? UIImage.empty
                return cell
        }
        mng.downLoadImage(url: url, completion: { img in
            cell.myGroupImage.image = img ?? UIImage(named: "noimgvk") ?? UIImage.empty
        })

        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - запрос на сервер и обработка данных
    func getDataFromRequest() {
        getAPI.groupsGet(userIdForGroups) {qResult in
            guard let apiData: [GroupsGetModel.GroupsItems] = qResult.response.items else {
                print("Ошибка! Запрос не вернул данные! ")
                return
            }
            self.groupsList.removeAll()
            
            if apiData.count > 0 {
                for i in apiData {
                    self.groupsList.append(GroupModel(
                        groupId: i.id,
                        groupName: i.groupName ?? "***",
                        groupImage: UIImage.fromUrl(url: URL(string: i.photo50 ?? "")!) ,
                        groupDesc: "",
                        groupImgUrl: i.photo50 ?? ""
                        )
                    )
                }
            }
            self.tableView.reloadData()
            DispatchQueue.global().async {
                if !self.mng.setMyGroups(items: self.groupsList) {
                    print("Логирование:  запись в кэш списка мих групп - Ошибка!!!")
                }
            }

        }
    }


}
