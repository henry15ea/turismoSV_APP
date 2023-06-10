//
//  CompraReservaViewController.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/8/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import UIKit

class CompraReservaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //variables usuario
     var StateEmitedFactura:Bool = false;
     var TitleTopNavbar:String = "Compra";
    var detallePaquete = infoPaqueteModel.detallePaquete.init(nom: nil, des: nil, direccion: nil, imgurl: nil, precio: 0.00, cupos_disp: nil, cuposllenos: nil, fechainicial: nil, fechafinal: nil);
    var invitadoInfo = [invitadosModel.invitadoDetalle]();
    var SelectedCell:Int32 = 0;
    let alerta = Alert();
    
    
    //binding a la vista
    @IBOutlet weak var sw_invitadoState: UISwitch!
    
    @IBOutlet weak var tbl_listInvitados: UITableView!
    @IBOutlet weak var topNavbar: UINavigationBar!
    //elementos binding de invitados
    @IBOutlet weak var txt_nombreinv: UITextField!
    @IBOutlet weak var txt_apellidoInv: UITextField!
    @IBOutlet weak var txt_edadInv: UITextField!
    @IBOutlet weak var txt_ndocInv: UITextField!
    
    @IBOutlet weak var btn_addInvitado: UIButton!
    
    @IBOutlet weak var btn_nextStep: UIButton!
    @IBOutlet weak var btn_removeInvitado: UIButton!
    
    //funciones de clase
    private func fn_swElementsDissabled(){
        self.txt_nombreinv.isEnabled = false;
        self.txt_apellidoInv.isEnabled = false;
        self.txt_edadInv.isEnabled = false;
        self.txt_ndocInv.isEnabled = false;
        self.tbl_listInvitados.isHidden = true;
        self.btn_addInvitado.isEnabled = false;
        self.btn_removeInvitado.isEnabled = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // incializar elementos
        self.fn_swElementsDissabled();
        
        self.topNavbar.topItem?.title = self.TitleTopNavbar+" Paquete";
        
        //incializando tabla
        self.tbl_listInvitados.dataSource = self;
        self.tbl_listInvitados.delegate = self;
    
        //este txt solo permite 3 caracteres
        self.txt_ndocInv.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    //limitar los caracteres del documento
    // Controlar el número máximo de caracteres a 3
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    // Actualizar la limitación del número de caracteres
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        textField.text = String(text.prefix(10))
    }
    //boton para retornar a la pantalla anterior
    
    
    @IBAction func btn_return(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    //funciones para la tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.invitadoInfo.count ;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaInvitados", for: indexPath)
        let selectRow = indexPath.row;
        /*
        cell.textLabel?.text = data[indexPath.row];
        cell.detailTextLabel?.text = "dem";
        */
        let dataPerson = "Edad : \(self.invitadoInfo[selectRow].edad) / Documento : \(self.invitadoInfo[selectRow].n_doc)";
        
        cell.textLabel?.text = self.invitadoInfo[selectRow].nombre+" "+self.invitadoInfo[selectRow].apellido;
        
        cell.detailTextLabel?.text = dataPerson;
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectRow = indexPath.row;
        let data = self.invitadoInfo[selectRow];
        
        self.btn_removeInvitado.isEnabled = true;
        self.SelectedCell = Int32(selectRow);
        
        self.txt_nombreinv.text = data.nombre;
        self.txt_apellidoInv.text = data.apellido;
        self.txt_edadInv.text = String(data.edad);
        self.txt_ndocInv.text = data.n_doc;
        
        
    }

    //fin funciones para la tableview

    
    
    @IBAction func sw_activarInvitados(_ sender: Any) {
        if sw_invitadoState.isOn {
            //print("Switch is on")
            self.txt_nombreinv.isEnabled = true;
            self.txt_apellidoInv.isEnabled = true;
            self.txt_edadInv.isEnabled = true;
            self.txt_ndocInv.isEnabled = true;
            self.tbl_listInvitados.isHidden = false;
            self.btn_addInvitado.isEnabled = true;
            self.btn_removeInvitado.isEnabled = true;
        } else {

            //print("Switch is off")
            self.invitadoInfo.removeAll();
            self.txt_nombreinv.isEnabled = false;
            self.txt_apellidoInv.isEnabled = false;
            self.txt_edadInv.isEnabled = false;
            self.txt_ndocInv.isEnabled = false;
            self.tbl_listInvitados.isHidden = true;
            self.btn_addInvitado.isEnabled = false;
            self.btn_removeInvitado.isEnabled = false;
        }
    }
    //obtener datos de los txt
    private func fn_getDataText(){
        //obteniendo datos
        let id_pkg = SharedPreferences.fn_GetData(key: "PkgSelected");
        let uname = SharedPreferences.fn_GetData(key: "UserName");
        let nmb = txt_nombreinv.text?.trimmingCharacters(in: .whitespacesAndNewlines);
        let apel = txt_apellidoInv.text?.trimmingCharacters(in: .whitespacesAndNewlines);
        let edy = txt_edadInv.text?.trimmingCharacters(in: .whitespacesAndNewlines);
        let ndoc = txt_ndocInv.text?.trimmingCharacters(in: .whitespacesAndNewlines);
        
        
        self.invitadoInfo.append(invitadosModel.invitadoDetalle(
            nombre: (nmb?.uppercased())!,
            apellido: (apel?.uppercased())!,
            n_doc: ndoc!,
            edad: Int(edy!)!,
            iddetalle: "simple",
            username: uname,
            id_paquete: id_pkg
            )
        );
        
    }
    
    private func fn_CleanDataText(){
        self.txt_nombreinv.text = "";
        self.txt_apellidoInv.text = "";
        self.txt_edadInv.text = "";
        self.txt_ndocInv.text = "";
        
    }
    
    
    //acciones de botones para agregar invitados
    
    @IBAction func btn_RetirarInvitado(_ sender: Any) {
        //boton para remover al usuario de la lista
        self.invitadoInfo.remove(at: Int(self.SelectedCell));
        self.tbl_listInvitados.reloadData();
        self.fn_CleanDataText();
    }
    
    @IBAction func btn_AgregarInvitado(_ sender: Any) {
        //PkgSelected
        self.fn_getDataText();
        self.fn_CleanDataText();
        self.tbl_listInvitados.reloadData();
       
    }
    
    //acciones de botones para registrar compra o reserva
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sg_compraTarget" {
            if let PagoViewController = segue.destination as? PagoViewController {
                PagoViewController.invitadoInfo = self.invitadoInfo;
                PagoViewController.StateEmited = self.StateEmitedFactura;
                PagoViewController.detallePaquete = self.detallePaquete;
                
            }
        }
    }

    
    @IBAction func btn_sigPag(_ sender: Any) {
        //ir a la pantalla de pago
        performSegue(withIdentifier: "sg_compraTarget", sender: self)

    }
    
    
}//end class
