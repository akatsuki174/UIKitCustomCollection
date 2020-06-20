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
        tableView.register(ActionSheetCell.nib(), forCellReuseIdentifier: ActionSheetCell.reuseIdentifier)
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
            } else if (property == .minimumScaleFactor) {
                cell.setStepValue(stepValue: 0.1, maxValue: 1.0)
            } else {
                cell.setStepValue()
            }
            if let value = values.value as? [String], property == .changeCharCount {
                cell.bind(name: propertyName, value: value)
            } else if let value = values.value as? Double, property == .minimumScaleFactor {
                cell.bind(name: propertyName, ratio: value)
            } else if let value = values.value as? CGSize, property == .shadowOffset {
                cell.bind(name: propertyName, size: CGSize(width: value.width, height: value.height))
            } else if let value = values.value as? Double {
                cell.bind(name: propertyName, value: value)
            } else {
                // あとで消す
                cell.bind(name: propertyName, value: 1)
            }
            cell.delegate = self
            return cell
        } else if propertyPattern == .detail {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ActionSheetCell.reuseIdentifier) as? ActionSheetCell else { fatalError() }
            // TODO: refactor https://medium.com/finc-engineering/casting-to-protocol-having-associatedtype-e5854994a97f
            if let value = values.value as? NSLineBreakMode {
                cell.bind(name: propertyName, value: value.name)
            } else if let value = values.value as? NSTextAlignment {
                cell.bind(name: propertyName, value: value.name)
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

extension LabelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 48
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
        case .adjustsFontSizeToFitWidth:
            customTarget.adjustsFontSizeToFitWidth = isOn
            if let value = value as? Double {
                customTarget.minimumScaleFactor = CGFloat(value)
            }
        case .shadowColor:
            customTarget.shadowColor = isOn ? viewModel.shadowColor() : UIColor.clear
            if let value = value as? CGSize {
                customTarget.shadowOffset = value
            }
        case .textColor:
            customTarget.textColor = isOn ? viewModel.textColor() : UIColor.black
        default:
            ()
        }
        viewModel.updateValue(property: property, value: isOn)
    }
}

extension LabelViewController: StepperCellDelegate {
    func tappedStepper(_ cell: StepperCell, value: Double) {
        var currentValue: Any? = value
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let property = viewModel.property(index: indexPath.row) else { return }
        if viewModel.getPropertyValues(property: property).isEnabled {
            switch property {
            case .changeCharCount:
                currentValue = nil
                let currentText = customTarget.text ?? ""
                var currentWords = currentText.components(separatedBy: " ")
                if (currentWords.count > Int(value)) {
                    currentWords.removeLast()
                    currentValue = currentWords
                } else if (currentWords.count < Int(value)) {
                    currentWords.append(viewModel.programmingLanguages.randomElement()!)
                    currentValue = currentWords
                }
                customTarget.text = currentWords.joined(separator: " ")
            case .borderWidth:
                customTarget.layer.borderColor = UIColor.black.cgColor
                customTarget.layer.borderWidth = CGFloat(value)
            case .radiusValue:
                customTarget.layer.cornerRadius = CGFloat(value)
            case .numberOfLines:
                customTarget.numberOfLines = Int(value)
            case .minimumScaleFactor:
                customTarget.minimumScaleFactor = CGFloat(value)
            case .shadowOffset:
                customTarget.shadowColor = viewModel.shadowColor()
                customTarget.shadowOffset = CGSize(width: value, height: value)
            default:
                ()
            }
        }
        guard let value = currentValue else { return }
        viewModel.updateValue(property: property, value: value)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

extension LabelViewController: ActionSheetCellDelegate {
    func tappedButton(_ cell: ActionSheetCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let property = viewModel.property(index: indexPath.row) else { return }
        switch property {
        case .lineBreakMode:
            showActionSheet(cases: NSLineBreakMode.allCases, property: property, indexPath: indexPath, completion: { [weak self] index in
                self?.customTarget.lineBreakMode = NSLineBreakMode.allCases[index]
            })
        case .textAlignment:
            showActionSheet(cases: NSTextAlignment.allCases, property: property, indexPath: indexPath, completion: { [weak self] index in
                self?.customTarget.textAlignment = NSTextAlignment.allCases[index]
            })
        default:
            ()
        }
    }
    
    private func showActionSheet<T: ReturnStringEnumNameProtocol>(cases: [T], property: LabelViewModel.LabelProperty, indexPath: IndexPath, completion: @escaping (Int) -> Void) {
        guard let firstCase = cases.first else { return }
        let alert = UIAlertController(title: "Select \(String(describing: firstCase)) value", message: nil, preferredStyle: .actionSheet)
        for (index, value) in cases.enumerated() {
            let action = UIAlertAction(title: value.name, style: .default, handler: { [weak self] _ in
                completion(index)
                self?.viewModel.updateValue(property: property, value: value)
                self?.tableView.reloadRows(at: [indexPath], with: .none)
            })
            alert.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
