//
//  MatchController.swift
//  GAHTExamen
//
//  Created by mac12 on 3/4/21.
//  Copyright © 2021 UTT. All rights reserved.
//

import UIKit

class MatchController: UIViewController {
    @IBOutlet weak var lblNickname: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblHiscore: UILabel!
    @IBOutlet var buttonArray: [UIButton]!
    var orderArray:[String]!
    var light:Int!
    var level:Int!
    var colorSelection:Int!
    var timer: Timer!
    let player = Player.find()
    var score:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        orderArray = []
        level = 0
        score = 0
        light = 0
        lblNickname.text = player.nickname
        lblHiscore.text = Player.hiScore()?.nickname
        start()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        endMatch()
    }
    
    func start() -> Void {
        focusButton()
        buttonArray.forEach{ (btn) in
            btn.isEnabled = false
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(runSequence), userInfo: nil, repeats: true)
        colorSelection = 0
        level += 1
    }
    
    func focusButton() {
        let btnPos = Int.random(in: 0...3)
        var title:String!
        switch btnPos {
        case 0:
            title = "yellow"
            break
        case 1:
            title = "red"
            break
        case 2:
            title = "green"
            break
        case 3:
            title = "blue"
            break
        default:
            title = ""
            print(btnPos)
            break
        }
        if let btn = buttonArray.first(where: {$0.currentTitle == title}){
            print(btn.currentTitle!)
            orderArray.append(btn.currentTitle!)
        }
    }
    
    @objc func runSequence() -> Void {
        let btn = self.buttonArray.first(where: {$0.currentTitle == self.orderArray[light]})
        btn?.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            btn?.alpha = 1
        })
        light += 1
        if light == level {
            timer.invalidate()
            light = 0
            buttonArray.forEach{ (btn) in
                btn.isEnabled = true
            }
        }
    }
    
    func endMatch() -> Void {
        player.saveScore(index: Player.all().endIndex - 1 ,score: score)
        orderArray = []
        level = 0
        score = 0
    }
    
    @IBAction func colorTouch(_ sender: UIButton) {
        let color:String = sender.title(for: .selected) ?? "Dondelepicastetravieso7w7"
        if color == orderArray[colorSelection] {
            colorSelection += 1
            score += 10
            if colorSelection == orderArray.count {
                start()
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        lblScore.text = String(score)
    }
}
extension UIViewController{
    func alertDefault(with title: String, description: String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(a) in alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


