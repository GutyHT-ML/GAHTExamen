//
//  Player.swift
//  GAHTExamen
//
//  Created by mac12 on 3/4/21.
//  Copyright © 2021 UTT. All rights reserved.
//

import UIKit

class Player: Codable {
    var nickname:String
    var score:Int
    
    init(_ name:String, score:Int) {
        self.nickname = name
        self.score = score
    }
    
    func register() -> Bool {
        if (Player.check(nick: self.nickname)) {
            return false
        }
        App.shared.players = Player.all()
        App.shared.players.append(self)
        self.store()
        return true
    }
    
    func store() -> Void {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(App.shared.players)
            App.shared.defaults.set(data, forKey: "players")
            App.shared.defaults.synchronize()
        }catch {
            print("Error al serializar\(error)")
        }
    }
    
    func saveScore(index:Int, score:Int) -> Void {
        var players:[Player] = Player.all()
        if index < players.count {
            self.score = score
            players[index] = self
            App.shared.players = players
        } else {
            print("index out of range")
        }
        self.store()
    }
    
    static func hiScore() -> Player!{
        let players:[Player] = Player.all()
        if let hiscoreplayer = players.last(where: {$0.score == Player.allScores().max()}) {
            return hiscoreplayer
        } else {
            return nil
        }
    }
    
    static func find() -> Player {
        let players:[Player] = Player.all()
        let curPlayer:Player! = players.last
        return curPlayer
    }
    
    static func check(nick:String) -> Bool {
        let players:[Player] = Player.all()
        var used = false
        players.forEach{(player) in
            if (player.nickname == nick) {
                used = true
            }
        }
        return used
    }
    
    static func clean() -> Void {
        Player.displayAll()
        App.shared.players.removeAll()
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(App.shared.players)
            App.shared.defaults.set(data, forKey: "players")
            App.shared.defaults.synchronize()
            Player.displayAll()
        }catch {
            print("Error al serializar\(error)")
        }
    }
    
    static func all() -> [Player]{
        if let data = App.shared.defaults.object(forKey: "players") as? Data{
            let decoder = JSONDecoder()
            guard let players = try? decoder.decode([Player].self, from: data) else { return [Player]() }
            return players
        }
        return [Player]()
    }
    
    static func allScores() -> [Int] {
        var scores:[Int] = []
        let players = Player.all()
        players.forEach({scores.append($0.score)})
        return scores
    }
    
    static func displayAll() -> Void {
        Player.all().forEach{(player) in
            print("Name: \(player.nickname) Score: \(player.score)")
        }
    }
    
    static func displayOne(index:Int) -> Void {
        print(index)
        let p:Player = Player.all()[index]
        print(p.nickname)
    }
}
