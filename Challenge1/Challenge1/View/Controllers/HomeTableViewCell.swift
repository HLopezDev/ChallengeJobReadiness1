//
//  HomeTableViewCell.swift
//  Challenge1
//
//  Created by Hector Orlando Lopez Orozco on 29/03/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

//    MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
