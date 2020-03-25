//
//  SwitchCell.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/03/23.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {
    
    @IBOutlet weak var propertyName: UILabel!
    private let propertySwitch = UISwitch()
    var tappedSwitch: (Bool) -> Void = { _ in }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
 
    func bind(name: String, isEnable: Bool,
              index: Int, callback: () -> Void) {
        propertyName.text = name
        propertySwitch.isOn = isEnable
        propertySwitch.addTarget(self, action: #selector(tappedSwitch(sender:)), for: .touchUpInside)
        self.accessoryView = propertySwitch
    }
    
    @objc func tappedSwitch(sender: UISwitch) {
        tappedSwitch(sender.isOn)
    }
}
