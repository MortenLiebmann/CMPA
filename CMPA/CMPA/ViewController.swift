//
//  ViewController.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 17/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = GitHubUsersApiController()
        
        
//        controller.getUsers(by: "MortenLiebmann").map{$0.Items}
//            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) {index, model, cell in
//            cell.textLabel?.text = model.Repos_Url
//        }.disposed(by: disposeBag)
        
        searchBar.rx.text.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .map {$0 ?? ""}
            .flatMap {controller.getUsers(by: $0)}
            .map{ $0.Items}
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) {index, model, cell in
                cell.textLabel?.text = model.Repos_Url
            }.disposed(by: disposeBag)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

