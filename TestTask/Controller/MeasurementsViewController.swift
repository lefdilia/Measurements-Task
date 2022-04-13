//
//  ViewController.swift
//  TestTask
//
//  Created by Lefdili Alaoui Ayoub on 11/4/2022.
//

import UIKit

class MeasurementsViewController: UIViewController {
    
    var measurementsList = [MeasurementModel]()
    
    let networdManager = NetworkManager()
    let url = "http://wsdemo.envdev.io/sse"
    
    weak var coordinator: MainCoordinator?
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Measurements"
        label.font = UIFont(name: Theme.CentryGothicBold, size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Top Header (TableView)
    lazy var MeasurementsTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .white
        tableview.register(MeasurementsTableViewCell.self, forCellReuseIdentifier: MeasurementsTableViewCell.identifier)
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.estimatedRowHeight = 202
        tableview.rowHeight = UITableView.automaticDimension
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networdManager.delegate = self
        networdManager.startRequest(url: url)
        
        view.backgroundColor = .white
        
        view.addSubview(headerLabel)
        view.addSubview(MeasurementsTableView)
        NSLayoutConstraint.activate([
            
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            headerLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 28),
            
            MeasurementsTableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
            MeasurementsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            MeasurementsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            MeasurementsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}


extension MeasurementsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return measurementsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MeasurementsTableViewCell.identifier, for: indexPath) as! MeasurementsTableViewCell
        
        let measurements = measurementsList[indexPath.row]
        cell.measurementsModel = measurements
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MeasurementsViewController: DataPresentable {
    func presentData(data: [MeasurementModel]) {
        
        self.measurementsList.insert(contentsOf: data, at: 0)
        
        DispatchQueue.main.async { [weak self] in
            self?.MeasurementsTableView.reloadSections([0], with: UITableView.RowAnimation.fade)
        }
    }
}
