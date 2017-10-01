//
//  ViewController.swift
//  Twift
//
//  Created by Taillook on 2017/09/25.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import UIKit
import OAuthSwift
import ObjectMapper

class HomeViewController: UITableViewController {
    var data: [Tweet] = []
    
    override func viewWillAppear(_ animated: Bool) {
        updateTweets()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI() {
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.refreshControlValueChanged(sender:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func updateTweets() {
        OAuthTwitter().fetchHomeTimeLine() { jsonString in
            self.data = Mapper<Tweet>().mapArray(JSONString: jsonString)!
            self.tableView.reloadData()
            print(self.data.count)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
        (cell.viewWithTag(1) as! UILabel).text = data[indexPath.row].user?.name!
        (cell.viewWithTag(2) as! UILabel).text = "@" + (data[indexPath.row].user?.screenName)!
        (cell.viewWithTag(3) as! UILabel).text = data[indexPath.row].text!
        (cell.viewWithTag(4) as! UIImageView).sd_setImage(with: URL(string: (data[indexPath.row].user?.profileImageUrl!)!))
        return cell
    }
    
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        print(data[indexPath.row].text!)
    }
    
    func refreshControlValueChanged(sender: UIRefreshControl) {
        updateTweets()
        sender.endRefreshing()
    }
}
