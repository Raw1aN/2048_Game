//
//  GameViewController.swift
//  2048-Game
//
//  Created by Алексей Щукин on 09.05.2023.
//

import UIKit

protocol GameProtocol: AnyObject{
    func insertTile(position: (Int, Int), value: Int)
    func moveOneTile(from: (Int,Int), to: (Int,Int), value: Int)
    func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int)
    func winEnd()
    func lostEnd()
}

class GameViewController: UIViewController, GameProtocol {
    var gameViewModel: GameViewModel?
    
    private let boardView: BoardView = {
        let view = BoardView()
        return view
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        setupSwipesRecognizers()
        setupGameBoardConstraints()
        setupResetButtonConstraints()
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        gameViewModel = GameViewModel(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameViewController{
    func setupSwipesRecognizers(){
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(upCommand))
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizer.Direction.up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(downCommand))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(downSwipe)

        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftCommand))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(leftSwipe)

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightCommand))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        view.addGestureRecognizer(rightSwipe)
    }
}

extension GameViewController{
    @objc func upCommand(_ r: UIGestureRecognizer!) {
        guard let viewModel = gameViewModel else { return }
        viewModel.mergeUp()
        viewModel.createTile()
        //viewModel.printArray()
    }

    @objc func downCommand(_ r: UIGestureRecognizer!) {
        guard let viewModel = gameViewModel else { return }
        viewModel.mergeDown()
        viewModel.createTile()
        //viewModel.printArray()
    }

    @objc func leftCommand(_ r: UIGestureRecognizer!) {
        guard let viewModel = gameViewModel else { return }
        viewModel.mergeLeft()
        viewModel.createTile()
        //viewModel.printArray()
    }

    @objc func rightCommand(_ r: UIGestureRecognizer!) {
        guard let viewModel = gameViewModel else { return }
        viewModel.mergeRight()
        viewModel.createTile()
        //viewModel.printArray()
    }
    
    @objc func resetGame(){
        guard let viewModel = gameViewModel else { return }
        for i in boardView.tiles.values{
            i.removeFromSuperview()
        }
        boardView.tiles.removeAll()
        viewModel.cleareArray()
        viewModel.createTile()
    }
    
    func winEnd() {
        resetGame()
        let alert = UIAlertController(title: "You won!", message: "Congritulations!",         preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                //Cancel Action
        }))
            
            self.present(alert, animated: true, completion: nil)
    }
    
    func lostEnd() {
        resetGame()
        let alert = UIAlertController(title: "You lost!", message: "Try again!",         preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                //Cancel Action
        }))
            
            self.present(alert, animated: true, completion: nil)
    }
}

extension GameViewController{
    func setupGameBoardConstraints(){
        view.addSubview(boardView)
        boardView.translatesAutoresizingMaskIntoConstraints = false
        boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        boardView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        boardView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        boardView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setupResetButtonConstraints(){
        view.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        resetButton.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 20).isActive = true
    }
}

extension GameViewController{
    
    func insertTile(position: (Int, Int), value: Int) {
        boardView.insertTile(position: position, value: value)
    }
    
    func moveOneTile(from: (Int, Int), to: (Int, Int), value: Int) {
        boardView.moveOneTile(from: from, to: to, value: value)
    }
    
    func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {
        boardView.moveTwoTiles(from: from, to: to, value: value)
    }
}
