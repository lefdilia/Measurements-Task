//
//  Coordinator.swift
//  TestTask
//
//  Created by Lefdili Alaoui Ayoub on 12/4/2022.
//

import Foundation
import UIKit


protocol Coordinator {
    var childControllers: [Coordinator]? { get set }
    var navigationController: UINavigationController? { get set }
    
    func start()
}
