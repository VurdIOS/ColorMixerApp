//
//  ViewController.swift
//  ColorMixerApp
//
//  Created by Камаль Атавалиев on 06.02.2023.
//

import UIKit

class ViewController: UIViewController {
    // Mark  как у Вас в уроке не работает, пропишу просто комментариями
    
    // IBOutlet

    @IBOutlet var colorMixView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var GreenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    override func viewDidLoad() {
        
        colorMixView.layer.cornerRadius = 20
        
        setup(slider: redColorSlider, color: .red)
        setup(slider: GreenColorSlider, color: .green)
        setup(slider: blueColorSlider, color: .blue)
        
    }

    // IBAction
    
    @IBAction func redColorSliderChanged() {
        redColorLabel.text = String(format: "%.2f", redColorSlider.value)
        setupColorMixView()
    }
    
    @IBAction func greenColorSliderChanged() {
        greenColorLabel.text = String(format: "%.2f", GreenColorSlider.value)
        setupColorMixView()
    }
    
    @IBAction func blueColorSliderChanged() {
        blueColorLabel.text = String(format: "%.2f", blueColorSlider.value)
        setupColorMixView()
    }
    
    
    
    // private func Знаю что функция настройки слайдера не особо функциональная, но я решил сделать так на случай расширения функционала.
    private func setupColorMixView() {
        colorMixView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(GreenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1)
    }
    
    private func setup(slider: UISlider, color: UIColor ) {
        slider.minimumTrackTintColor = color
    }
    
}

