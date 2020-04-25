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
        
        if propertyPattern == .switch {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.reuseIdentifier) as? SwitchCell else { fatalError() }
            cell.bind(name: propertyName, isEnable: true)
            return cell
        } else if propertyPattern == .stepper {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StepperCell.reuseIdentifier) as? StepperCell else { fatalError() }
            cell.bind(name: propertyName, value: 1)
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
