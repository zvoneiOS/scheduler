//
//  HoursDSDelegate.swift
//  MeetingScheduler
//

import UIKit

class HoursDSDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var presenter:MainPresenterProtocol?
    var day:Day?
    var selectedFrame: CGRect?
    var label: UILabel?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return day != nil ? 20 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HoursCVC", for: indexPath) as! HoursCVC
        cell.configureCell(hour: self.day!.hours![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let halfWidth = (UIScreen.main.bounds.width - 12)/2
        return CGSize.init(width: halfWidth, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HoursCVC
        label = cell.timeLabel
        let theAttributes: UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
        selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)

        if(self.day!.hours![indexPath.row].taken){
        self.presenter?.openDescription(description: self.day!.hours![indexPath.row].description!, username: self.day!.hours![indexPath.row].username!, hour: self.day!.hours![indexPath.row], day: self.day!)
        }else{
            self.presenter?.openTakeTerminScreen(hour:self.day!.hours![indexPath.row], day: self.day!)
            
        }
    }
}
