//
//  RedVC.swift
//  Demo-Loc
//
//  Created by Emil Safier on 9/4/20.
//  Copyright © 2020 Emil Safier. All rights reserved.
//

import UIKit
import Contacts

class RedVC: UIViewController, UITextFieldDelegate {

      
       // MARK: - Outlets
       @IBOutlet weak var firstNameText: UITextField!
       @IBOutlet weak var lastNameText: UITextField!
       @IBOutlet weak var addressLine1Text: UITextField!
       @IBOutlet weak var addressLine2Text: UITextField!
       @IBOutlet weak var cityText: UITextField!
       @IBOutlet weak var stateText: UITextField!
       @IBOutlet weak var postalText: UITextField!
       @IBOutlet weak var countryTextField: UITextField!
       @IBOutlet weak var addressLabel: UILabel!
       
       
       override func viewDidLoad() {
           super.viewDidLoad()
           self.firstNameText.delegate = self
           self.lastNameText.delegate = self
           self.addressLine1Text.delegate = self
           self.addressLine2Text.delegate = self
           self.cityText.delegate = self
           self.stateText.delegate = self
           self.countryTextField.delegate = self
       }
       
       //  MARK:  -  Text Field
       //  user pressed Return/Done- resigh first responder
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
       
       func textFieldDidBeginEditing(_ textField: UITextField) {
           textField.textColor = UIColor.red       //   active field is red
           textField.returnKeyType = UIReturnKeyType.done
           textField.keyboardType = UIKeyboardType.default
       }
       
       //  validate data and indicate editing is done
       func textFieldDidEndEditing(_ textField: UITextField) {
           switch textField {
           case firstNameText:
               textField.textColor = .black
           case lastNameText:
               textField.textColor = .black
           case addressLine1Text:
               textField.textColor = .black
           case addressLine2Text:
               textField.textColor = .black
           case cityText:
               textField.textColor = .black
           case stateText:
               textField.textColor = .black
           case textField:
               textField.textColor = .black
           case countryTextField:
               textField.textColor = .black
           default:
               textField.textColor = .green
           }
       }
       
       //  MARK: - Action
       /**
        This Action verifies that all of the required fields have been entered and displays an alert which tells the user if there are any missing fields and lists those fields by displaying the placeholder text for each field.
        
        Purpose here is to show how translations can incorporate formatted text
        */
       @IBAction func doneBarButton(_ sender: UIBarButtonItem) {

           var missingItems = ""
           
           //  put all text into array
           var allText = [UITextField]()
           
           allText.append(firstNameText!)
           allText.append(lastNameText!)
           allText.append(addressLine1Text!)
           allText.append(addressLine2Text!)
           allText.append(cityText!)
           allText.append(stateText!)
           allText.append(postalText!)
           allText.append(countryTextField!)
           addressLabel.text = ""
           
           for item in allText {
               if item.text == "" {
                   missingItems += (item.placeholder! + ", ")
               }
               print(missingItems)
           }
           
           if missingItems != "" {
               let title = NSLocalizedString("alert.title.missingInfo",
                   value: "Missing Info",
                   comment: "Title in Alert Message")
               let format = NSLocalizedString("alert.message.format",
                                              value: "One or more of the following required fields is missing:  %@ ",
                                              comment: "Alert Message")
               let msgAlert = String.localizedStringWithFormat(format, missingItems)
                   //"One or more of the following required fields is missing:  \n" + missingItems
               
               print("format:  \(format)")
               print("msgAlert:  \(msgAlert)")
               showAlertOK(title: title, message: msgAlert)
              
           }
           
           
           //  --- NAME ---
           var nameComponents = PersonNameComponents()
           //   assign components
           nameComponents.givenName = firstNameText.text
           nameComponents.familyName = lastNameText.text
           nameComponents.middleName = "X"     //  additional name components
           nameComponents.nickname = "Buddy"
           nameComponents.namePrefix = "Dr."
           nameComponents.nameSuffix = "III"
           //  format the name using components
           let formatter = PersonNameComponentsFormatter()
           formatter.style = .default
           let nameString = formatter.string(from: nameComponents)
           
           //  --- ADDRESS --
           let address = CNMutablePostalAddress()
               // assign address components
           address.street = addressLine2Text.text!
           address.city = cityText.text!
           address.state = stateText.text!
           address.postalCode = postalText.text!
           address.country = countryTextField.text!
           //  format the address
           let addressFormatter = CNPostalAddressFormatter()
           let nameAddress = addressFormatter.string(from: address)
           //  assemble both name and address into mailing label
           addressLabel.text = nameString + "\n" + addressLine1Text.text! + "\n" + nameAddress
           
       }
       
       func showAlertOK(title: String, message: String){
              let okText = NSLocalizedString("OK", comment: "OK button text")
              let alertController = UIAlertController(title: title,message: message, preferredStyle: .alert)
              let OKAction = UIAlertAction(title: okText, style: .default, handler: nil)
              alertController.addAction(OKAction)
              OperationQueue.main.addOperation {self.present(alertController, animated: true, completion:nil)}
          }
       
      
    

}
