//
//  PrincipalViewController.swift/Users/henryguzman/Documents/Normas_estandares/ejercicios/turismoApp/TurismoSV_app/TurismoSV_app/PrincipalViewController.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/1/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource {
    //variables de usuario
    let alerta = Alert();
    let dataController = ultimosPaquetesController();
    var ultimosPkg = [ultimosPkgResponseModel.dataResponseModel]();
    var SeletedItem:String = "null";
    
    //variables necesarias para funciones
    var nombre1:String="null";
    var des1:String="null";
    var direccion1:String="null";
    var imgurl1:String="null";
    var precio1:Double=0
    var cupos_disp1:String="null";
    var cuposllenos1:String="null";
    var fechainicial1:String="null";
    var fechafinal1:String="null";
    //bridges o conector con la vista
    
    @IBOutlet weak var NavBarBottom: UITabBar!
    @IBOutlet weak var tbl_ultimosPaquetes: UITableView!
    
    
    func fn_registerTableViewCells(){
        //esta funcion sirve para hacer el registro de la custom celda llamada CategoriasTableViewCell al table view que tenemos en la pantalla principal
        
        let textFlied = UINib(nibName: "CategoriasTableViewCell", bundle: nil);
        self.tbl_ultimosPaquetes.register(textFlied, forCellReuseIdentifier: "CategoriasTableViewCell");
    }
    
    private func fn_load(){
        //funcion que se encarga de obtener los datos del controlador api para luego asignarlo a la tabla
        dataController.fn_GetUltimosPaquetes(){ success in
            DispatchQueue.main.async {
                if success {
                    let dataModels = self.dataController.getData()
                    
                    self.ultimosPkg = dataModels!;
                    
                    self.tbl_ultimosPaquetes.reloadData();
                    
                }else{
                    
                    
                }
            }
        }
        
    }//end func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NavBarBottom.delegate = self;
        // incializar datos
        self.tbl_ultimosPaquetes.dataSource = self;
        self.tbl_ultimosPaquetes.delegate = self;
        self.fn_registerTableViewCells();
        
        //llamamos a la api
        self.fn_load();
        self.tbl_ultimosPaquetes.reloadData();
        
        
        
    }//end func

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }//end func
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //esta funcion es para desplazarse entre pantallas con los iconos que estan abajo
        switch item.tag { // Realizar acciones específicas según el tag del item presionado
        case 0:
        // Acciones para el primer item
            self.performSegue(withIdentifier: "categoriasView", sender: self);
        case 1:
        // Acciones para el segundo item
            self.performSegue(withIdentifier: "paquetesView", sender: self);
        case 2:
        // Acciones para el tercer item
            self.performSegue(withIdentifier: "historialView", sender: self);
        case 3:
        // Acciones para el cuarto item
            self.performSegue(withIdentifier: "cuentaView", sender: self);
        default:
            break
        }
    }
    //end fun
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ultimosPkg.count;
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //acciones de tabla
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriasTableViewCell") as? CategoriasTableViewCell {
            // Asigna los datos de la categoría a la celda correspondiente
            let datosApi = self.ultimosPkg[indexPath.row]
            cell.txt_titulo.text = datosApi.Nombre?.trimmingCharacters(in: .whitespacesAndNewlines);
            
            let precioD = datosApi.Precio!;
            let precioS = String(describing: precioD);
        
            cell.txt_costo.text = "$ \(precioS)";
            cell.txt_cuposDisp.text = datosApi.Cupos_disp?.trimmingCharacters(in: .whitespacesAndNewlines);
            cell.txt_detalle.text = datosApi.Descripcion?.trimmingCharacters(in: .whitespacesAndNewlines);
            cell.img_paquete.image = cls_ImagenUrl.fn_LoadImageUrl(from: datosApi.Img!, defaultImage: "icono-rutas");
            cell.txt_cuposLlenos.text=datosApi.Cuposllenos?.trimmingCharacters(in: .whitespacesAndNewlines);
            
            
            
            // Devuelve la celda configurada
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(tableView.cellForRow(at: indexPath)?.isSelected==true){
            /*
            //print(ultimosPkg[indexPath.row].Idpaqueted!);
            let alertController = self.alerta.ShowAlert(ptitle: "Cerrar sesion", pmessage:ultimosPkg[indexPath.row].Idpaqueted! );
            
            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            }
            
            alertController.addAction(okAction);
            
            self.present(alertController, animated: true, completion:nil)
            
            //self.fn_load()
            //self.tbl_ultimosPaquetes.reloadData()*/
            let id_pkg = ultimosPkg[indexPath.row].Idpaqueted!;
            SharedPreferences.fn_SaveData(data: id_pkg.trimmingCharacters(in: .whitespacesAndNewlines), key: "PkgSelected");
            self.nombre1=ultimosPkg[indexPath.row].Nombre!
            self.des1=ultimosPkg[indexPath.row].Descripcion!
            self.direccion1=ultimosPkg[indexPath.row].Direccion!
            self.imgurl1=ultimosPkg[indexPath.row].Img!
            self.precio1=ultimosPkg[indexPath.row].Precio!
            self.cupos_disp1=ultimosPkg[indexPath.row].Cupos_disp!
            self.cuposllenos1=ultimosPkg[indexPath.row].Cuposllenos!
            self.fechainicial1=ultimosPkg[indexPath.row].Fechainicial!
            self.fechafinal1=ultimosPkg[indexPath.row].Fechafinal!
            self.performSegue(withIdentifier: "Detalle1", sender: self);
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detalle1" {
            if let destino = segue.destination as? DetalleViewController {
                destino.nom = self.nombre1;
                destino.des=self.des1;
                destino.direccion=self.direccion1
                destino.imgurl=self.imgurl1
                destino.precio=self.precio1
                destino.cupos_disp=self.cupos_disp1
                destino.cuposllenos=self.cuposllenos1
                destino.fechainicial=self.fechainicial1
                destino.fechafinal=self.fechafinal1
                //destino.IdCategoriaSelected = self.SeletedItem;
                
            }
        }
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //aqui configuramos el alto de la celda
        return 220
    }

    // Dentro de PrincipalViewController
    /*
    @IBAction func volverAViewController() {
        dismiss(animated: true, completion: nil)
    }*/

    
    //acciones de botones
    @IBAction func btn_cerrarsession(_ sender: UIBarButtonItem) {
        do{
            let alertController = self.alerta.ShowAlert(ptitle: "Cerrar sesion", pmessage: "Quiere cerrar la sesion actual?");
            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                // Manejar el botón OK presionado aquí
                SharedPreferences.fn_SaveData(data: "", key: "mailUser");
                SharedPreferences.fn_SaveData(data: "", key: "tokenUser");
                SharedPreferences.fn_SaveData(data: "", key: "UserName");
                SharedPreferences.fn_SaveData(data: "", key: "RoleUser");
                SharedPreferences.fn_SaveData(data: "", key: "PkgSelected");
                
                //self.volverAViewController();
            }
            
            alertController.addAction(okAction);
            
            self.present(alertController, animated: true, completion:nil)
        }catch{
            print("fallo al tratar de salir de la sesion");
        }
    }
    
    
    

    
    
}//end class
