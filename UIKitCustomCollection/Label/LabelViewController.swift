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
            cell.bind(name: propertyName, isEnable: true)
            return cell
        } else if propertyPattern == .stepper {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StepperCell.reuseIdentifier) as? StepperCell else { fatalError() }
            if let value = values.value as? String {
                cell.bind(name: propertyName, value: value)
            } else {
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

extension LabelViewController: StepperCellDelegate {
    func tappedStepper(_ cell: StepperCell, value: Double) {
        var currentValue: Any = value
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let property = viewModel.property(index: indexPath.row) else { return }
        if viewModel.getPropertyValues(property: property).isEnabled {
            switch property {
            case .increaseCharacters:
                let currentText = customTarget.text ?? ""
                if (currentText.count > Int(value)) {
                    customTarget.text = String(currentText.dropLast())
                } else if (currentText.count < Int(value)) {
                    customTarget.text = currentText + "a"
                }
                currentValue = customTarget.text ?? ""
            default:
                ()
            }
        }
        viewModel.updateValue(property: property, value: currentValue)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}