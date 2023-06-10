//
//  PagoViewController.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/9/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import UIKit

class PagoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
    
    //variables usuario
    let idPacketeSelected = SharedPreferences.fn_GetData(key: "PkgSelected");
    var SelectedDateVenc:String = "";
    var invitadoInfo = [invitadosModel.invitadoDetalle]();//esta variable recive la lista de invitados
    var idFpagoSelected:String = "null";
    var StateEmited:Bool = false;
    var PrecioPaquete:Double = 0.00;
    
    //variables para mantener el token de los datos
    var tokenFacturaHeader:String = "";
    var tokenFacturaDetalle:String = "";
    
    //variables api
    let dataController = FpagoController();
    var fpagoList = [fpagoResponseModel.dataResponseModel]();
    
    var detallePaquete = infoPaqueteModel.detallePaquete.init(nom: nil, des: nil, direccion: nil, imgurl: nil, precio: 0.00, cupos_disp: nil, cuposllenos: nil, fechainicial: nil, fechafinal: nil);

    
    let facturaHController = FacturaHeaderController();
    let facturaDController = FacturaDetalleController();
    var dataFacturaH = facturaHeaderResponseMondel.DataloginResponse.init(token_paquete: nil, infoMsg: nil, serverApiStatus: nil);
    
    //variables componentes
    let dateFormatter = DateFormatter();
    
    //binging a la vista
    
    @IBOutlet weak var cmbx_listaFpago: UIPickerView!
    @IBOutlet weak var txt_numTargeta: UITextField!
    @IBOutlet weak var txt_secureCodeTargeta: UITextField!
    @IBOutlet weak var dtpk_fechaVencTargeta: UIDatePicker!
    @IBOutlet weak var btn_realizaCompra: UIButton!
    
    
    //funciones de extraccion de datos api
    
    private func fn_load(){
       // var resp:Bool = false;
        
        dataController.fn_GetFpago(){ success in
            DispatchQueue.main.async {
                if success {
                    let dataModels = self.dataController.getData();
                    self.fpagoList = dataModels!;
                    self.cmbx_listaFpago.reloadAllComponents();
                    
                }else{
                    
                    
                }
            }
        }
        
    }//end func

    override func viewDidLoad() {
        super.viewDidLoad()
        //inicializar elementos del cmbx
        self.cmbx_listaFpago.delegate = self;
        self.cmbx_listaFpago.dataSource = self;
        //configuramos el tipo de fecha
        self.dateFormatter.dateFormat = "dd/MM/yyyy";
        
        //llammamos a la api
        self.fn_load();
        self.cmbx_listaFpago.reloadAllComponents();
        
        //accion para el txt de targeta limitando su numero de caracteres a 19
        
        self.txt_numTargeta.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged);

        //este txt solo permite 3 caracteres
         self.txt_secureCodeTargeta.addTarget(self, action: #selector(textFieldDidChange2(_:)), for: .editingChanged)
        
        //accion para el datepicker
        self.dtpk_fechaVencTargeta.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //funciones para la topnavbar
    @IBAction func btn_return(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    // Controlar el número máximo de caracteres a 19
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 19
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    // Actualizar la limitación del número de caracteres
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        textField.text = String(text.prefix(19))
    }
    
    // Controlar el número máximo de caracteres a 3
    func textField2(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 3
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    // Actualizar la limitación del número de caracteres
    @objc func textFieldDidChange2(_ textField: UITextField) {
        guard let text = textField.text else { return }
        textField.text = String(text.prefix(3))
    }
    
    //funciones para el datepicker
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
       
        
        self.SelectedDateVenc = formattedDate.trimmingCharacters(in: .whitespacesAndNewlines);
        //print("Fecha seleccionada: \(self.SelectedDateVenc)")
    }
    
    //funciones para el pickerview o combobox
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Número de componentes/columnas a mostrar
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //return self.fpagoList.count // Número de filas a mostrar
        return self.fpagoList.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return self.fpagoList[row].metodopago // Texto a mostrar para cada fila
        
        return self.fpagoList[row].Metodopago;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let id_row = row;
        let dataSelect = self.fpagoList[row].Metodopago;
        
        if(dataSelect == "RESERVAR" || dataSelect == "reserva" || dataSelect == "RESERVA"){
            self.btn_realizaCompra.setTitle("Reservar", for: .normal);
            self.btn_realizaCompra.setTitleColor(UIColor.black, for: .normal);
            self.btn_realizaCompra.backgroundColor = UIColor.orange;
            
            self.StateEmited = false;
        }else{
            self.btn_realizaCompra.setTitle("Realizar Compra", for: .normal);
            self.btn_realizaCompra.setTitleColor(UIColor.black, for: .normal);
            self.btn_realizaCompra.backgroundColor = UIColor.green;
            self.StateEmited = true;
        }
        
        
        self.idFpagoSelected = self.fpagoList[id_row].Idformapago!;
    }
    
    //funcion que obtiene el elemento por defecto del pickerdata
    private func fn_GetCombxItemDefault(){
        let filaSeleccionada = self.cmbx_listaFpago.selectedRow(inComponent: 0)
        if filaSeleccionada >= 0 && filaSeleccionada < fpagoList.count {
            // Actualizar el texto del campo de texto con el nombre del elemento seleccionado
            self.idFpagoSelected = self.fpagoList[filaSeleccionada].Idformapago!;
            
            } else {
            // Si no se seleccionó ninguna fila, actualizar con valor predeterminado
            self.idFpagoSelected = self.fpagoList[filaSeleccionada].Idformapago!;
        }

        
    }
    
    private func fn_GetDatePickerDefault(){
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "dd/MM/yyyy";
        let defaultDate = dateFormatter.string(from: self.dtpk_fechaVencTargeta.date);
        
        self.SelectedDateVenc = defaultDate;

    }
    
    //funciones de registro de paquetes
    
    private func fn_CompletedShop(){
        //obteniendo datos de los controles
        self.fn_GetCombxItemDefault();
        self.fn_GetDatePickerDefault();
        
        //seteando el modelo
        let modelFacturaHeader = facturaEncabezadoModel.facturaHeader(
            idencabezado: "demo",
            idcuenta: "demo",
            idformapago: self.idFpagoSelected,
            descuento: 15.0,
            monto: self.detallePaquete.precio,
            state_emited: self.StateEmited,
            username: SharedPreferences.fn_GetData(key: "UserName")
        );
        
        self.facturaHController.fn_FacturaRegister(pmodel: modelFacturaHeader) { success in
            DispatchQueue.main.async {
                if success {
                    // se ha completado el registro de encabezado factura
                    print(self.dataController.fn_GetApiStatus());
                    let dataRs = self.facturaHController.fn_getDataResponse();
                    
                    let encabezadoId  = dataRs.token_paquete;
                    self.tokenFacturaHeader = encabezadoId!;
                    
                    
                    if (encabezadoId != "" || encabezadoId != nil){
                        print(dataRs.infoMsg!);
                        print(dataRs.serverApiStatus!);
                        print("token factura : \(dataRs.token_paquete!)");
                        
                        print("Registrando detalle");
                        self.fn_DetailRegister(ptokenHeader: dataRs.token_paquete!);
                        
                    }
                    
                    
                    
                } else {
                    // Code to execute if login fails
                    print("Fallo al enviar datos para crear factura");
                }
            }
        }
        
    }//end func
    
    private func fn_GetTotalMonto() -> Double{
        var resp:Double = 0.0;
        let numinv:Double = Double(self.invitadoInfo.count+1);
        
        if (numinv>0){
            resp = self.detallePaquete.precio!*numinv;
        }else{
            resp = self.detallePaquete.precio!;
        }
        
        return resp;
    }
    
    private func fn_DetailRegister(ptokenHeader:String){
        //obteniendo datos de los controles
        self.fn_GetCombxItemDefault();
        self.fn_GetDatePickerDefault();
        //llenando el modelo de datos para la factura
        let datosModel = detalleFacturaModel.detalleFacturaData.init(
            username: SharedPreferences.fn_GetData(key: "UserName"),
            iddetalle: "demo",
            idencabezado: ptokenHeader,
            idpaqueted: SharedPreferences.fn_GetData(key: "PkgSelected"),
            precio: self.detallePaquete.precio,
            descuento: 15.0,
            monto: self.fn_GetTotalMonto(),
            cupos: self.invitadoInfo.count+1
        );
        
        //print("modelo : \(datosModel)");
        
        self.facturaDController.fn_FacturaDetalleRegister(pmodel: datosModel) { success in
            DispatchQueue.main.async {
                if success {
                    // se ha completado el registro de encabezado factura
                    print(self.dataController.fn_GetApiStatus());
                    let dataRs = self.facturaHController.fn_getDataResponse();
                    
                    self.tokenFacturaDetalle = dataRs.token_paquete!;
                    
                    
                    if (self.tokenFacturaDetalle != "" || self.tokenFacturaDetalle != nil){
                        print(dataRs.infoMsg!);
                        print(dataRs.serverApiStatus!);
                        print("token Detallle : \(dataRs.token_paquete!)");
                    }
                    
                    
                    
                } else {
                    // Code to execute if login fails
                    print("Hubo un error al registrar el detalle de la compra")
                }
            }
        }
        
    }//end func
    
    private func fn_InvitadosRegister(){
        
    }
    
    //funcion de accion de boton compra

    @IBAction func btn_realizaCompra(_ sender: Any) {
        
        /*
        let targetNum = self.txt_numTargeta.text?.trimmingCharacters(in: .whitespacesAndNewlines);
        let codeSecTaget = self.txt_secureCodeTargeta.text?.trimmingCharacters(in: .whitespacesAndNewlines);
        
        print("Paquete selec \(self.idFpagoSelected)");
        print("invitados : \(self.invitadoInfo.count)")
        print("num targeta : \(txt_numTargeta.text)")
        print("Codigo Sec : \(txt_numTargeta.text)")
        print("Fecha Vencimiento : \(self.SelectedDateVenc)")
 
        */
        self.fn_CompletedShop();
        
    }
    
}
