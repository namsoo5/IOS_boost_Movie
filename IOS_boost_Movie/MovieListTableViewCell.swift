
//
//  MovieListTableViewCell.swift
//  IOS_boost_Movie
//
//  Created by 남수김 on 10/03/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var movieAgeImage: UIImageView!
    @IBOutlet weak var moiveImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    
    @IBOutlet weak var movieInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
