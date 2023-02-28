//
//  SetViewController.swift
//  ColorMixerApp
//
//  Created by Камаль Атавалиев on 27.02.2023.
//

import UIKit

// MARK: - SetViewController
class SetViewController: UIViewController {

    // MARK: - IB Outlet
    @IBOutlet var colorMixView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    @IBOutlet var redColorTF: UITextField!
    @IBOutlet var greenColorTF: UITextField!
    @IBOutlet var blueColorTF: UITextField!
    
    // MARK: - Public Properties
    unowned var delegate: SetViewControllerDelegate!
    var colorView: UIColor!
    
    // MARK: - View Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorMixView.layer.cornerRadius = 20
        
        colorMixView.backgroundColor = colorView
        
        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.minimumTrackTintColor = .green
        blueColorSlider.minimumTrackTintColor = .blue
        
        redColorTF.delegate = self
        greenColorTF.delegate = self
        blueColorTF.delegate = self
        
        setValuee(red: redColorSlider, green: greenColorSlider, blue: blueColorSlider)
        setValue(for: redColorLabel, greenColorLabel, blueColorLabel)
        setValue(for: redColorTF, greenColorTF, blueColorTF)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
   
    // MARK: - IB Actions
    @IBAction func rgbSliders(_ sender: UISlider) {
        switch sender {
        case redColorSlider:
            setValue(for: redColorLabel)
            setValue(for: redColorTF)
        case greenColorSlider:
            setValue(for: greenColorLabel)
            setValue(for: greenColorTF)
        default:
            setValue(for: blueColorLabel)
            setValue(for: blueColorTF)
        }
        
        setColor()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.getColor(colorMixView.backgroundColor ?? .yellow)
        dismiss(animated: true)
    }
    
}

// MARK: - Private Methods
extension SetViewController {
    private func setColor() {
        colorMixView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redColorLabel: label.text = string(for: redColorSlider)
            case greenColorLabel: label.text = string(for: greenColorSlider)
            default: label.text = string(for: blueColorSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redColorTF: textField.text = string(for: redColorSlider)
            case greenColorTF: textField.text = string(for: greenColorSlider)
            default: textField.text = string(for: blueColorSlider)
            }
        }
    }
    
    private func setValuee(red: UISlider, green: UISlider, blue: UISlider){
        let ciColor = CIColor(color: colorView) // Потом передать значение с другого экрана
        red.value = Float(ciColor.red)
        green.value = Float(ciColor.green)
        blue.value = Float(ciColor.blue)
    }

    private func string(for slider: UISlider) -> String{
        String(format: "%.2f", slider.value)
    }
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            textField?.text = "1.00"
            textField?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SetViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAlert(title: "Wrong format!", message: "Please enter valid value")
            return
        }

        guard let currentValue = Float(text), (0...1).contains(currentValue) else {
            showAlert(
                title: "Wrong format!",
                message: "Please enter valid value",
                textField: textField
            )
            return
        }

        switch textField {
        case redColorTF:
            redColorSlider.setValue(currentValue, animated: true)
            setValue(for: redColorLabel)
        case greenColorTF:
            greenColorSlider.setValue(currentValue, animated: true)
            setValue(for: greenColorLabel)
        default:
            blueColorSlider.setValue(currentValue, animated: true)
            setValue(for: blueColorLabel)
        }
        setColor()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        textField.inputAccessoryView = keyboardToolBar

        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )

        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        keyboardToolBar.items = [flexBarButton, doneButton]
    }
}

