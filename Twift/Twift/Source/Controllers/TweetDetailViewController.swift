//
//  TweetDetailViewController.swift
//  Twift
//
//  Created by Taillook on 2017/10/01.
//  Copyright © 2017年 Taillook. All rights reserved.
//

import UIKit
import SDWebImage
import ObjectMapper

class TweetDetailViewController: UITableViewController {
    var id:String? = ""
    
    @IBOutlet weak var tweetUserImage: UIImageView!
    @IBOutlet weak var tweetUserName: UILabel!
    @IBOutlet weak var tweetUserScreen: UILabel!
    @IBOutlet weak var tweettext: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        updateTweets()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let headerView = tableView.tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            var headerFrame = headerView.frame
            
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
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
        OAuthTwitter().tweetDetail(id: id!) { jsonString in
            let tweetDetail: TweetDetail = Mapper<TweetDetail>().map(JSONString: jsonString)!
            self.tweetUserName.text = tweetDetail.user?.name
            self.tweetUserScreen.text = "@" + (tweetDetail.user?.screenName!)!
            self.tweettext.text = tweetDetail.text
            self.tweetUserImage.sd_setImage(with: URL(string: (tweetDetail.user?.profileImageUrl!)!))
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)

        return cell
    }
    
    @IBAction func tappedFavButton(_ sender: Any) {
        OAuthTwitter().createFav(id: self.id!)
    }
    
    @IBAction func tappedReTweetButton(_ sender: Any) {
        OAuthTwitter().createReTweet(id: self.id!)
    }
    
}
