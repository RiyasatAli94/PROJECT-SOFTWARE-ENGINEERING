//
//  DayPickerTableViewCell.swift
//  FamTracker
//
//  Created by Riyasat  on 17/05/22.
//

import UIKit

class DayPickerTableViewCell: UITableViewCell {
    @IBOutlet var txt : UILabel!
    @IBOutlet var img : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
