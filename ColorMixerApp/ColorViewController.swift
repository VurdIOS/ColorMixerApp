//
//  ColorViewController.swift
//  ColorMixerApp
//
//  Created by Камаль Атавалиев on 24.02.2023.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setNewColor(for color: UIColor)
}

final class ColorViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.colorVCBc = view.backgroundColor
        settingsVC.delegate = self
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - SettingsViewControllerDelegate
extension ColorViewController: SettingsViewControllerDelegate {
    func setNewColor(for color: UIColor) {
        view.backgroundColor = color
    }

}
