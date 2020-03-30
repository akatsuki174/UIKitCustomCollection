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
        
        if propertyPattern == .switch {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.reuseIdentifier) as? SwitchCell else { fatalError() }
            cell.bind(name: propertyName, isEnable: true)
            cell.delegate = self
            return cell
        } else if propertyPattern == .stepper {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StepperCell.reuseIdentifier) as? StepperCell else { fatalError() }
            cell.bind(name: propertyName, defaultValue: 1)
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
        
    }
}

extension ViewController: StepperCellDelegate {
    func tappedStepper(_ cell: StepperCell, value: Int) {
    
    }
}
