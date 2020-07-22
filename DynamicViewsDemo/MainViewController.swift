//
//  ViewController.swift
//  DynamicViewsDemo
//
//  Created by Mohamed Korany on 7/22/20.
//  Copyright © 2020 Mohamed Korany. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var viewsTableView: UITableView!
    
    var dynamicViewsArray = [UIView]()
    var viewsAsStrings = [(key:ViewsEnum, value:String)]()
    var returnMessage:String?
//    var ButtonTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func creatButtonDidPressed(_ sender: Any) {
        print("test")
        showDynamicViewController(views: viewsAsStrings)
    }
    
    func showDynamicViewController(views:[(key:ViewsEnum, value:String)]) {
        let dynamicVC = (storyboard?.instantiateViewController(identifier: "\(DynamicViewController.self)"))! as DynamicViewController
        dynamicVC.viewsAsStrings = views
        
        
        navigationController?.pushViewController(dynamicVC, animated: true)
    }
    
}
extension MainViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewsEnum.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = ViewsEnum.allCases[indexPath.row]
        cell.textLabel?.text = model.dislayLabel
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let model = ViewsEnum.allCases[indexPath.row]
        cell?.selectionStyle = .none
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
            dynamicViewsArray.remove(at: indexPath.row)
        }
        else {
            cell?.accessoryType = .checkmark
            
            switch model {
                
            case .label:
                alertWithTextField(title: "UILabel", message: "This Label Will Reflect On Next Views", placeholder: "enter your label name") {[unowned self] result in
                    self.viewsAsStrings.append((key: .label , value: result))
                }
                
                
            case .textField:
                alertWithTextField(title: "TextField", message: "TextField", placeholder: "TextField") {[unowned self] result in
//                    self.dynamicViewsArray.append(self.createTextField(placeHolder:result))
                    self.viewsAsStrings.append((key: .textField   , value: result))
                }
                
            case .Button:
                alertWithTextField(title: "Button", message: "Button", placeholder: "Button") {[unowned self] (buttonTitle) in
//                    self.dynamicViewsArray.append(self.createButton(title:buttonTitle))
                    self.viewsAsStrings.append((key: .Button  , value: buttonTitle))
                }
                
            case .Switch:
//                dynamicViewsArray.append(creatSwitch())
                viewsAsStrings.append((key: .Switch, value: ""))
            case .datePicker:
//                dynamicViewsArray.append(createDatePicker())
                self.viewsAsStrings.append((key: .datePicker, value: ""))
            case .checkBox:
               // createCheckBox()
                viewsAsStrings.append((key: .checkBox, value: ""))
            }
            //            dynamicViewsArray.append(model.selectedView)
        }
    }
    
    
    public func alertWithTextField(title: String? = nil, message: String? = nil, placeholder: String? = nil, completion: @escaping ((String) -> Void) = { _ in }) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.placeholder = placeholder
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in completion("") })
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            if
                let textFields = alert.textFields,
                let tf = textFields.first,
                let result = tf.text
            { completion(result) }
            else
            { completion("") }
        })
        navigationController?.present(alert, animated: true)
    }
    
}


