//
//  DateCVC.swift
//  MeetingScheduler
//

import UIKit

class DateCVC: UICollectionViewCell {

    @IBOutlet weak var selectedIndicatorView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(day:Day, selected:Bool){
        let dayString = Calendar.current.component(.day, from: day.date).description
        let monthString = Calendar.current.component(.month, from: day.date).description
        self.dateLabel.text = dayString + "." + monthString
        self.dateLabel.textColor = selected ? UIColor.white : UIColor.black
        self.selectedIndicatorView.backgroundColor = selected ? UIColor(red:0.99, green:0.36, blue:0.16, alpha:1.0) : UIColor.white
        self.selectedIndicatorView.layer.cornerRadius = self.selectedIndicatorView.bounds.height/2
    }
    
}
