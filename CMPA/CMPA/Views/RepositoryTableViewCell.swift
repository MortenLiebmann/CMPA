//
//  RepositoryTableViewCell.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 20/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
