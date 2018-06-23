//
//  IntroVC.swift
//  MeetingScheduler
//

import UIKit

class IntroVC: UIViewController {

    var presenter: IntroPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupController()
        self.presenter?.switchToMainController()
        self.presenter?.viewDidLoad()
        self.navigationItem.title = "MeetingScheduler"
    }
    
    func setupController(){
        let presenter: IntroPresenterProtocol & IntroInteractorOutputProtocol = IntroScreenPresenter()
        let interactor: IntroInteractorInputProtocol = IntroInteractor()
        let wireFrame: IntroWireFrameProtocol = IntroWireFrame()
        
        self.presenter = presenter
        presenter.view = self
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        self.presenter?.openLoginScreen()
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        self.presenter?.openRegisterScreen()
    }
    
}

extension IntroVC: IntroViewProtocol{
    
}
