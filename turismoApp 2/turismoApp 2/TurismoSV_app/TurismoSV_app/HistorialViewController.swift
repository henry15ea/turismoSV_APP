//
//  HistorialViewController.swift
//  TurismoSV_app
//
//  Created by ronald on 7/6/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import UIKit

class HistorialViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    
    

    
    let dataController = historialController();
    var historialList = [histoiralResponseModel.dataResponseModel]();

    
    @IBOutlet weak var tbl_historial: UITableView!
    
    
    
    func fn_registerTableViewCells(){
        //esta funcion sirve para hacer el registro de la custom celda llamada CategoriasTableViewCell al table view que tenemos en la pantalla principal
        
        let textFlied = UINib(nibName: "HistorialTableViewCell", bundle: nil);
        self.tbl_historial.register(textFlied, forCellReuseIdentifier: "HistorialTableViewCell");
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbl_historial.dataSource = self;
        self.tbl_historial.delegate = self;
        self.fn_registerTableViewCells();
        
        self.fn_load()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func fn_load(){
        //funcion que se encarga de obtener los datos del controlador api para luego asignarlo a la tabla
        
        let user=SharedPreferences.fn_GetData(key: "UserName");
        dataController.fn_GetHistorial(pmodel:user){ success in
            DispatchQueue.main.async {
                if success {
                    let dataModels = self.dataController.getData()
                    
                    self.historialList = dataModels!;
                    
                    //let datosApi=self.historialList[0];
                    
                //self.txtprueba.text=datosApi.Id_factura?.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    self.tbl_historial.reloadData();
                    
                }
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historialList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HistorialTableViewCell") as? HistorialTableViewCell {
            // Asigna los datos de la categoría a la celda correspondiente
            let datosApi = self.historialList[indexPath.row]
            //cell.txt_titulo.text = datosApi.Nombre?.trimmingCharacters(in: .whitespacesAndNewlines);
            
            let precioD = datosApi.Total!;
            let precioS = String(describing: precioD);
            
        
            cell.txt_factura.text = datosApi.Id_factura?.trimmingCharacters(in: .whitespacesAndNewlines);
            cell.txt_paquete.text = datosApi.Paquete?.trimmingCharacters(in: .whitespacesAndNewlines);
            cell.txt_total.text = datosApi.Total?.trimmingCharacters(in: .whitespacesAndNewlines);
            
            
            
            // Devuelve la celda configurada
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //aqui configuramos el alto de la celda
        return 150
    }

}
