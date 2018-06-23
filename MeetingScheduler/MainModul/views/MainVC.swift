//
//  MainVC.swift
//  MeetingScheduler
//

import UIKit

class MainVC: UIViewController{
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var hoursCollectionView: UICollectionView!
    
    var presenter: MainPresenterProtocol?

    var hoursDelegate = HoursDSDelegate()
    var days = [Day]()
    var selectedDay = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.presenter?.viewDidLoad()
    }
    
    func setupCollectionView(){
        self.calendarCollectionView.delegate = self
        self.calendarCollectionView.dataSource = self
        self.calendarCollectionView.register(UINib.init(nibName: "DateCVC", bundle: nil), forCellWithReuseIdentifier: "DateCVC")
        
        self.hoursDelegate.presenter = self.presenter
        self.hoursCollectionView.delegate = hoursDelegate
        self.hoursCollectionView.dataSource = hoursDelegate
        self.hoursCollectionView.register(UINib.init(nibName: "HoursCVC", bundle: nil), forCellWithReuseIdentifier: "HoursCVC")
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        self.presenter?.logout()
    }
    
    
}

extension MainVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCVC", for: indexPath) as! DateCVC
        cell.configureCell(day: self.days[indexPath.row], selected: indexPath.row == self.selectedDay)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.width/7, height: collectionView.frame.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedDay = indexPath.row
        self.hoursDelegate.day = self.days[indexPath.row]
        self.hoursCollectionView.reloadData()
        self.calendarCollectionView.reloadData()
    }
}

extension MainVC: MainViewProtocol{
    
    func openDescription(description: String, username: String, hour:Hour, day: Day) {
        if username == MeetingUserDefaults.sharedInstance.getUsername() {
            let alert = UIAlertController.init(title: username, message: description, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Delete reservation", style: .destructive, handler: { (action) in
                self.presenter?.deleteTermin(hour: hour, day: day)
            }))
            alert.addAction(UIAlertAction.init(title: "Edit reservation", style: .default, handler: { (action) in
                self.hoursDelegate.presenter?.openTakeTerminScreen(hour: hour, day: day)
            }))
            alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: { (action) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController.init(title: username, message: description, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: { (action) in
                
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func setupDays(days: [Day]) {
        self.days.removeAll()
        self.days.append(contentsOf: days)
        self.hoursDelegate.day = self.days[self.selectedDay]
        self.calendarCollectionView.reloadData()
        self.hoursCollectionView.reloadData()
    }
    
    
    func showError(message: String) {
        
    }
    
}

