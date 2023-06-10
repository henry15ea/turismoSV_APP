//
//  historialController.swift
//  TurismoSV_app
//
//  Created by ronald on 7/6/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation
import UIKit

class historialController
{
    private let url = cls_routesApi();
    private var urlname:String="";
    private var messageApi="";
    private var modelData: histoiralResponseModel.DataloginResponse;
    var dataModels = [histoiralResponseModel.dataResponseModel]();
    //temporal
    private var imputModel: PkgByCategoriaModel.Model ;
    
    //estructura del json
    struct Response: Codable {
        let data: String
    }
    
    func getData() -> [histoiralResponseModel.dataResponseModel]? {
        return self.dataModels;
    }
    
    public func fn_GetApiStatus()->String{
        return messageApi.trimmingCharacters(in: .whitespacesAndNewlines);
        
    }
    
    public init(){
        //iniciando elementos
        urlname = url.fn_GetUrl(nmb: "historial");
        
        modelData  = histoiralResponseModel.DataloginResponse(
            Id_factura:"null",
            Paquete:"null",
            Pasarela:"null",
            Descuento:"null",
            Monto:"null",
            Total:"null",
            Cupos:"null",
            Usuario:"null",
            Estado:"null"
        );
        
        
        
        imputModel = PkgByCategoriaModel.Model(IdCategoria: "null");
    }
    
    public func fn_SetModelData(pmodel: PkgByCategoriaModel.Model){
        imputModel = pmodel;
    }
    
    public func fn_GetHistorial(pmodel: String,completion: @escaping (Bool) -> Void){
        //capturamos los datos del modelo
        
        
        //convertimos los datos en json
        let jsonObject:[String:Any] =
            [
                "item": pmodel
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
                    let models = try decoder.decode([histoiralResponseModel.dataResponseModel].self, from: data!)
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
