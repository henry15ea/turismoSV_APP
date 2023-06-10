//
//  RegistroViewController.swift
//  TurismoSV_app
//
//  Created by ronald on 9/6/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import UIKit

class RegistroViewController: UIViewController {
    
    
    let alerta = Alert();
    let dataController = RegistroController()
    
    
    
    
    @IBOutlet weak var txtuser: UITextField!
    @IBOutlet weak var txtnombre: UITextField!
    @IBOutlet weak var txtapellido: UITextField!
    @IBOutlet weak var txtedad: UITextField!
    @IBOutlet weak var txttel: UITextField!
    @IBOutlet weak var txtdir: UITextField!
    @IBOutlet weak var txtcorreo: UITextField!
    @IBOutlet weak var txtxcontra: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnback(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRegistro(_ sender: Any) {
        if (txtuser.text=="" || txtnombre.text=="" ||
            txtapellido.text=="" || txtedad.text=="" ||
            txttel.text=="" || txtdir.text=="" ||
            txtcorreo.text=="" || txtcorreo.text=="")
        {
            let alertController = alerta.ShowAlert(ptitle: "Valores Requeridos", pmessage: "Ingresa todos los datos");
            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                // Manejar el botón OK presionado aquí
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion:nil)
            
        }else{
            let ed:Int=Int(txtedad.text!)!
            dataController.setDatos(uname: txtuser.text!, nombre: txtnombre.text!, apellido: txtapellido.text!, edad: ed, telefono: txttel.text!, dir: txtdir.text!, correo: txtcorreo.text!, contra: txtxcontra.text!)
            dataController.fn_login2() { success in
                DispatchQueue.main.async {
                    if success {
                        let alertController = self.alerta.ShowAlert(ptitle: "Resultado", pmessage: self.dataController.fn_GetApiStatus());
                        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                            if(self.dataController.fn_GetApiStatus()=="Usuario registrado correctamente"){
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion:nil)
                        
                        
                        
                        //end login
                    }else {
                        let alertController = self.alerta.ShowAlert(ptitle: "Resultado", pmessage: "algo salio mal");
                        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in}
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion:nil)
                        
                        
                    }
                }
            }
        }
    }
    
    
}

