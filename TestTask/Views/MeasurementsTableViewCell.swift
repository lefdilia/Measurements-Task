//
//  MeasurementsCollectionViewCell.swift
//  TestTask
//
//  Created by Lefdili Alaoui Ayoub on 12/4/2022.
//

import UIKit



class MeasurementsTableViewCell: UITableViewCell {
    
    static var identifier = "MeasurementsCell"
    
    var measurementsModel: MeasurementModel? {
        didSet{
            
            for view in MeasurementStack.subviews {
                MeasurementStack.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            
            guard let measurementsModel = measurementsModel else { return }
            
            ///Top Name
            let name = "\(measurementsModel.name)"
            let nameAttributedText = NSMutableAttributedString(string: "Name: ", attributes: [
                .font: UIFont(name: Theme.CentryGothicBold, size: 14)!,
                .foregroundColor: UIColor.black
            ])
            
            nameAttributedText.append(NSAttributedString(string: "\(name)", attributes: [
                .font: UIFont(name: Theme.CentryGothicRegular, size: 14)!,
                .foregroundColor: UIColor.black
            ]))
            
            nameLabel.attributedText = nameAttributedText
            
            ///Top Unit
            if let unit = measurementsModel.unit {
                let unitAttributedText = NSMutableAttributedString(string: "Unit: ", attributes: [
                    .font: UIFont(name: Theme.CentryGothicBold, size: 15)!,
                    .foregroundColor: UIColor.black
                ])
                
                unitAttributedText.append(NSAttributedString(string: unit, attributes: [
                    .font: UIFont(name: Theme.CentryGothicRegular, size: 15)!,
                    .foregroundColor: UIColor.black
                ]))
                
                unitLabel.attributedText = unitAttributedText
            }else{
                unitLabel.attributedText = nil
            }
            
            for measurement in measurementsModel.measurements {
                let view = createDataStack(measurement: measurement)
                MeasurementStack.addArrangedSubview(view)
            }
        }
    }
    
    private func createDataStack(measurement: [Measurement]) -> UIView {
        
        let stackContainer: UIView = {
            let container = UIView()
            container.translatesAutoresizingMaskIntoConstraints = false
            return container
        }()
        
        ///Time
        let measurementTimeLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            return label
        }()
        
        if let time = measurement[0].name as? Double {
            measurementTimeLabel.attributedText = NSAttributedString(string: time.toReadable(format: "MM-dd-yyyy HH:mm:ss"), attributes: [
                .font: UIFont(name: Theme.CentryGothicRegular, size: 14)!,
                .foregroundColor: UIColor.black ])
        }
        
        ///Data
        let measurementDataLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        var attributes = NSAttributedString()
        
        if let textString = measurement.last?.name as? Double {
            attributes = NSAttributedString(string: "\(textString)", attributes: [
                .font: UIFont(name: Theme.CentryGothicRegular, size: 14)!,
                .foregroundColor: UIColor.black
            ])
        }
        
        if let location = measurement.last?.name as? [Double] {
            let mapped = location.map({"\($0)"}).joined(separator: "\n")
            attributes = NSAttributedString(string: mapped, attributes: [
                .font: UIFont(name: Theme.CentryGothicRegular, size: 14)!,
                .foregroundColor: UIColor.black
            ])
        }
        
        if let defaultString = measurement.last?.name as? String {
            attributes = NSAttributedString(string: defaultString, attributes: [
                .font: UIFont(name: Theme.CentryGothicRegular, size: 14)!,
                .foregroundColor: UIColor.black
            ])
        }
        
        measurementDataLabel.attributedText = attributes
        
        stackContainer.addSubview(measurementDataLabel)
        stackContainer.addSubview(measurementTimeLabel)
        
        NSLayoutConstraint.activate([
            measurementDataLabel.topAnchor.constraint(equalTo: stackContainer.topAnchor),
            measurementDataLabel.leadingAnchor.constraint(equalTo: stackContainer.leadingAnchor),
            measurementDataLabel.widthAnchor.constraint(equalTo: stackContainer.widthAnchor, multiplier: 0.54),
            measurementDataLabel.bottomAnchor.constraint(equalTo: stackContainer.bottomAnchor),
            
            measurementTimeLabel.topAnchor.constraint(equalTo: measurementDataLabel.topAnchor),
            measurementTimeLabel.leadingAnchor.constraint(equalTo: measurementDataLabel.trailingAnchor),
            measurementTimeLabel.trailingAnchor.constraint(equalTo: stackContainer.trailingAnchor),
            measurementTimeLabel.bottomAnchor.constraint(equalTo: measurementDataLabel.bottomAnchor),
        ])
        
        return stackContainer
    }
    
    //MARK: - Top Stack
    let measurementTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Measurements", attributes: [
            .font: UIFont(name: Theme.CentryGothicBold, size: 14)!,
            .foregroundColor: UIColor.black
        ])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Time", attributes: [
            .font: UIFont(name: Theme.CentryGothicBold, size: 14)!,
            .foregroundColor: UIColor.black
        ])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let initStackLabels: UIView = {
        let container = UIView()
        container.backgroundColor = .red.withAlphaComponent(0.3)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let unitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var topLabelsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, unitLabel])
        stack.distribution = .equalCentering
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Measurement Stack
    lazy var MeasurementStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let globalView: UIView = {
        let globalView = UIView()
        globalView.backgroundColor = .hintOfRed
        globalView.layer.cornerRadius = 11
        globalView.layer.masksToBounds = true
        globalView.translatesAutoresizingMaskIntoConstraints = false
        return globalView
    }()
    
    //MARK: - Setup Views
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(globalView)
        globalView.addSubview(topLabelsStack)
        globalView.addSubview(MeasurementStack)
        
        globalView.addSubview(timeTitleLabel)
        globalView.addSubview(measurementTitleLabel)
        
        NSLayoutConstraint.activate([
            
            globalView.topAnchor.constraint(equalTo: topAnchor),
            globalView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            globalView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            globalView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            topLabelsStack.topAnchor.constraint(equalTo: globalView.topAnchor, constant: 15),
            topLabelsStack.leadingAnchor.constraint(equalTo: globalView.leadingAnchor, constant: 10),
            topLabelsStack.trailingAnchor.constraint(equalTo: globalView.trailingAnchor, constant: -10),
            topLabelsStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 25),
            
            measurementTitleLabel.topAnchor.constraint(equalTo: topLabelsStack.bottomAnchor, constant: 20),
            measurementTitleLabel.leadingAnchor.constraint(equalTo: topLabelsStack.leadingAnchor),
            measurementTitleLabel.heightAnchor.constraint(equalToConstant: 15),
            
            timeTitleLabel.leadingAnchor.constraint(equalTo: topLabelsStack.centerXAnchor, constant: 20),
            timeTitleLabel.centerYAnchor.constraint(equalTo: measurementTitleLabel.centerYAnchor),
            
            MeasurementStack.topAnchor.constraint(equalTo: timeTitleLabel.bottomAnchor, constant: 12),
            MeasurementStack.leadingAnchor.constraint(equalTo: topLabelsStack.leadingAnchor),
            MeasurementStack.trailingAnchor.constraint(equalTo: topLabelsStack.trailingAnchor),
            MeasurementStack.bottomAnchor.constraint(equalTo: globalView.bottomAnchor, constant: -15),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
