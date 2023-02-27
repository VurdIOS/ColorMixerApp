//
//  SetViewController.swift
//  ColorMixerApp
//
//  Created by Камаль Атавалиев on 27.02.2023.
//

import UIKit

class SetViewController: UIViewController {

    
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
    
    var colorView: UIColor!
    unowned var delegate: ColoringViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorMixView.layer.cornerRadius = 20
        colorMixView.backgroundColor = colorView
        
        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.minimumTrackTintColor = .green
        blueColorSlider.minimumTrackTintColor = .blue
        
        
        setValue(red: redColorSlider, green: greenColorSlider, blue: blueColorSlider)
        setValue(for: redColorTF, greenColorTF, blueColorTF)
        setValue(for: redColorLabel, greenColorLabel, blueColorLabel)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
   
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
    
    private func setValue(red: UISlider, green: UISlider, blue: UISlider){
        let ciColor = CIColor(color: colorView) // Потом передать значение с другого экрана
        red.value = Float(ciColor.red)
        green.value = Float(ciColor.green)
        blue.value = Float(ciColor.blue)

//        sliders.forEach { slider in
//            switch sliders {
//            case redColorSlider: redColorSlider.value = Float(ciColor.red)
//            case greenColorSlider: greenColorSlider.value = Float(ciColor.green)
//            default: slider.value = Float(ciColor.blue)
//            }
//        } Не работает
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
