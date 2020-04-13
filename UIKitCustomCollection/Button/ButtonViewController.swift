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
    }
}

extension ButtonViewController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let property = viewModel.property(index: indexPath.row) else { return UITableViewCell() }
        let cell = UITableViewCell()
        cell.textLabel?.text = property.name
        return cell
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
