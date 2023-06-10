//
//  CategoriasTableViewCell.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/2/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import UIKit

class CategoriasTableViewCell: UITableViewCell {

    
    @IBOutlet weak var txt_titulo: UILabel!
    
    @IBOutlet weak var txt_costo: UILabel!
    
    @IBOutlet weak var txt_cuposDisp: UILabel!
    
    @IBOutlet weak var txt_detalle: UILabel!
    
    @IBOutlet weak var img_paquete: UIImageView!
    
    @IBOutlet weak var txt_cuposLlenos: UILabel!
    
    
    @IBOutlet weak var btn_reservar: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
