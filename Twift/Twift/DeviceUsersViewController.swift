//
//  DeviceUsersViewController.swift
//  Twift
//
//  Created by Taillook on 2017/09/26.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import UIKit
import SDWebImage

class DeviceUsersViewController: UITableViewController {
    let ud: UserDefaults = Common.shared.userDefaults
    var users: [Any] = []
    
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceUserCell", for: indexPath)
        (cell.viewWithTag(3) as! UIImageView).sd_setImage(with: NSURL(string: "https://i.gyazo.com/90f50b5c0d1aa8c0b3cd0170e72ec601.png")! as URL)
        
        return cell
    }
    
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
    
    @IBAction func addNewAccount(_ sender: Any) {
        OAuth().doOAuthTwitter(vc: self)
    }
}
