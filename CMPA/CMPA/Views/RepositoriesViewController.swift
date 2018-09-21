//
//  RepositoriesViewController.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 19/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RepositoriesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var disposeBag = DisposeBag()
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = user, let repositoryUrl = user.RepositoryUrl else { return }
        
        tableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Repository>>(configureCell: {(_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell") as! RepositoryTableViewCell
            cell.nameLabel.text = element.Name
            cell.descriptionLabel.text = element.Description
            cell.starsLabel.text = "\(element.Stars ?? 0) stars"
            cell.forksLabel.text = "\(element.Forks ?? 0) forks"
            return cell
        })
        
        dataSource.titleForHeaderInSection = {dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }
        
        let controller = GitHubRepositoriesApiController()
        
        userNameLabel.text = user.UserLogin
        
        let repositories = controller.getRepositories(by: repositoryUrl, key: "repositories/\(user.UserLogin!)")
            .map{ Dictionary(grouping: $0, by: { $0.Language ?? "No language" }).sorted(by: { return $0.value.count > $1.value.count})}
            .map { $0.map { SectionModel(model: $0.key, items: $0.value.sorted(by: { (x, y) in
                let xscore = x.Stars ?? 0
                let yscore = y.Stars ?? 0
                return xscore > yscore
            }))}}
        
        tableView.rx.modelSelected(Repository.self).subscribe { (event) in
            switch event {
            case .next(let repository):
                guard let storyboard = self.storyboard else { return }
                guard let vc = storyboard.instantiateViewController(withIdentifier: "RepositoryView") as? RepositoryViewController else { return }
                vc.repository = repository
                self.navigationController?.pushViewController(vc, animated: true)
                break
            default: break
            }
        }
        repositories.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
