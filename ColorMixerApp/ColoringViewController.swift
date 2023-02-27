//
//  ColoringViewController.swift
//  ColorMixerApp
//
//  Created by Камаль Атавалиев on 27.02.2023.
//

import UIKit

protocol SetViewControllerDelegate: AnyObject {
    func getColor(_ color: UIColor)
}

final class ColoringViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let setVC = segue.destination as? SetViewController else { return }
        setVC.colorView = view.backgroundColor
        setVC.delegate = self
    }

}
extension ColoringViewController: SetViewControllerDelegate {
    func getColor(_ color: UIColor) {
        view.backgroundColor = color
    }
    
    
}
