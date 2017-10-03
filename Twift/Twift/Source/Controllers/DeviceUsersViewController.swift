//
//  DeviceUsersViewController.swift
//  Twift
//
//  Created by Taillook on 2017/09/26.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import UIKit
import SDWebImage
import ObjectMapper

class DeviceUsersViewController: UITableViewController {
    let ud = Common.shared.userDefaults
    let shared = Common.shared
    var users  = [[String: String]]()
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ud.object(forKey: "users") != nil {
            users = ud.object(forKey: "users") as! [[String: String]]
        }else {
            ud.set(users, forKey: "users")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceUserCell", for: indexPath)
        OAuthTwitter().showUser(name: (users[indexPath.row]["name"]!)) { jsonString in
            let user: User = Mapper<User>().map(JSONString: jsonString)!
            (cell.viewWithTag(1) as! UILabel).text = user.name!
            (cell.viewWithTag(2) as! UILabel).text = "@" + user.screenName!
            (cell.viewWithTag(3) as! UIImageView).sd_setImage(with: URL(string: user.profileImageUrl!))
        }
        return cell
    }
    
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        shared.currentUser = ["token": users[indexPath.row]["token"]!, "tokenSecret": users[indexPath.row]["tokenSecret"]!]
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addNewAccount(_ sender: UIButton) {
        OAuthTwitter().doOAuthTwitter(vc: self)
    }
}
