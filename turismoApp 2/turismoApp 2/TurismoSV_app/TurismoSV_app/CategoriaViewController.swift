//
//  CategoriaViewController.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/2/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import UIKit

class CategoriaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    //variables de usuario
    let dataController = CategoriasController();
    var categorias = [categoriasResponseModel.dataResponseModel]();
    var selectedTitle:String="DefaultTitle";
    var SeletedItem:String = "null";
    
    //enlace a widgetsvar
    @IBOutlet weak var categoriasTabla: UITableView!
    
    private func fn_load(){
        var resp:Bool = false;
        
        dataController.fn_GetCategorias(){ success in
            DispatchQueue.main.async {
                if success {
                    let dataModels = self.dataController.getData()
                
                    self.categorias = dataModels!;
                    
                    self.categoriasTabla.reloadData();
                    
                }else{
                    
                    
                }
            }
        }
        
    }//end func
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
    
        //incializamos la tabla
       self.categoriasTabla.delegate = self
       self.categoriasTabla.dataSource = self
        
        //llamamos a la api
        self.fn_load();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //funciones propias de tableview
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return self.categorias.count;
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                // Obtén una instancia de la celda de la tabla desde el storyboard
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "celdaCategoria")
                    else {
                        return UITableViewCell();
                };
                
                
                // Asigna los datos de la categoría a la celda correspondiente
                let categoria = self.categorias[indexPath.row]
                cell.textLabel?.text = categoria.Nombre?.trimmingCharacters(in: .whitespacesAndNewlines);
                // Devuelve la celda configurada
                return cell
            }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //funcion para obtener el valor de la celda presionada
        //obtenemos la celda seleccionada
        let cell = tableView.cellForRow(at: indexPath)
        //obtenemos el valor de la celda seleccionada
        let selectedValue = cell?.textLabel?.text
        
        //buscamos el id de los datos segun la celda seleccionada
        
        let dataIndex = self.categorias.index(where: {$0.Nombre == selectedValue?.trimmingCharacters(in: .whitespacesAndNewlines)});
        
        let data = self.categorias[dataIndex!].Idcategoria;
        
        self.SeletedItem = data!;
        self.selectedTitle = selectedValue!;
        //llamamos a la ventana de listado de paquetes por categoria
        self.performSegue(withIdentifier: "PaquetesID", sender: self);
    }
    
    //preparamos la funcion para pasar datos entre las vistas
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PaquetesID" {
            if let destino = segue.destination as? PkgByCategoriaViewController {
                destino.titleBar = self.selectedTitle;
                destino.IdCategoriaSelected = self.SeletedItem;
                
            }
        }
    }

        
}//end class
