//
//  BoardView.swift
//  2048-Game
//
//  Created by Алексей Щукин on 09.05.2023.
//

import Foundation
import UIKit



class BoardView: UIView{
    let fieldCount = 4
    let tilePadding:CGFloat = 10
    let tileWidth: CGFloat = 65
    let radius: CGFloat = 2
    
    var tiles = Dictionary<IndexPath, TileView>()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupBackground()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoardView{
    func setupBackground() {
        backgroundColor = .systemGray2
        var xposition = tilePadding/2
        var yposition: CGFloat
        for _ in 0..<fieldCount{
            yposition = tilePadding/2
            for _ in 0..<fieldCount{
                let background = UIView(frame: CGRect(x: xposition, y: yposition, width: tileWidth, height: tileWidth))
                background.layer.cornerRadius = radius
                background.backgroundColor = .systemGray
                addSubview(background)
                yposition += tilePadding + tileWidth
            }
            xposition += tilePadding + tileWidth
        }
    }
    
    func insertTile(position: (Int, Int), value: Int) {
        let (row, col) = position
        let xposition = tilePadding/2 + CGFloat(col)*(tileWidth + tilePadding)
        let yposition = tilePadding/2 + CGFloat(row)*(tileWidth + tilePadding)
        let r = radius
        
        let tile = TileView(value: value, position: CGPoint(x: xposition, y: yposition), width: tileWidth, radius: r)
        
        tile.setNumber(value: value)
        
        addSubview(tile)
        
        tiles[IndexPath(row: row, section: col)] = tile
        tile.alpha = 0
        
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.bringSubviewToFront(tile)
            tile.alpha = 1
        }
//        print("\(tiles.keys)From Insert Tile")
//        print("!!!!!!!!!")
    }
    
    func moveOneTile(from: (Int,Int), to: (Int,Int), value: Int){
        let (xFromPosition,yFromPosition) = from
        let (xToPosition,yToPosition) = to
        let fromIndexPath = IndexPath(row: yFromPosition, section: xFromPosition)
        let toIndexPath = IndexPath(row: yToPosition, section: xToPosition)
        
        guard let tile = tiles[fromIndexPath] else { print("moveOneTitle: There is no Tile with this positions"); return }
        var finalPosiition = tile.frame
        
        finalPosiition.origin.x = tilePadding/2 + CGFloat(xToPosition)*(tileWidth + tilePadding)
        finalPosiition.origin.y = tilePadding/2 + CGFloat(yToPosition)*(tileWidth + tilePadding)
        
        tiles[toIndexPath] = tile
        tiles.removeValue(forKey: fromIndexPath)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0) {
                tile.frame = finalPosiition
            } completion: { _ in
                
            }
        }
        let toKey = IndexPath(row: xToPosition, section: yToPosition)
        let endTile = tiles[toKey]
//
//        print("\(tiles.keys)from moveoneTile")
    }
    
    func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {
      let (fromRowA, fromColA) = from.0
      let (fromRowB, fromColB) = from.1
      let (toRow, toCol) = to
      let fromKeyA = IndexPath(row: fromRowA, section: fromColA)
      let fromKeyB = IndexPath(row: fromRowB, section: fromColB)
      let toKey = IndexPath(row: toRow, section: toCol)

      guard let tileA = tiles[fromKeyA] else {
        return
      }
      guard let tileB = tiles[fromKeyB] else {
        return
      }
        
      var finalFrame = tileA.frame
      finalFrame.origin.x = tilePadding/2 + CGFloat(toCol)*(tileWidth + tilePadding)
      finalFrame.origin.y = tilePadding/2 + CGFloat(toRow)*(tileWidth + tilePadding)
      tiles.removeValue(forKey: fromKeyA)
      tiles.removeValue(forKey: fromKeyB)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3,
            delay: 0.0,
            animations: {
                tileA.frame = finalFrame
                tileB.frame = finalFrame
            }, completion: { finished in
                self.insertTile(position: to, value: value)
                tileA.removeFromSuperview()
                tileB.removeFromSuperview()
                if !finished {
                    return
                }
            })
        }
    }
}
