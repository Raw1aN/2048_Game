//
//  ViewController.swift
//  2048-Game
//
//  Created by Алексей Щукин on 09.05.2023.
//

import UIKit

class ViewController: UIViewController {
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start Game", for: .normal)
        button.addTarget(self, action: #selector(startGameTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        startGameButtonConstraints()
    }
}

extension ViewController{
    func startGameButtonConstraints(){
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    }
}

extension ViewController{
    @objc func startGameTapped(){
        let gameViewController = GameViewController()
        gameViewController.modalPresentationStyle = .fullScreen
        self.present(gameViewController, animated: true)
    }
}

