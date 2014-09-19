//
//  TTTImageView.swift
//  TicTacToe
//
//  Created by DavidMcQueen on 19/09/2014.
//  Copyright (c) 2014 DavidMcQueen. All rights reserved.
//

import UIKit

class TTTImageView: UIImageView {

    var player:String?
    var activated:Bool! = false
    
    func setPlayer (_player:String){
        self.player = _player
        
        if activated == false{
            if _player == "x" {
                self.image = UIImage(named: "X")
            } else {
                self.image=UIImage(named: "o")
            }
            activated = true;
        }
    }
}
