//
//  MenuVC.swift
//  Hit and Block
//
//  Created by Apple on 03/08/22.
//

import Foundation
import UIKit

enum gameType {
    case easy
    case medium
    case hard
    case god
    case player2
}

class MenuVC: UIViewController {
    @IBAction func easy(_ sender: Any) {
        startGame(game: .easy)
    }
    @IBAction func medium(_ sender: Any) {
        startGame(game: .medium)
    }
    @IBAction func hard(_ sender: Any) {
        startGame(game: .hard)
    }
    @IBAction func GOD(_ sender: Any) {
        startGame(game: .god)
    }
    @IBAction func Player2(_ sender: Any) {
        startGame(game: .player2)
    }
    
    func startGame(game: gameType){
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        currentGameType = game 
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
