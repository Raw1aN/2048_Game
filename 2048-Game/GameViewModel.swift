//
//  GameViewModel.swift
//  2048-Game
//
//  Created by Алексей Щукин on 10.05.2023.
//

import Foundation
import UIKit

class GameViewModel{
    
    var gameBoardArray: [[Int]] = [[0, 0,0,0], [0, 0,0,0],[0, 0,0,0],[0, 0,0,0]]
    
    var insertValue = 2
    
    unowned let delegate : GameProtocol
    
    init(delegate: GameProtocol){
        self.delegate = delegate
        createTile()
    }
    
    
    func printArray(){
        print("")
        for x in 0..<gameBoardArray.count {
            var line = ""
            for y in 0..<gameBoardArray[x].count {
                line += String(gameBoardArray[x][y])
                line += " "
            }
            print(line)
        }
    }
    
    private func mergeRowLeft(row: [Int], rowNumber: Int) -> [Int]{
        var resultRow = row
        for _ in 0...resultRow.count{
            for i in 1..<resultRow.count{
                // move if have space
                if resultRow[i-1] == 0{
                    if resultRow[i] != 0 && resultRow[i] != resultRow[i-1]{
                        delegate.moveOneTile(from: (i,rowNumber),
                                             to: (i-1,rowNumber),
                                             value: resultRow[i])
                    }
                    
                    resultRow[i-1] = resultRow[i]
                    resultRow[i] = 0
                }
            }
        }
        
        for i in 0..<resultRow.count-1{
            if resultRow[i] == resultRow[i+1]{
                // merge if equal number
                if resultRow[i] != 0 {
                    delegate.moveTwoTiles(from: ((rowNumber, i), (rowNumber, i+1)), to: (rowNumber, i), value: resultRow[i]*2)
                }
                
                
                
                resultRow[i] *= 2
                resultRow[i+1] = 0
            }
        }
        
        for i in 1..<resultRow.count{
            if resultRow[i-1] == 0{
                // move again
                if resultRow[i] != 0{
                    delegate.moveOneTile(from: (i,rowNumber), to: (i-1,rowNumber), value: resultRow[i])
                }
                resultRow[i-1] = resultRow[i]
                resultRow[i] = 0
            }
        }
        return resultRow
    }
    
    func mergeLeft(){
        for i in 0..<gameBoardArray.count{
            gameBoardArray[i] = mergeRowLeft(row: gameBoardArray[i], rowNumber: i)
        }
        winCheck()
        lostCheck()
    }
    
    func createTile(){
        while true{
            let row = Int.random(in: 0..<gameBoardArray.count)
            let col = Int.random(in: 0..<gameBoardArray.count)

            if gameBoardArray[row][col] == 0{
                gameBoardArray[row][col] = insertValue
                delegate.insertTile(position: (row,col), value: insertValue)
                break
            }
        }
    }
    
    private func mergeRowRight(row: [Int], rowNumber: Int) -> [Int]{
        var resultRow = row
        for _ in (0...resultRow.count/2).reversed(){
            for i in (0..<resultRow.count-1).reversed(){
                // move if have space
                if resultRow[i+1] == 0{
                    if resultRow[i] != 0 {
                        delegate.moveOneTile(from: (i,rowNumber),
                                             to: (i+1,rowNumber),
                                             value: resultRow[i])
                    }
                    
                    resultRow[i+1] = resultRow[i]
                    resultRow[i] = 0
                }
            }
        }
        
        for i in (1..<resultRow.count).reversed(){
            if resultRow[i] == resultRow[i-1]{
                // merge if equal number
                if resultRow[i] != 0 {
                    
                }
                delegate.moveTwoTiles(from: ((rowNumber, i-1), (rowNumber, i)), to: (rowNumber, i), value: resultRow[i]*2)
                resultRow[i] *= 2
                resultRow[i-1] = 0
            }
        }
        
        for i in (1..<resultRow.count-1).reversed(){
            if resultRow[i+1] == 0{
                // move again
                if resultRow[i] != 0{
                    delegate.moveOneTile(from: (i,rowNumber), to: (i+1,rowNumber), value: resultRow[i])
                }
                resultRow[i+1] = resultRow[i]
                resultRow[i] = 0
            }
        }
        return resultRow
        
    }
    
    func mergeRight(){
        for i in 0..<gameBoardArray.count{
            gameBoardArray[i] = mergeRowRight(row: gameBoardArray[i], rowNumber: i)
        }
        winCheck()
        lostCheck()
    }
    
