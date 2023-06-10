//
//  PkgByCategoriaViewController.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/5/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import UIKit

class PkgByCategoriaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //variables usuario
    var titleBar: String? = "demo Titulo";
    var IdCategoriaSelected: String? = "";

    var modeloApi = PkgByCategoriaModel.Model(IdCategoria: "");
    let dataController = PkgByCategoriaController();
    var PkgByCategoriaList = [PkgByCategoriaResponseModel.dataResponseModel]();
    //variables instancia
    var nombre1:String="null";
    var des1:String="null";
    var direccion1:String="null";
    var imgurl1:String="null";
    var precio1:Double=0
    var cupos_disp1:String="null";
    var cuposllenos1:String="null";
    var fechainicial1:String="null";
    var fechafinal1:String="null";
    
    
    
    
    
    //enlaces o bridge de vista
    @IBOutlet weak var TopBar: UINavigationBar!
    @IBOutlet weak var tbl_pkgByCategoria: UITableView!
    
    func fn_registerTableViewCells(){
        //esta funcion sirve para hacer el registro de la custom celda llamada CategoriasTableViewCell al table view que tenemos en la pantalla principal
        
        let textFlied = UINib(nibName: "CategoriasTableViewCell", bundle: nil);
        self.tbl_pkgByCategoria.register(textFlied, forCellReuseIdentifier: "CategoriasTableViewCell");
    }
    
    private func fn_load(){
        //funcion que se encarga de obtener los datos del controlador api para luego asignarlo a la tabla
        
        self.modeloApi = PkgByCategoriaModel.Model(
            IdCategoria: self.IdCategoriaSelected?.trimmingCharacters(in: .whitespacesAndNewlines)
        );
        
        dataController.fn_GetPkgByCategoria(pmodel: self.modeloApi){ success in
            DispatchQueue.main.async {
                if success {
                    let dataModels = self.dataController.getData()
                    
                    self.PkgByCategoriaList = dataModels!;
                    
                    self.tbl_pkgByCategoria.reloadData();
                    
                }
            }
        }
        
    }//end func

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //incializamos datos
        
        self.TopBar.topItem?.title = self.titleBar;
        print("categoria obtenida \(self.IdCategoriaSelected!)");
        
        //inicializando tabla
        self.tbl_pkgByCategoria.dataSource = self;
        self.tbl_pkgByCategoria.delegate = self;
        self.fn_registerTableViewCells();
        
        //llamamos a la Api
        self.fn_load();
        self.tbl_pkgByCategoria.reloadData();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_return(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    //funciones de tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.PkgByCategoriaList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //acciones de tabla
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriasTableViewCell") as? CategoriasTableViewCell {
            // Asigna los datos de la categoría a la celda correspondiente
            let datosApi = self.PkgByCategoriaList[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //aqui configuramos el alto de la celda
        return 220
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
            
            self.nombre1=PkgByCategoriaList[indexPath.row].Nombre!
            self.des1=PkgByCategoriaList[indexPath.row].Descripcion!
            self.direccion1=PkgByCategoriaList[indexPath.row].Direccion!
            self.imgurl1=PkgByCategoriaList[indexPath.row].Img!
            self.precio1=PkgByCategoriaList[indexPath.row].Precio!
            self.cupos_disp1=PkgByCategoriaList[indexPath.row].Cupos_disp!
            self.cuposllenos1=PkgByCategoriaList[indexPath.row].Cuposllenos!
            self.fechainicial1=PkgByCategoriaList[indexPath.row].Fechainicial!
            self.fechafinal1=PkgByCategoriaList[indexPath.row].Fechafinal!
            self.performSegue(withIdentifier: "Detalle2", sender: self);
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detalle2" {
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
    
}//end class
