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
    let ud: UserDefaults = Common.shared.userDefaults
    var users: [Any] = []
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ((self.ud.object(forKey: "users")) != nil) {
            users = self.ud.object(forKey: "users") as! [Any]
        }else {
            self.ud.set(users, forKey: "users")
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
        OAuthTwitter().showUser(name: ((users[indexPath.row] as? [String: String])?["name"]!)!) { jsonString in
            let user: User = Mapper<User>().map(JSONString: jsonString)!
            (cell.viewWithTag(1) as! UILabel).text = user.name!
            (cell.viewWithTag(2) as! UILabel).text = "@" + user.screenName!
            (cell.viewWithTag(3) as! UIImageView).sd_setImage(with: URL(string: user.profileImageUrl!))
        }
        return cell
    }
    
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
    
    @IBAction func addNewAccount(_ sender: Any) {
        OAuthTwitter().doOAuthTwitter(vc: self)
    }
}
