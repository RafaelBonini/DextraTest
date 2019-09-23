//
//  ListUsersViewController.swift
//  DextraGithubTest
//
//  Created by Rafael Bonini on 9/21/19.
//  Copyright © 2019 Rafael Bonini. All rights reserved.
//

import UIKit
import SkeletonView

class ListUsersViewController: UIViewController {
    fileprivate let repoSegueId = "repoSegueId"
    fileprivate let userCellId = "UsersTableViewCellId"
    
    @IBOutlet weak var tableView: UITableView!
    
    var reqModel: UserReqViewModelProtocol!
    var userViewModels:[ UserViewModel] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
   
    }
    
    fileprivate func initialSetUp(){
        
        reqModel = UserReqViewModel()
        
        registerNibCells()
        
        self.view.showAnimatedSkeleton()
        tableView.isUserInteractionEnabled = false
        
        fetchUsers()
    }
    
    fileprivate func fetchUsers(){
        
        let since = userViewModels.last?.id ?? 0
        reqModel.getUsers(since: since, onCompletion: { [unowned self] users in
            
            self.userViewModels.append(contentsOf: users.map({return UserViewModel.init(user: $0)}))
            
            self.view.hideSkeleton()
            self.tableView.isUserInteractionEnabled = true
            
        }) { (msg) in
            print("Error: \(msg)")
            GlobalAlert(with: self, msg: msg).showAlert()
        }
    }
    
    fileprivate func registerNibCells(){
        
        let nib = UINib(nibName: "UsersTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: userCellId)
    }
    
}

//MARK:-  UITableViewDataSource(SkeletonTableViewDataSource), UITableViewDelegate(SkeletonTableViewDelegate)
extension ListUsersViewController: SkeletonTableViewDataSource, SkeletonTableViewDelegate{
    
    //Skeleton methods
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier{
        return userCellId
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 6
    }
    
    
    //tableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellId, for: indexPath) as! UsersTableViewCell
        
        cell.userViewModel = userViewModels[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.performSegue(withIdentifier: repoSegueId, sender: userViewModels[indexPath.row])
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // if dispaying last cell, load more users
        let lastCell = userViewModels.count-1
        
        if indexPath.row == lastCell{
            fetchUsers()
        }
    }
}
//MARK: - prepare for segue
extension ListUsersViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? ListReposViewController{
            let user = sender as! UserViewModel
            vc.getUserName = user.login
            vc.getUserImageUrl = user.imageUrl
        }
    }
}
