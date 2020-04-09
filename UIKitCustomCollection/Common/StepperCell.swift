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
    
    func bind(name: String, value: Double?) {
        propertyName.text = "\(name) = "
        guard let v = value else { return }
        propertyValue.text = "\(Int(v))"
        stepper.value = v
    }
    
    func bind(name: String, ratio: Double?) {
        propertyName.text = "\(name) = "
        if let r = ratio {
            propertyValue.text = "\(round(r * 10) / 10)"
            stepper.value = r
        }
    }
    
    func bind(name: String, size: CGSize) {
        propertyName.text = "\(name) = "
        propertyValue.text = "(\(Int(size.width)), \(Int(size.height)))"
        stepper.value = Double(size.width)
    }
    
    func setForPercentageValue() {
        stepper.stepValue = 0.1
        stepper.maximumValue = 1.0
    }
    
    @IBAction func tappedStepper(_ sender: UIStepper) {
        delegate?.tappedStepper(self, value: sender.value)
    }
    
}

protocol StepperCellDelegate: AnyObject {
    func tappedStepper(_ cell: StepperCell, value: Double)
}
