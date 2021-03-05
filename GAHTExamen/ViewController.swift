//
//  ViewController.swift
//  GAHTExamen
//
//  Created by mac12 on 3/4/21.
//  Copyright © 2021 UTT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnJugar: UIButton!
    @IBOutlet weak var tfNickname: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnJugar.layer.cornerRadius = btnJugar.frame.width / 2
    }
    
    @IBAction func clean(_ sender: Any) {
        Player.clean()
    }
    @IBAction func startMatch(_ sender: UIButton) {
        if let username = tfNickname.text {
            let player = Player(username, score:0)
            if (player.register()){
                self.performSegue(withIdentifier: "sgMatch", sender: nil)
            }else{
                self.animateWrong(view: sender)
                self.alertDefault(with: "Error", andWithMag: "Nickname currently in use")
            }
        }
        else{
            self.animateWrong(view: sender)
            self.alertDefault(with: "Error", andWithMag: "Nickname field is empty")
        }
    }
    
    func animateWrong (view: UIView) -> Void {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            var slightMoveLeft = view.frame
            slightMoveLeft.origin.x -= 15
            view.frame = slightMoveLeft
        })
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            var slightMoveRight = view.frame
            slightMoveRight.origin.x += 30
            view.frame = slightMoveRight
        }, completion: { finished in
            view.frame.origin.x -= 15
        })
        UIView.animate(withDuration: 0.1, delay: 0.2, options: .curveLinear, animations: {
            var slightMoveLeft = view.frame
            slightMoveLeft.origin.x -= 15
            view.frame = slightMoveLeft
        })
        UIView.animate(withDuration: 0.1, delay: 0.3, options: .curveLinear, animations: {
            var slightMoveRight = view.frame
            slightMoveRight.origin.x += 30
            view.frame = slightMoveRight
        }, completion: { finished in
            view.frame.origin.x -= 15
        })
    }
    
}
extension UIViewController{
    func alertDefault(with title: String, andWithMag description: String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(a) in alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

