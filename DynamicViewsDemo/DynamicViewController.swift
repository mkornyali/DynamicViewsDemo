//
//  DynamicViewController.swift
//  DynamicViewsDemo
//
//  Created by Mohamed Korany on 7/22/20.
//  Copyright © 2020 Mohamed Korany. All rights reserved.
//

import UIKit

class DynamicViewController: UIViewController {
    
    let datePickerViewController = UIViewController()
    var textLabel:UILabel?
    let chooseDateViewAlertController = UIAlertController(title: "update birth date", message: "", preferredStyle: UIAlertController.Style.alert)
    var dynamicViews:[UIView]?
    var viewsAsStrings : [(key:ViewsEnum, value:String)]?
    var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createStackView()
        setupDatePickerView()
        
        if let views = viewsAsStrings {
            print("count of dynamic views is \(views.count)")
            
            for item in views {
                switch item.key {
                
                case .label:
                    textLabel = createLabel(text: item.value)
                    stackView.addArrangedSubview(textLabel!)
                case .textField:
                    stackView.addArrangedSubview(createTextField(placeHolder: item.value))
                case .Button:
                    let button = createButton(title: item.value)
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tap))  //Tap function will call when user tap on button
                       tapGesture.numberOfTapsRequired = 1
                       button.addGestureRecognizer(tapGesture)
                    stackView.addArrangedSubview(button)
                case .Switch:
                    stackView.addArrangedSubview(creatSwitch())
                case .datePicker:
                    stackView.addArrangedSubview(createDatePicker())
                case .checkBox:
                    print("checkBox")
                }
            }
            
        }
    }
    
    func setupDatePickerView() {
        datePickerViewController.preferredContentSize = CGSize(width: 250,height: 300)
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        datePickerViewController.view.addSubview(datePicker)
        datePicker.datePickerMode = .date
        chooseDateViewAlertController.setValue(datePickerViewController, forKey: "contentViewController")
        chooseDateViewAlertController.addAction(UIAlertAction(title: "done", style: .default, handler: { [unowned self] value in
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy/MM/dd"
            let date = dateformatter.string(from: datePicker.date)
            print(date)
            self.textLabel?.text = date
            
        }))
        chooseDateViewAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    }
    
    
    @objc func tap() {

        print("Tap happend")
        self.present(chooseDateViewAlertController, animated: true)
    }
    
    func createStackView() {
        stackView = UIStackView()
        stackView.frame = view.frame
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
      //  stackView.alignment = .center
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 12
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
}

extension DynamicViewController {
    func createLabel(text:String) -> UILabel {
        var myLabel:UILabel {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.center = CGPoint(x: 160, y: 285)
            label.textAlignment = .center
            label.text = text
            return label
        }
        return myLabel
    }
    
    func createTextField(placeHolder:String) -> UITextField {
        var myTextField:UITextField {
            let _textField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200.00, height: 40.00))
            _textField.backgroundColor = .clear
            _textField.placeholder = placeHolder
            _textField.borderStyle = .line
            return _textField
        }
        return myTextField
    }
    
    func createButton(title:String) -> UIButton {
        var myBtn :UIButton {
            let button = UIButton(type: .system) // let preferred over var here
            button.tag = 15
            button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
            button.backgroundColor = .blue
            button.setTitle(title, for: .normal)
            return button
        }
        return myBtn
    }
    func creatSwitch() -> UISwitch {
        var mySwitch:UISwitch {
            let switchOnOff = UISwitch(frame:CGRect(x: 150, y: 150, width: 0, height: 0))
            //                switchOnOff.addTarget(self, action: #selector(ViewController.switchStateDidChange(_:)), for: .valueChanged)
            switchOnOff.setOn(true, animated: false)
            return switchOnOff
        }
        return mySwitch
    }
    
    func createDatePicker()->UIDatePicker{
        var myDatePicker :UIDatePicker {
            let datePicker: UIDatePicker = UIDatePicker()
            // Posiiton date picket within a view
            datePicker.frame = CGRect(x: 10, y: 50, width: 200, height: 500)
            // Set some of UIDatePicker properties
            datePicker.timeZone = NSTimeZone.local
            datePicker.backgroundColor = UIColor.white
            return datePicker
        }
        return myDatePicker
    }
    
    
    
    
    func createCheckBox(){
        
    }
}


