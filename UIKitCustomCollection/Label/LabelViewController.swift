//
//  LabelViewController.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/04/20.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import UIKit

class LabelViewController: UIViewController {
    @IBOutlet weak var customTarget: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = LabelViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SwitchCell.nib(), forCellReuseIdentifier: SwitchCell.reuseIdentifier)
        tableView.register(StepperCell.nib(), forCellReuseIdentifier: StepperCell.reuseIdentifier)
    }
}

extension LabelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let property = viewModel.property(index: indexPath.row) else { return UITableViewCell() }
        let propertyPattern = property.customPattern()
        let propertyName = property.name
        let values = viewModel.getPropertyValues(property: property)
        
        if propertyPattern == .switch {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.reuseIdentifier) as? SwitchCell else { fatalError() }
            cell.bind(name: propertyName, isEnable: values.isEnabled)
            cell.delegate = self
            return cell
        } else if propertyPattern == .stepper {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StepperCell.reuseIdentifier) as? StepperCell else { fatalError() }
            if (property == .numberOfLines) {
                cell.setStepValue(stepValue: 1.0, maxValue: 2.0)
            } else {
                cell.setStepValue()
            }
            if let value = values.value as? String {
                cell.bind(name: propertyName, value: value)
            } else if let value = values.value as? Double {
                cell.bind(name: propertyName, value: value)
            } else {
                // あとで消す
                cell.bind(name: propertyName, value: 1)
            }
            cell.delegate = self
            return cell
        } else if propertyPattern == .detail {
            let cell = UITableViewCell()
            cell.textLabel?.text = propertyName
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
}

extension LabelViewController: SwitchCellDelegate {
    func tappedSwitch(_ cell: SwitchCell, and isOn: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let property = viewModel.property(index: indexPath.row) else { return }
        let value = viewModel.getPropertyValues(property: property).value ?? 0
        switch property {
        case .backgroundColor:
            customTarget.backgroundColor = isOn ? UIColor.systemTeal : UIColor.clear
        case .border:
            customTarget.layer.borderColor = UIColor.black.cgColor
            if let value = value as? Double {
                customTarget.layer.borderWidth = CGFloat(isOn ? value : 0)
            }
        case .radius:
            if let value = value as? Double {
                customTarget.layer.cornerRadius = CGFloat(isOn ? value : 0)
                customTarget.clipsToBounds = true
            }
        default:
            ()
        }
        viewModel.updateValue(property: property, value: isOn)
    }
}

extension LabelViewController: StepperCellDelegate {
    func tappedStepper(_ cell: StepperCell, value: Double) {
        var currentValue: Any = value
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let property = viewModel.property(index: indexPath.row) else { return }
        if viewModel.getPropertyValues(property: property).isEnabled {
            switch property {
            case .changeCharCount:
                let currentText = customTarget.text ?? ""
                if (currentText.count > Int(value)) {
                    customTarget.text = String(currentText.dropLast())
                } else if (currentText.count < Int(value)) {
                    customTarget.text = currentText + "a"
                }
                currentValue = customTarget.text ?? ""
            case .borderWidth:
                customTarget.layer.borderColor = UIColor.black.cgColor
                customTarget.layer.borderWidth = CGFloat(value)
            case .radiusValue:
                customTarget.layer.cornerRadius = CGFloat(value)
            case .numberOfLines:
                customTarget.numberOfLines = Int(value)
            default:
                ()
            }
        }
        viewModel.updateValue(property: property, value: currentValue)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
