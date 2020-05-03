//
//  DetailCell.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/04/25.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import UIKit

class PickerCell: UITableViewCell, BaseCellProtocol {

    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var propertyValue: UILabel!
    weak var delegate: PickerCellDelegate?
    
    static var cellName: String = "PickerCell"
    
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
}

protocol PickerCellDelegate: AnyObject {
    func tappedPickerButton(_ cell: PickerCell, index: Int)
}
