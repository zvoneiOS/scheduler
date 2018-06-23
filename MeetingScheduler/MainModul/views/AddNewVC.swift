//
//  AddNewVC.swift
//  MeetingScheduler
//

import UIKit

class AddNewVC: UIViewController {
    
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var tillLabel: UILabel!
    @IBOutlet weak var timeButton: UIButton!
    
    var presenter: AddNewPresenterProtocol?
    
    var hour:Hour?
    var day:Day?
    var pickedHours:[Hour]?
    
    var endIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ConversionUtils.convertIndexToTime(index: hour!.index)
        self.endTimeLabel.text = ConversionUtils.convertIndexToTime(index: hour!.index + 1)
        self.endIndex = hour!.index + 1
        if let description = hour?.description {
            self.descriptionField.text = description
            self.endTimeLabel.isHidden = true
            self.endTimeLabel.isUserInteractionEnabled = false
            self.endTimeLabel.isEnabled = false
            self.tillLabel.isHidden = true
            self.tillLabel.isEnabled = false
            self.tillLabel.isUserInteractionEnabled = false
            self.timeButton.isEnabled = false
        }
        self.descriptionField.becomeFirstResponder()
        self.presenter?.viewDidLoad()
    }
    
    @IBAction func timeClicked(_ sender: Any) {
        self.presenter?.timeClicked(selectedHour: self.hour!, hours: self.day!.hours!)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        self.presenter?.saveClicked(endIndex: self.endIndex!, startIndex: self.hour!.index, day: self.day!, description: self.descriptionField.text)
    }
    
}

extension AddNewVC: AddNewViewProtocol{
    
    func closeView() {
        self.navigationController?.popViewController(animated: true)
    }
    	
    func showAvailableEndHours(endHours: [Hour]) {
        let vc  = UIAlertController.init(title: "Time picker", message: "Pick end time", preferredStyle: .actionSheet)
        for hour in endHours {
            let action = UIAlertAction.init(title: ConversionUtils.convertIndexToTime(index: hour.index + 1), style: .default, handler: { (action) in
                self.endTimeLabel.text = action.title
                self.endIndex = ConversionUtils.convertTimeToIndex(time: action.title!)
            })
            vc.addAction(action)
        }
        vc.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        vc.popoverPresentationController?.sourceView = self.endTimeLabel
        self.present(vc, animated: true, completion: nil)
    }
    
    func showError(message: String) {
        
    }
    
}


