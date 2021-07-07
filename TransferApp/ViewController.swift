//
//  ViewController.swift
//  TransferApp
//
//  Created by Андрей Бородкин on 07.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var dataLabel: UILabel!
    
    var updatedData: String = "Test data"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }


        //MARK: - Data with property
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        // we get a VC to push
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
        
        //transfer data
        editScreen.updatingData = dataLabel.text ?? ""
        
        // we push to next VC
        self.navigationController?.pushViewController(editScreen, animated: true)
        
    }
    
    //MARK: - Data with segue
    // data transfer with segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // specify segue identificator
        switch segue.identifier {
        case "toEditScreen":
            // handle the segue
            prepareEditingScreen(segue)
        default:
            break
        }
    }
    
    // we update data in the label
    private func updateLabel(withText text: String) {
        dataLabel.text = updatedData
    }
    
    // preparation for the segue to editing scene
    private func prepareEditingScreen(_ segue: UIStoryboardSegue) {
        guard let destinationController = segue.destination as? SecondViewController else {return}
        
        destinationController.updatingData = dataLabel.text ?? ""
    }
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {
        
    }
    
    //MARK: - Data with delegate
    //transition from A to M
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScene = storyboard.instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
        
        // transfer data
        editScene.updatingData = dataLabel.text ?? ""
        
        // set current class as a delegate
        editScene.handleUpdatedDataDelegate = self
        
        // open next screen
        self.navigationController?.pushViewController(editScene, animated: true)
    }
    
    //MARK: - Data with closure
    // transition from A to B and data transfer with closure
    @IBAction func editDataWithClosure(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editingScene = storyboard.instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
        
        // data transfer
        editingScene.updatingData = dataLabel.text ?? ""
        
        // we are passing required closure
        editingScene.completionHandler = { [unowned self] updatedValue in
            updatedData = updatedValue
            updateLabel(withText: updatedValue)
        }
        
        // show next scene
        self.navigationController?.pushViewController(editingScene, animated: true)
    }
    
  
}


extension ViewController: DataUpdateProtocol {
    
    func onDataUpdate(data: String) {
        updatedData = data
        updateLabel(withText: data)
    }
}
