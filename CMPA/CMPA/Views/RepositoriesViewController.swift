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
    
    var disposeBag = DisposeBag()
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Repository>>(configureCell: {(_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element.Name!)"
            return cell
        }, titleForHeaderInSection: {dataSource, sectionIndex in
            return dataSource[sectionIndex].model }
        )
        
        guard let user = user, let repositoryUrl = user.RepositoryUrl else { return }
        let controller = GitHubRepositoriesApiController()
        
        let repositories = controller.getRepositories(by: repositoryUrl)
            .map{ Dictionary(grouping: $0, by: { $0.Language ?? "No language" }).sorted(by: { return $0.value.count > $1.value.count})}
            .map { $0.map { SectionModel(model: $0.key, items: $0.value.sorted(by: { (x, y) in
                let xscore = x.Stars ?? 0
                let yscore = y.Stars ?? 0
                return xscore > yscore
            }))}}
        
        repositories.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
