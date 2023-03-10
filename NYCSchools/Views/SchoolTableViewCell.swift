//
//  SchoolTableViewCell.swift
//  NYCSchools
//
//  Created by Maxim Makhun on 26.01.2023.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBackgroundView: CellBackgroundView!
    
    @IBOutlet weak var schoolLocationImageView: UIImageView!
    
    @IBOutlet weak var schoolNameLabel: SchoolNameLabel!
    
    @IBOutlet weak var schoolAddressLabel: SchoolAddressLabel!
    
    @IBOutlet weak var schoolEmailLabel: SchoolEmailLabel!
    
    @IBOutlet weak var schoolWebsiteLabel: SchoolWebsiteLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        
        let cornerRadius = 10.0
        
        cellBackgroundView.clipsToBounds = true
        cellBackgroundView.layer.cornerRadius = cornerRadius
        
        schoolLocationImageView.clipsToBounds = true
        schoolLocationImageView.contentMode = .scaleAspectFill
        schoolLocationImageView.layer.cornerRadius = cornerRadius
        schoolLocationImageView.layer.borderColor = UIColor.white.cgColor
        schoolLocationImageView.layer.borderWidth = 1.0
    }
}
