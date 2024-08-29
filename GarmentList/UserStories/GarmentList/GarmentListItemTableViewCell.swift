//
//  GarmentListItemTableViewCell.swift
//  GarmentList
//
//  Created by Anton Rybaiev on 13.07.2024.
//

import UIKit

final class GarmentListItemTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: GarmentListItemTableViewCell.self)

    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with garment: Garment) {
        
        titleLabel.text = garment.name
    }
}
