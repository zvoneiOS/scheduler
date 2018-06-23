//
//  ShadowView.swift
//  MeetingScheduler
//

import UIKit

class ShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    private func setupShadow() {
        self.layer.masksToBounds = false
        let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0);
        self.layer.shadowOpacity = 0.35
        self.layer.shadowRadius = 2.0
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupShadow()
    }
}
