//
//  StepperCell.swift
//  UIKitCustomCollection
//
//  Created by Akatsuki on 2020/03/29.
//  Copyright © 2020 akatsuki. All rights reserved.
//

import UIKit

class StepperCell: UITableViewCell, BaseCellProtocol {
    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var propertyValue: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    weak var delegate: StepperCellDelegate?

    static var cellName: String = "StepperCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(name: String, defaultValue: Double) {
        propertyName.text = "\(name) = "
        propertyValue.text = "\(Int(defaultValue))"
        stepper.value = defaultValue
    }
    
    @IBAction func tappedStepper(_ sender: UIStepper) {
        let value = Int(sender.value)
        propertyValue.text = "\(value)"
        delegate?.tappedStepper(self, value: value)
    }
    
}

protocol StepperCellDelegate: AnyObject {
    func tappedStepper(_ cell: StepperCell, value: Int)
}
