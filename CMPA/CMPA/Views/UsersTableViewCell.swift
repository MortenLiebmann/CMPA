//
//  UsersTableViewCell.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 20/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var repositoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
