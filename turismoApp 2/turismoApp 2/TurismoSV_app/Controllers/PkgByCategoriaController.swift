//
//  PkgByCategoriaController.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/5/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

//
//  LoginController.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 5/29/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation
import UIKit

class PkgByCategoriaController
{
    private let url = cls_routesApi();
    private var urlname:String="";
    private var messageApi="";
    private var modelData: PkgByCategoriaResponseModel.DataloginResponse;
    var dataModels = [PkgByCategoriaResponseModel.dataResponseModel]();
    //temporal
    private var imputModel: PkgByCategoriaModel.Model ;
    
    //estructura del json
    struct Response: Codable {
        let data: String
    }
    
    func getData() -> [PkgByCategoriaResponseModel.dataResponseModel]? {
        return self.dataModels;
    }
    
    public func fn_GetApiStatus()->String{
        return messageApi.trimmingCharacters(in: .whitespacesAndNewlines);
        
    }
    
    public init(){
        //iniciando elementos
        urlname = url.fn_GetUrl(nmb: "paquetesByCategoriaId");
        
        modelData  = PkgByCategoriaResponseModel.DataloginResponse(
            Idpaqueted: "null",
            Nombre: "null",
            Descripcion: "null",
            Direccion: "null",
            Img: "null",
            Precio: 0.0,
            Cupos_disp: "null",
            Cuposllenos: "null",
            Fechainicial: "null",
            Fechafinal: "null",
            Estado: false,
            Fechreg: "null"
        );
        
        
        
        imputModel = PkgByCategoriaModel.Model(IdCategoria: "null");
    }
    
    public func fn_SetModelData(pmodel: PkgByCategoriaModel.Model){
        imputModel = pmodel;
    }
    
    public func fn_GetPkgByCategoria(pmodel: PkgByCategoriaModel.Model,completion: @escaping (Bool) -> Void){
        //capturamos los datos del modelo
        let idCategoria = pmodel.IdCategoria;
        
        //convertimos los datos en json
        let jsonObject:[String:Any] =
            [
                "item": idCategoria!.trimmingCharacters(in: .whitespacesAndNewlines)
        ];
        //convertimos los datos en formato json
        let bodyData = try? JSONSerialization.data(
            withJSONObject: jsonObject,
            options: []
        )
        
        let url = URL(string: urlname)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            do {
                if let data = data {
                    
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Response.self, from: data)
                    let data = response.data.data(using: .utf8) // convert the response string to UTF-8 data
                    let models = try decoder.decode([PkgByCategoriaResponseModel.dataResponseModel].self, from: data!)
                    self.dataModels += models
                    
                    let demo = self.dataModels.count;
                    print("datos obtenidos \(demo)")
                    completion(true) // Call completion with false to indicate failure
                    return
                } else {
                    print("No se pudo obtener los datos")
                    completion(false) // Call completion with false to indicate failure
                    return
                }
            } catch let error {
                print("Error al analizar el archivo JSON: \(error.localizedDescription)")
                completion(false) // Call completion with false to indicate failure
                return
            }
        }
        task.resume()
    }
    
}//end class

