//
//  MealTableViewCell.swift
//  JumpRightIn
//
//  Created by Kai Jendo on 6/12/17.
//  Copyright © 2017 KaiJendo. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
//MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingController!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
