//
//  DetailCell.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/04/25.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import UIKit

class ActionSheetCell: UITableViewCell, BaseCellProtocol {

    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var propertyValue: UILabel!
    weak var delegate: ActionSheetCellDelegate?
    
    static var cellName: String = "ActionSheetCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .default
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(name: String, value: String) {
        propertyName.text = name
        propertyValue.text = value
    }
    
    @IBAction func tappedButton(_ sender: Any) {
        
    }
    
    
    @objc func showPicker() {
        delegate?.tappedButton()
    }
}

protocol ActionSheetCellDelegate: AnyObject {
    func tappedButton()
}
