//
//  ButtonViewController.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/04/13.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import UIKit

class ButtonViewController: UIViewController {
    
    @IBOutlet weak var customTarget: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ButtonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SwitchCell.nib(), forCellReuseIdentifier: SwitchCell.reuseIdentifier)
        tableView.register(StepperCell.nib(), forCellReuseIdentifier: StepperCell.reuseIdentifier)
    }
}

extension ButtonViewController: UITableViewDataSource {
 
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
            if (property == .shadowOpacity) {
                cell.setForPercentageValue()
            } else {
                cell.setForNormalValue()
            }
            if let value = values.value as? Double {
                cell.bind(name: propertyName, value: value)
            } else if let shadowProperties = values.value as? ShadowProperties {
                switch property {
                case .shadowOffset:
                    cell.bind(name: propertyName, size: shadowProperties.shadowOffset)
                case .shadowOpacity:
                    cell.bind(name: propertyName, ratio: Double(shadowProperties.shadowOpacity))
                case .shadowRadius:
                    cell.bind(name: propertyName, value: shadowProperties.shadowRadius)
                default:
                    ()
                }
            }
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
}

extension ButtonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ButtonViewController: SwitchCellDelegate {
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
            }
        case .shadow:
            customTarget.layer.shadowColor = UIColor.black.cgColor
            if let properties = value as? ShadowProperties {
                customTarget.layer.shadowOffset = properties.shadowOffset
                customTarget.layer.shadowRadius = CGFloat(properties.shadowRadius)
                
                let shadowOpacity = isOn ? properties.shadowOpacity : 0.0
                customTarget.layer.shadowOpacity = Float(shadowOpacity)
            }
        case .textColor:
            if viewModel.defaultTextColor == nil {
                viewModel.defaultTextColor = customTarget.titleColor(for: .normal)
            }
            let color = isOn ? UIColor.systemPurple : viewModel.defaultTextColor
            customTarget.setTitleColor(color, for: .normal)
        case .tappedText:
            let text = isOn ? "tapped" : "Button"
            customTarget.setTitle(text, for: .highlighted)
        case .tappedTextColor:
            if viewModel.defaultTextColor == nil {
                viewModel.defaultTextColor = customTarget.titleColor(for: .highlighted)
            }
            let color = isOn ? UIColor.systemRed : viewModel.defaultTextColor
            customTarget.setTitleColor(color, for: .highlighted)
        case .disabledText:
            let text = isOn ? "disabled" : "Button"
            customTarget.setTitle(text, for: .disabled)
            customTarget.isEnabled = !isOn
        case .disabledTextColor:
            if viewModel.defaultDisabledTextColor == nil {
                viewModel.defaultDisabledTextColor = customTarget.titleColor(for: .disabled)
            }
            let color = isOn ? UIColor.systemGray : viewModel.defaultDisabledTextColor
            customTarget.setTitleColor(color, for: .disabled)
        case .image:
            let image = isOn ? UIImage(systemName: "paperplane.fill") : nil
            customTarget.setImage(image, for: .normal)
        case .backgroundImage:
            let image = isOn ? UIImage(named: "backgroundImage") : nil
            customTarget.setBackgroundImage(image, for: .normal)
        default:
            ()
        }
        viewModel.updateValue(property: property, value: isOn)
    }
}

extension ButtonViewController: StepperCellDelegate {
    func tappedStepper(_ cell: StepperCell, value: Double) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let property = viewModel.property(index: indexPath.row) else { return }
        if viewModel.getPropertyValues(property: property).isEnabled {
            switch property {
            case .borderWidth:
                customTarget.layer.borderColor = UIColor.black.cgColor
                customTarget.layer.borderWidth = CGFloat(value)
            case .radiusValue:
                customTarget.layer.cornerRadius = CGFloat(value)
            case .shadowOffset:
                customTarget.layer.shadowOffset = CGSize(width: value, height: value)
            case .shadowOpacity:
                customTarget.layer.shadowOpacity = Float(value)
            case .shadowRadius:
                customTarget.layer.shadowRadius = CGFloat(value)
            default:
                ()
            }
        }
        viewModel.updateValue(property: property, value: Double(value))
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
