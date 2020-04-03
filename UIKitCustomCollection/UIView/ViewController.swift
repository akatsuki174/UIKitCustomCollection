//
//  ViewController.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/03/20.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customTarget: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SwitchCell.nib(), forCellReuseIdentifier: SwitchCell.reuseIdentifier)
        tableView.register(StepperCell.nib(), forCellReuseIdentifier: StepperCell.reuseIdentifier)
    }
}

extension ViewController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let property = viewModel.property(index: indexPath.row) else { return UITableViewCell() }
        let propertyPattern = property.customPattern()
        let propertyName = property.name()
        let values = viewModel.getPropertyValues(property: property)

        if propertyPattern == .switch {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.reuseIdentifier) as? SwitchCell else { fatalError() }
            cell.bind(name: propertyName, isEnable: values.isEnabled)
            cell.delegate = self
            return cell
        } else if propertyPattern == .stepper {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StepperCell.reuseIdentifier) as? StepperCell else { fatalError() }
            cell.bind(name: propertyName, value: values.value ?? 0)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: SwitchCellDelegate {
    func tappedSwitch(_ cell: SwitchCell, and isOn: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let property = viewModel.property(index: indexPath.row) else { return }
        let value = viewModel.getPropertyValues(property: property).value ?? 0
        switch property {
        case .backgroundColor:
            customTarget.backgroundColor = isOn ? UIColor.systemTeal : UIColor.clear
        case .border:
            customTarget.layer.borderColor = UIColor.black.cgColor
            customTarget.layer.borderWidth = CGFloat(isOn ? value : 0)
        case .radius:
            customTarget.layer.cornerRadius = CGFloat(isOn ? value : 0)
            customTarget.layer.masksToBounds = true
        default:
            ()
        }
        viewModel.updateValue(property: property, value: isOn)
    }
}

extension ViewController: StepperCellDelegate {
    func tappedStepper(_ cell: StepperCell, value: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let property = viewModel.property(index: indexPath.row) else { return }
        switch property {
        case .borderWidth:
            if viewModel.getPropertyValues(property: property).isEnabled {
                customTarget.layer.borderColor = UIColor.black.cgColor
                customTarget.layer.borderWidth = CGFloat(value)
            }
            viewModel.updateValue(property: property, value: Double(value))
        default:
            ()
        }
    }
}
