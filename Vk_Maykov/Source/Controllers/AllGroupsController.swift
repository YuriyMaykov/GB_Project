//
//  AllGroupsController.swift
//  Vk_Maykov
//
//  Created by Юрий on 06/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class AllGroupsController: UITableViewController {

    var allGroups: [GroupModel] = [
        GroupModel(groupId: 1, groupName: "Друзья", groupImage: UIImage(named: "group1")!, groupDesc: "Мои друзья"),
        GroupModel(groupId: 2, groupName: "Семья", groupImage: UIImage(named: "family")!, groupDesc: "Мои близкие и остальные родственники"),
        GroupModel(groupId: 3, groupName: "Коллеги", groupImage: UIImage(named: "colleagues")!, groupDesc: "Коллеги по работе"),
        GroupModel(groupId: 4, groupName: "Руководство", groupImage: UIImage(named: "group2")!, groupDesc: "Руководство"),
        GroupModel(groupId: 5, groupName: "Черный список", groupImage: UIImage(named: "groupBlack")!, groupDesc: "Забаненые мною пользователи")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allGroupCell", for: indexPath) as! AllGroupsCell
        cell.allGroupsNameLabel.text = allGroups[indexPath.row].groupName
        cell.allGroupsImage.image = allGroups[indexPath.row].groupImage ?? UIImage(named: "noimgvk") ?? UIImage.empty
        
        if allGroups[indexPath.row].groupId == -1 {
            cell.preloader.isHidden = false
            cell.allGroupsImage.isHidden = true
        } else {
            cell.preloader.isHidden = true
            cell.allGroupsImage.isHidden = false
        }
        
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            allGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
