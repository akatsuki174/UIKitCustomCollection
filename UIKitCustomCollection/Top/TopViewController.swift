//
//  ViewController.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/03/18.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let viewModel = TopViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TopViewController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.part(index: indexPath.row)?.name()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
}

extension TopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let part = viewModel.part(index: indexPath.row) else { return }
        let storyboard = UIStoryboard(name: part.storyboardName(), bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else { return }
        vc.title = part.name()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
