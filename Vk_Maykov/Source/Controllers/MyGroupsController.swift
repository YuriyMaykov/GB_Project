//
//  MyGroupsController.swift
//  Vk_Maykov
//
//  Created by Юрий on 06/10/2019.
//  Copyright © 2019 Yuriy. All rights reserved.
//

import UIKit

class MyGroupsController: UITableViewController {
    
    var groups:[GroupModel] = [
        GroupModel(groupId: 1, groupName: "Друзья", groupImage: UIImage(named: "group1")!, groupDesc: "Мои друзья")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func returnToMyGroups(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "addGroup" {
            guard let allGroupsController = unwindSegue.source as? AllGroupsController else { return }
            guard let indexPath = allGroupsController.tableView.indexPathForSelectedRow else { return }
            
            let group = allGroupsController.groups[indexPath.row]
            if !groups.contains(where: { $0.groupName == group.groupName }) {
                groups.append(allGroupsController.groups[indexPath.row])
                tableView.insertRows(at: [IndexPath(row: groups.count - 1, section: 0)], with: .fade)
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myGroup", for: indexPath) as! MyGroupsCell
        cell.myGroupNameLabel.text = groups[indexPath.row].groupName
        cell.myGroupImage.image = groups[indexPath.row].groupImage
        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
