//
//  ListReposViewController.swift
//  DextraGithubTest
//
//  Created by Rafael Bonini on 9/22/19.
//  Copyright © 2019 Rafael Bonini. All rights reserved.
//

import UIKit
import SkeletonView
import SDWebImage

class ListReposViewController: UIViewController {
    fileprivate let repoCellId = "repoCellId"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var reposNumLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var repoWordLabel: UILabel!
    
    var getUserName: String?
    var getUserImageUrl: String?
    
    var reqModel: UserReqViewModelProtocol!
    var repoViewModels: [RepoViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let userName = getUserName{
            self.title = userName
            fetchUserRepos(with: userName)
        }
    }
    
    fileprivate func initialSetUp(){
        
        headerView.dropShadow(opacity: 0.5, radius: 1)
        
        self.tableView.isUserInteractionEnabled = false
        
        //match first cell space
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        
        reqModel = UserReqViewModel()
        
        registerNibCells()
        
        view.showAnimatedSkeleton()
    }
    
    fileprivate func fetchUserRepos(with userName: String){
        
        reqModel.getRepos(for: userName, onCompletion: { [unowned self] repos in
            
            self.repoViewModels = repos.map({RepoViewModel.init(repo: $0)})
            self.setRepoData()
            
        }) { (msg) in
            print(msg)
        }
        
    }
    
    fileprivate func setRepoData(){
        
        self.view.hideSkeleton()
        self.tableView.isUserInteractionEnabled = true
        self.tableView.reloadData()
        
        reposNumLabel.text = String(repoViewModels.count)
        repoWordLabel.text = repoViewModels.count > 1 ? " Repositories" : " Repository"
        
        guard let imageUrl = getUserImageUrl  else { return }
        userImage.sd_setImage(with: URL(string: imageUrl))
        userImage.layer.borderColor = #colorLiteral(red: 0.8935850859, green: 0.9098501801, blue: 0.9139588475, alpha: 1)
    }
    
    fileprivate func registerNibCells(){
        
        let nib = UINib(nibName: "ReposTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: repoCellId)
    }
    
}

extension ListReposViewController: SkeletonTableViewDelegate,SkeletonTableViewDataSource{
    
    //Skeleton methods
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier{
        return repoCellId
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    
    // tableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: repoCellId, for: indexPath) as! ReposTableViewCell
        
        cell.repoViewModel = repoViewModels[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        GlobalAlert(with: self, msg: "Would you like to open the repository in the browser?", confirmAndCancelButton: true, url: repoViewModels[indexPath.row].repoUrl,title: repoViewModels[indexPath.row].name).showAlertForUrl()
    }
    
}

