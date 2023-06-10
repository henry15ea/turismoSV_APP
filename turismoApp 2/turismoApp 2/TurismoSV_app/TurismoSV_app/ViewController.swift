//
//  ViewController.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 5/29/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //id elementos widgets
    //variables usarios
    let alerta = Alert();
    let dataController = LoginController()
    //bridges var
    @IBOutlet weak var img_login: UIImageView!
    
    @IBOutlet weak var txt_username: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    //linker imagen
     //var img:UIImage = UIImage(named: "Image") ?? UIImage()
    
    private func fn_loadImage(){
        //img_login
        let imagen = UIImage(named: "tourism-icon-7");
        img_login.image = imagen;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fn_loadImage();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //acciones de botones de la vista
    @IBAction func btn_login(_ sender: UIButton)  {
       //verificamos que el usuario ingrese bien los datos
        if (txt_username.text == nil || txt_username.text == ""){
           let alertController = alerta.ShowAlert(ptitle: "Valores Requeridos", pmessage: "Ingresa el nombre de usuario");
            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                // Manejar el botón OK presionado aquí
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion:nil)
            
        }else if(txt_password.text == nil || txt_password.text == ""){
            let alertController = alerta.ShowAlert(ptitle: "Valores Requeridos", pmessage: "Ingresa la clave");
            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                // Manejar el botón OK presionado aquí
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion:nil)
        }else{
            let modelo = LoginModel.UserLogin(
                username: txt_username.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                password: txt_password.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            );
            dataController.fn_login2(pmodel: modelo) { success in
                DispatchQueue.main.async {
                    if success {
                        print(self.dataController.fn_GetApiStatus());
                        let dataRs = self.dataController.fn_getDataResponse();
                        //SharedPreferences.fn_SaveData(data: , key: )
                        
                        
                        
                        if (dataRs.role_user == "2" && dataRs.accessLogin == "ok"){
                         
                            //guardando datos en el sharedpreferences
                            SharedPreferences.fn_SaveData(data: dataRs.mail!, key: "mailUser");
                            SharedPreferences.fn_SaveData(data: dataRs.token_id!, key: "tokenUser");
                            SharedPreferences.fn_SaveData(data: dataRs.user!, key: "UserName");
                            SharedPreferences.fn_SaveData(data: dataRs.role_user!, key: "RoleUser");
                            SharedPreferences.fn_SaveData(data: dataRs.role_user!, key: "PkgSelected");
                            
                            let data:String = SharedPreferences.fn_GetData(key: "mailUser");
                            
                            //verificamos que el dato se haya guardado
                            if (data != nil || data != ""){
                                //print("pref \(data)");
                                let principalViewController = self.storyboard?.instantiateViewController(withIdentifier: "PrincipalViewController") as! PrincipalViewController;
                                
                                self.present(principalViewController, animated: true, completion: nil)

                            }
                            
                            //fin ingreso correcto
                            
                        }else{
                            let alertController = self.alerta.ShowAlert(ptitle: "Usuario invalido", pmessage: "Verifica el usuario y clave");
                            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                                // Manejar el botón OK presionado aquí
                            }
                            
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion:nil)
                        }
                        
                        //end login
                    } else {
                        print("fallo");
                    }
                }
            }
        }
        
        //fin verificacion
    }
    
}//end class

