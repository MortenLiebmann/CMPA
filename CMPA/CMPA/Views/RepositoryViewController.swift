//
//  RepositoryViewController.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 21/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var repository: Repository!
    var disposeBag = DisposeBag()
    private let controller = GitHubUsersApiController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let repository = repository else { return }
        collectionView.delegate = self
        
        nameLabel?.text = repository.FullName
        dateLabel?.text = "Created \(repository.CreatedAt?.toString() ?? "")"
        descriptionLabel?.text = repository.Description
        urlLabel?.text = repository.HtmlUrl
        
        if let stargazersUrl = repository.StargazersUrl, let stars = repository.Stars, let fullName = repository.FullName {
            let users = controller.getUsers(by: stargazersUrl, key: "stargazer/\(fullName)")
            
            starsLabel.text = "\(stars) stars"
            
            users.bind(to: collectionView.rx.items(cellIdentifier: "Cell", cellType: StarGazerCollectionViewCell.self)) {index, element, cell in
                cell.avatar.downloadImage(from: element.AvatarUrl)
            }.disposed(by: disposeBag)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RepositoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size.width / 3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
