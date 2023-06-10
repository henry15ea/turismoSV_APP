//
//  HistorialTableViewCell.swift
//  TurismoSV_app
//
//  Created by ronald on 7/6/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import UIKit

class HistorialTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var txt_factura: UILabel!
    
    @IBOutlet weak var txt_paquete: UILabel!
    
    @IBOutlet weak var txt_total: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
