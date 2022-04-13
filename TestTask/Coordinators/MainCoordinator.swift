//
//  MainCoordinator.swift
//  TestTask
//
//  Created by Lefdili Alaoui Ayoub on 12/4/2022.
//

import Foundation
import UIKit



class MainCoordinator: Coordinator {
    var childControllers: [Coordinator]? = []
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MeasurementsViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
  
}
