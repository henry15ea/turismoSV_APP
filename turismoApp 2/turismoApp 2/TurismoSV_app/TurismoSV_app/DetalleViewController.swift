//
//  DetalleViewController.swift
//  TurismoSV_app
//
//  Created by ronald on 8/6/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController {
    //variables usuario
    var nom:String?;
    var des:String?
    var direccion:String?
    var imgurl:String?
    var precio:Double=0
    var cupos_disp:String?
    var cuposllenos:String?
    var fechainicial:String?
    var fechafinal:String?

    var detallePaquete = infoPaqueteModel.detallePaquete.init(nom: nil, des: nil, direccion: nil, imgurl: nil, precio: 0.00, cupos_disp: nil, cuposllenos: nil, fechainicial: nil, fechafinal: nil);
    var stateCompra:Bool = false;
    var titleState:String = "Compra";
    
    //binding a la vista
    
    @IBOutlet weak var topNavbar: UINavigationBar!
    
    @IBOutlet weak var imgview: UIImageView!
    
    //@IBOutlet weak var txt_nombre: UILabel!
    
    @IBOutlet weak var txt_des: UILabel!
    
    @IBOutlet weak var txt_dir: UILabel!
    
    @IBOutlet weak var txt_precio: UILabel!
    
    @IBOutlet weak var txt_cupos: UILabel!
    
    @IBOutlet weak var txt_cuposllenos: UILabel!
    
    @IBOutlet weak var txt_fechin: UILabel!
    
    @IBOutlet weak var txt_fechfin: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //inciando elementos
        self.topNavbar.topItem?.title = nom?.trimmingCharacters(in: .whitespacesAndNewlines);
        
        imgview.image=cls_ImagenUrl.fn_LoadImageUrl(from: imgurl!, defaultImage: "icono-rutas")
        //txt_nombre.text=nom
        txt_des.text=des
        txt_dir.text=direccion
        txt_precio.text="$ \(precio)"
        txt_cupos.text=cupos_disp
        txt_cuposllenos.text=cuposllenos
        txt_fechin.text=fechainicial
        txt_fechfin.text=fechafinal
        
        self.detallePaquete = infoPaqueteModel.detallePaquete(
            nom: nom,
            des: des,
            direccion: direccion,
            imgurl: imgurl,
            precio: precio,
            cupos_disp: cupos_disp,
            cuposllenos: cuposllenos,
            fechainicial: fechainicial,
            fechafinal: fechafinal
        );
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //boton para regresar a la pantalla anterior
    @IBAction func btnVolver(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //funcion para preparar el segue para que reciva datos
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sg_compraReserva" {
            if let CompraReservaViewController = segue.destination as? CompraReservaViewController {
                CompraReservaViewController.StateEmitedFactura = stateCompra;
                CompraReservaViewController.TitleTopNavbar = self.titleState;
                CompraReservaViewController.detallePaquete = self.detallePaquete;
            }
        }
    }

    
    //boton reserva
    
    @IBAction func btn_reserva(_ sender: Any) {
        self.stateCompra = false;
        self.titleState = "Reservar";
        performSegue(withIdentifier: "sg_compraReserva", sender: self)
    }
    
    
    //boton compra
    
    
    @IBAction func btn_compra(_ sender: Any) {
        self.stateCompra = true;
        self.titleState = "Comprar";
        performSegue(withIdentifier: "sg_compraReserva", sender: self)

    }
    

}
