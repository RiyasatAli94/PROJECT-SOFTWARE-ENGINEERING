//
//  YogaPoseTableViewCell.swift
//  FamTracker
//
//  Created by Riyasat  on 02/06/22.
//

import UIKit

class YogaPoseTableViewCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var yogaImg: UIImageView!
    @IBOutlet weak var yogaEngName: UILabel!
    @IBOutlet weak var yogaSunName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