    private func transpose(){
        for j in 0..<gameBoardArray.count{
            for i in j..<gameBoardArray.count{
                if i != j{
                    let temp = gameBoardArray[j][i]
                    gameBoardArray[j][i] = gameBoardArray[i][j]
                    gameBoardArray[i][j] = temp
                }
            }
        }
    }
    
    func mergeUp(){
        transpose()
        printArray()
        mergeTop()
        transpose()
    }
    
    private func mergeColTop(row: [Int], rowNumber: Int) -> [Int]{
        var resultRow = row
        for _ in 0...resultRow.count{
            for i in 1..<resultRow.count{
                // move if have space
                if resultRow[i-1] == 0{
                    if resultRow[i] != 0 {
                        delegate.moveOneTile(from: (rowNumber,i),
                                             to: (rowNumber,i-1),
                                             value: resultRow[i])
                    }
                    
                    resultRow[i-1] = resultRow[i]
                    resultRow[i] = 0
                }
            }
        }
        
        for i in 0..<resultRow.count-1{
            if resultRow[i] == resultRow[i+1]{
                // merge if equal number
                if resultRow[i] != 0 {
                    delegate.moveTwoTiles(from: ((i, rowNumber), (i+1, rowNumber)), to: (i, rowNumber), value: resultRow[i]*2)
                }
                resultRow[i] *= 2
                resultRow[i+1] = 0
            }
        }
        
        for i in 1..<resultRow.count{
            if resultRow[i-1] == 0{
                // move again
                if resultRow[i] != 0{
                    delegate.moveOneTile(from: (rowNumber,i), to: (rowNumber,i-1), value: resultRow[i])
                }
                resultRow[i-1] = resultRow[i]
                resultRow[i] = 0
            }
        }
        return resultRow
    }
    
    func mergeTop(){
        for i in 0..<gameBoardArray.count{
            gameBoardArray[i] = mergeColTop(row: gameBoardArray[i], rowNumber: i)
        }
        winCheck()
        lostCheck()
    }
    
    func mergeDown(){
        transpose()
        printArray()
        mergeBottom()
        transpose()
    }
    
    func mergeBottom(){
        for i in 0..<gameBoardArray.count{
            gameBoardArray[i] = mergeColBottom(row: gameBoardArray[i], rowNumber: i)
        }
        winCheck()
        lostCheck()
    }
    
    private func mergeColBottom(row: [Int], rowNumber: Int) -> [Int]{
        
        var resultRow = row
        for _ in (0...resultRow.count/2).reversed(){
            for i in (0..<resultRow.count-1).reversed(){
                // move if have space
                if resultRow[i+1] == 0{
                    if resultRow[i] != 0 {
                        delegate.moveOneTile(from: (rowNumber,i),
                                             to: (rowNumber,i+1),
                                             value: resultRow[i])
                    }
                    
                    resultRow[i+1] = resultRow[i]
                    resultRow[i] = 0
                }
            }
        }
        
        for i in (1..<resultRow.count).reversed(){
            if resultRow[i] == resultRow[i-1]{
                // merge if equal number
                if resultRow[i] != 0 {
                    
                }
                delegate.moveTwoTiles(from: ((i-1, rowNumber), (i, rowNumber)), to: (i, rowNumber), value: resultRow[i]*2)
                resultRow[i] *= 2
                resultRow[i-1] = 0
            }
        }
        
        for i in (1..<resultRow.count-1).reversed(){
            if resultRow[i+1] == 0{
                // move again
                if resultRow[i] != 0{
                    delegate.moveOneTile(from: (rowNumber,i), to: (rowNumber,i+1), value: resultRow[i])
                }
                resultRow[i+1] = resultRow[i]
                resultRow[i] = 0
            }
        }
        return resultRow
    }
    
    func cleareArray(){
        for i in 0..<gameBoardArray.count{
            for j in 0..<gameBoardArray.count{
                gameBoardArray[i][j] = 0
            }
        }
    }
    
    func winCheck(){
        for i in 0..<gameBoardArray.count{
            for j in 0..<gameBoardArray.count{
                if(gameBoardArray[i][j] == 2048){
                    delegate.winEnd()
                }
            }
        }
    }
    
    func lostCheck(){
        var isLost = true
        for i in 0..<gameBoardArray.count-1{
            for j in 0..<gameBoardArray.count-1{
                if gameBoardArray[i][j] == gameBoardArray[i][j+1] && gameBoardArray[i][j] == gameBoardArray[i+1][j]{
                    isLost = false
                }
            }
        }
        if isLost{
            delegate.lostEnd()
        }
        
    }
}
