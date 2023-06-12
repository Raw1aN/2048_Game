//
//  TileView.swift
//  2048-Game
//
//  Created by Алексей Щукин on 09.05.2023.
//

import Foundation
import UIKit

class TileView: UIView{
    
    private let properties = Properties()
    
    private let tileNumber: UILabel = {
        let label = UILabel()
        return label
    }()
    
    init(value: Int,position: CGPoint,width: CGFloat, radius: CGFloat) {
        super.init(frame: CGRect(x: position.x, y: position.y, width: width, height: width))
        setupNumberConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TileView{
    func setNumber(value: Int){
        tileNumber.text = String(value)
        backgroundColor = properties.tileColor(value)
    }
}

extension TileView{
    func setupNumberConstraints(){
        tileNumber.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tileNumber)
        tileNumber.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        tileNumber.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
    }
}
