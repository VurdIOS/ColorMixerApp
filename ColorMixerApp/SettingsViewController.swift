//
//  ViewController.swift
//  ColorMixerApp
//
//  Created by Камаль Атавалиев on 06.02.2023.
//

import UIKit



final class SettingsViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet var colorMixView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var GreenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    @IBOutlet var redColorTF: UITextField!
    @IBOutlet var greenColorTF: UITextField!
    @IBOutlet var blueColorTF: UITextField!
    
    
    var colorVCBc: UIColor!
    
    unowned var delegate: SettingsViewControllerDelegate!
    
    // MARK: - override func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        redColorTF.delegate = self
//        greenColorTF.delegate = self
//        blueColorTF.delegate = self
        
        
        addDoneButtonOnNumpad(textField: redColorTF)
        addDoneButtonOnNumpad(textField: greenColorTF)
        addDoneButtonOnNumpad(textField: blueColorTF)
        
        colorMixView.layer.cornerRadius = 20
        
        redColorSlider.minimumTrackTintColor = .red
        GreenColorSlider.minimumTrackTintColor = .green
        blueColorSlider.minimumTrackTintColor = .blue
        
        colorMixView.backgroundColor = colorVCBc
        setSlidersPosition(of: getComponentsOf(colorMixView.backgroundColor ?? .white))
        setValue(for: redColorLabel, greenColorLabel, blueColorLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBAction
    
    @IBAction func DoneButtonPressed() {
        delegate.setNewColor(for: colorMixView.backgroundColor ?? .red)
        dismiss(animated: true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        switch sender {
        case redColorSlider:
            redColorLabel.text = string(from: sender)
            redColorTF.text = string(from: sender)
        case GreenColorSlider:
            greenColorLabel.text = string(from: sender)
            greenColorTF.text = string(from: sender)
        default:
            blueColorLabel.text = string(from: sender)
            blueColorTF.text = string(from: sender)
        }
    }
    
    
    // MARK: - private funcs
    
    private func setColor() {
        colorMixView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(GreenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redColorLabel:
                redColorLabel.text = string(from: redColorSlider)
                redColorTF.text = redColorLabel.text
            case greenColorLabel:
                greenColorLabel.text = string(from: GreenColorSlider)
                greenColorTF.text = greenColorLabel.text
            default:
                blueColorLabel.text = string(from: blueColorSlider)
                blueColorTF.text = blueColorLabel.text
            }
        }
    }
    
    private func setSlidersPosition(of backgroundColor: (red: CGFloat, green: CGFloat, blue: CGFloat)) {
        redColorSlider.value = Float(backgroundColor.red)
        GreenColorSlider.value = Float(backgroundColor.green)
        blueColorSlider.value = Float(backgroundColor.blue)
        
    }
    
    private func getComponentsOf(_ color: UIColor) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue)
    }

}
// MARK: - SettingsViewController

extension SettingsViewController {
    
    private func addDoneButtonOnNumpad(textField: UITextField) {
        let keypadToolbar = UIToolbar()
        
        keypadToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textField, action: #selector(UITextField.resignFirstResponder))
        ]
        keypadToolbar.sizeToFit()
        textField.inputAccessoryView = keypadToolbar
    }
}
// MARK: - Проблема

// Вот здесь я встал, и никак не могу назначить значение слайдеру...
//extension SettingsViewController: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        redColorSlider.value = Float(textField)
//    }
//}


