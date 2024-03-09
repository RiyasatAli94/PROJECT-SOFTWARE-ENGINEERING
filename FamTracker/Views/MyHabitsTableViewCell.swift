//
//  MyHabitsTableViewCell.swift
//  FamTracker
//
//  Created by Riyasat  on 17/05/22.
//

import UIKit

class MyHabitsTableViewCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var habitImg: UIImageView!
    @IBOutlet weak var habitName: UILabel!
    @IBOutlet weak var habitTie: UILabel!
    @IBOutlet weak var TimeOfDay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
