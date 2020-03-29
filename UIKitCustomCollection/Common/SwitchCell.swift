//
//  SwitchCell.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/03/23.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell, BaseCellProtocol {
    
    @IBOutlet weak var propertyName: UILabel!
    private let propertySwitch = UISwitch()
    weak var delegate: SwitchCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var cellName: String = "SwitchCell"
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
 
    func bind(name: String, isEnable: Bool) {
        propertyName.text = name
        propertySwitch.isOn = isEnable
        propertySwitch.addTarget(self, action: #selector(tappedSwitch(sender:)), for: .valueChanged)
        self.accessoryView = propertySwitch
    }
    
    @objc func tappedSwitch(sender: UISwitch) {
        delegate?.tappedSwitch(self, and: sender.isOn)
    }
}

protocol SwitchCellDelegate: AnyObject {
    func tappedSwitch(_ cell: SwitchCell, and isOn: Bool)
}
