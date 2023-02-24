//
//  ViewController.swift
//  ColorMixerApp
//
//  Created by Камаль Атавалиев on 06.02.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet var colorMixView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var GreenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    var colorVCBc: UIColor!
    
    unowned var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorMixView.layer.cornerRadius = 20
        
        redColorSlider.minimumTrackTintColor = .red
        GreenColorSlider.minimumTrackTintColor = .green
        blueColorSlider.minimumTrackTintColor = .blue
        
        colorMixView.backgroundColor = colorVCBc
        setSlidersPosition(of: getComponentsOf(colorMixView.backgroundColor ?? .white))
        setValue(for: redColorLabel, greenColorLabel, blueColorLabel)
        
    }
    
    // MARK: IBAction
    
    @IBAction func DoneButtonPressed() {
        delegate.setNewColor(for: colorMixView.backgroundColor ?? .red)
        dismiss(animated: true)
    }
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        switch sender {
        case redColorSlider:
            redColorLabel.text = string(from: sender)
        case GreenColorSlider:
            greenColorLabel.text = string(from: sender)
        default:
            blueColorLabel.text = string(from: sender)
        }
    }
    
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
            case greenColorLabel:
                greenColorLabel.text = string(from: GreenColorSlider)
            default:
                blueColorLabel.text = string(from: blueColorSlider)
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
