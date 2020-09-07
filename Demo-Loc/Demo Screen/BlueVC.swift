//
//  BlueVC.swift
//  Demo-Loc
//
//  Created by Emil Safier on 9/4/20.
//  Copyright © 2020 Emil Safier. All rights reserved.
//

import UIKit

class BlueVC: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
      var currencyOnlyText:String = ""
      var numberOnlyText:String = ""
      let currencyFormatter = NumberFormatter()
      let populationNumberFormatter = NumberFormatter()
      
      // MARK: - Outlets
      
      @IBOutlet weak var salaryText: UITextField!
      @IBOutlet weak var populationText: UITextField!
      @IBOutlet weak var dateOfBirth: UITextField!
      @IBOutlet weak var dataLabel: UILabel!
      @IBOutlet weak var timeLabel: UILabel!
      @IBOutlet weak var imageStop: UIImageView!
      
      let birthdayDatePicker = UIDatePicker()
      
      
      override func viewDidLoad() {
          super.viewDidLoad()
          self.salaryText.delegate = self
          self.populationText.delegate = self
          self.dateOfBirth.delegate = self
          
          let dateCurrent = Date()
          birthdayDatePicker.date = dateCurrent
          
          // set picker to current date
          birthdayDatePicker.datePickerMode = UIDatePicker.Mode.date  //  display date (only)
          
          currencyFormatter.locale = .current
          populationNumberFormatter.locale = .current
          
          /*   Programmatically force locale
          currencyFormatter.locale = .current   //  .current
          currencyFormatter.locale = Locale(identifier: "en_UK")
          currencyFormatter.locale = Locale(identifier: "en_US")
          currencyFormatter.locale = Locale(identifier: "fr_FR")
          */

          currencyFormatter.usesGroupingSeparator = true
          populationNumberFormatter.usesGroupingSeparator = true
          
          
          //  set current date
          let formatter = DateFormatter()
          formatter.dateStyle = .long
          formatter.timeStyle = .none
          dataLabel.text = formatter.string(from: dateCurrent)
          //  set current time
          formatter.dateStyle = .none
          formatter.timeStyle = .short
          timeLabel.text = formatter.string(from: dateCurrent)
      }
      
      
      //  MARK:  -  Text Field
      //  user pressed Return/Done- resigh first responder
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
      }
      
      /*
       Replaces comma with period as decimal delimeter;  handles case when using keypad which uses commas instead of periods.
       */
      func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool {
          if string == "," {
              textField.text! += "."
              return false  // replaces , with .
          }
          return true
      }
      
      //  Editing initiated, replace existing text with numbers only version, and add changes
      func textFieldDidBeginEditing(_ textField: UITextField) {
          textField.textColor = UIColor.red       //   active field
          switch textField {
          case salaryText:
              textField.text = currencyOnlyText
              textField.returnKeyType = UIReturnKeyType.done
              textField.keyboardType = UIKeyboardType.decimalPad    //.numberPad
              currencyOnlyText = textField.text!
          case populationText:
              textField.text = numberOnlyText
              textField.returnKeyType = UIReturnKeyType.done
              textField.keyboardType = UIKeyboardType.decimalPad
              numberOnlyText = textField.text!
          case dateOfBirth:
              birthdayDatePicker.addTarget(self,
                                           action: #selector(BlueVC.joinDateChanged(_:)),
                                           for: .valueChanged)
              textField.inputView = birthdayDatePicker  //  set Date Picker as input Keyboard
          default:
              textField.textColor = .green
          }
      }
      
      //  validate data and indicate editing is done
      func textFieldDidEndEditing(_ textField: UITextField) {
          
          switch textField {
          case salaryText:
              currencyOnlyText = textField.text!
              countPeriods(string: currencyOnlyText)
              currencyFormatter.numberStyle = .currency       // type of format
             
              let salary =  Double(currencyOnlyText)
              if salary != nil  {
                  textField.text = currencyFormatter.string(from:NSNumber(value: salary!))
                  textField.textColor = .black
              }
          case populationText:
              numberOnlyText = textField.text!
              countPeriods(string: numberOnlyText)
              populationNumberFormatter.numberStyle = .decimal      // type of format
              populationNumberFormatter.maximumFractionDigits = 4
              let population =  Double(numberOnlyText)
              if population != nil  {
                  textField.text = populationNumberFormatter.string(from:NSNumber(value: population!))
                  textField.textColor = .black
              }
          case dateOfBirth:
              textField.textColor = .black
          default:
              textField.textColor = .green
          }
      }
      
      // MARK:  Date Picker
      
      @objc func joinDateChanged (_ sender: UIDatePicker){
          let formatter = DateFormatter()
          formatter.dateStyle = .medium
          dateOfBirth?.text! = formatter.string(from: sender.date)
      }
      
      //  MARK: - Support
      
      func isValidName(testStr:String) -> Bool {
          let nameRegEx = "[0-9.]"
          let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
          return nameTest.evaluate(with: testStr)
      }
      
      func countPeriods(string: String)  {
          let withPeriods = Array(string).filter { $0 == "."}
          if withPeriods.count > 1 {
              //  string == ""
              let title = NSLocalizedString("alert.title.count",
                                            value: "Invalid Entry",
                                            comment: "Title in Alert Message")
              let message = NSLocalizedString("alert.message.count",
                                              value: "Only a single decimal marker can be used!",
                                              comment: "Alert message")
              showAlertOK(title: title, message: message)
          }
      }
      
      func showAlertOK(title: String, message: String){
          let okText = NSLocalizedString("OK", comment: "OK button text")
          let alertController = UIAlertController(title: title,message: message, preferredStyle: .alert)
          let OKAction = UIAlertAction(title: okText, style: .default, handler: nil)
          alertController.addAction(OKAction)
          OperationQueue.main.addOperation {self.present(alertController, animated: true, completion:nil)}
      }
      

      /*
          let currencyFormatter = NumberFormatter()
          currencyFormatter.numberStyle = .currency
          currencyFormatter.string(from: 99.95)     // $99.95
          
          //  NUMBERS
          let numberFormatter = NumberFormatter()
          numberFormatter.numberStyle = .currency
          numberFormatter.numberStyle = .decimal
          numberFormatter.numberStyle = .none
          numberFormatter.numberStyle = .ordinal
          numberFormatter.numberStyle = .percent
          numberFormatter.numberStyle = .scientific
          numberFormatter.numberStyle = .spellOut
          numberFormatter.numberStyle = .currencyPlural
          */}
