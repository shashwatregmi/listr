//
//  TaskTableViewCell.swift
//  listr
//
//  Created by Regmi on 2020-05-06.
//  Copyright © 2020 Regmi. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    // Properties
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var priorityControl: PriorityControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
