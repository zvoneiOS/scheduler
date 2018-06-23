//
//  HoursCVC.swift
//  MeetingScheduler
//

import UIKit

class HoursCVC: UICollectionViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(hour:Hour){
        self.timeLabel.text = ConversionUtils.convertIndexToTime(index: hour.index)
        self.colorView.backgroundColor = hour.taken ? UIColor.groupTableViewBackground : UIColor.white                                                                                                                                                                                                              
        self.nameLabel.text = hour.username
    }
}
