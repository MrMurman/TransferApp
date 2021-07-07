//
//  SecondViewController.swift
//  TransferApp
//
//  Created by Андрей Бородкин on 07.07.2021.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var dataTextField: UITextField!
    var handleUpdatedDataDelegate: DataUpdateProtocol?
    
    var updatingData: String = ""
    
    var completionHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }

    
    
    
    //MARK: - Data with property
    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach { viewController in
            (viewController as? ViewController)?.updatedData = dataTextField.text ?? ""
        }
    }
    
    //MARK: - Data with segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // specify segue identifier
        switch segue.identifier {
        case "toFirstScene":
            prepareFirstScreen(segue)
        default:
            break
        }
  
    }
    
    // preparations for the segue to the first scene
    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
        guard let destinationController = segue.destination as? ViewController else {return}
        destinationController.updatedData = dataTextField.text ?? ""
    }
    
    
    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }
    
    
    //MARK: - Data with delegate
    // transfer from B to A and data transfer
    @IBAction func saveDataWithDelegate(_ sender: UIButton) {
        // we get updated data
        let updatedData = dataTextField.text ?? ""
        // call upon delegation method
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
        // return to previous scene
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Data with closure
    // transfer from B to A
    @IBAction func saveDataWithClosure(_ sender: UIButton) {
        // we get updated data
        let updatedData = dataTextField.text ?? ""
        // call the closure
        completionHandler?(updatedData)
        //return to previous scene
        navigationController?.popViewController(animated: true)
    }
}
