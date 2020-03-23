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
    @IBOutlet weak var propertySwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    func bind(name: String, isEnable: Bool) {
        propertyName.text = name
        propertySwitch.isOn = isEnable
    }
}
