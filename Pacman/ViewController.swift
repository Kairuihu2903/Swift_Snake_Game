//
//  ViewController.swift
//  Pacman
//
//  Created by Kairui Hu on 4/24/23.
//

import UIKit

class ViewController: UIViewController {
    // call Method SnakeBoard
    var board: SnakeBoard = SnakeBoard()
    
    //BoardView outlet
    @IBOutlet weak var boardView: BoardView!
    
    // starting direction
    var direction : MovingDirection = .down
    
    // score label outlet
    @IBOutlet weak var Score: UILabel!
    
    // Keeps track of current highscore
    var currentHigh: Double = 0
    
    // current speed
    var speed: Double = 0.2
    
    //HighScore Oulet
    @IBOutlet weak var HighScore: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Snake Starting Position
        board.snake.append(SnakeCell(row: 1, col:2))
        
        boardView.shadowSnake = board.snake
        
        updateUI()
        
        
        // get user key input
        let upArrowKeyCommand = UIKeyCommand(input: UIKeyCommand.inputUpArrow, modifierFlags: [], action: #selector(Up))
        addKeyCommand(upArrowKeyCommand)
        
        //get user key input
        let downArrowKeyCommand = UIKeyCommand(input: UIKeyCommand.inputDownArrow, modifierFlags: [], action: #selector(Down))
        addKeyCommand(downArrowKeyCommand)
        
        //get user key input
        let leftArrowKeyCommand = UIKeyCommand(input: UIKeyCommand.inputLeftArrow, modifierFlags: [], action: #selector(Left))
        addKeyCommand(leftArrowKeyCommand)
        
        //get user key input
        let rightArrowKeyCommand = UIKeyCommand(input: UIKeyCommand.inputRightArrow, modifierFlags: [], action: #selector(Right))
        addKeyCommand(rightArrowKeyCommand)
        
        
        //snake movement and direction
        Timer.scheduledTimer(withTimeInterval: speed, repeats: true){
            (Timer) in
            switch self.direction {
            //case .stand:
            //    self.board.stand()
            case .left:
                    self.board.moveLeft()

            case .right:

                    self.board.moveRight()
                
            case .up:

                    self.board.moveUp()
            case .down:
                    self.board.moveDown()
            }
            self.updateUI()
            
            }
        //}

    }

    // onclick restart button
    @IBAction func Restart_click(_ sender: UIButton) {
        board.snake = []
        direction = .down
        board.score = 0
        board.isMoving = true
        board.snake.append(SnakeCell(row: 1, col:2))
        boardView.shadowSnake = board.snake
        updateUI()
    }
    func addOneToValue(_ value: inout Double) {
        value += 1
    }

    
    @IBAction func easy(_ sender: Any) {
        boardView.cellSide = 20
        board.snake = []
        SnakeBoard.cols = 13
        SnakeBoard.rows = 20
        addOneToValue(&speed)
        direction = .down
        board.score = 0
        board.isMoving = true
        board.snake.append(SnakeCell(row: 1, col:2))
        boardView.shadowSnake = board.snake
        updateUI()
    }
    
    @IBAction func medium(_ sender: Any) {
        boardView.cellSide = 18
        board.snake = []
        SnakeBoard.cols = 18
        SnakeBoard.rows = 30
        speed = 0.05
        direction = .down
        board.score = 0
        board.isMoving = true
        board.snake.append(SnakeCell(row: 1, col:2))
        boardView.shadowSnake = board.snake
        updateUI()
    }
    
    @IBAction func hard(_ sender: Any) {
        boardView.cellSide = 16
        board.snake = []
        SnakeBoard.cols = 23
        SnakeBoard.rows = 29
        speed = 0.001
        direction = .down
        board.score = 0
        board.isMoving = true
        board.snake.append(SnakeCell(row: 1, col:2))
        boardView.shadowSnake = board.snake
        updateUI()
    }
    
    // onclick up UI button
    @IBAction func Up(_ sender: UIButton) {
        direction = .up

    }
    
    // onclick down UI button
    @IBAction func Down(_ sender: UIButton) {
        direction = .down

    }
    
    // onclick right UI button
    @IBAction func Right(_ sender: UIButton) {
        direction = .right

    }
    
    // onclick left UI button
    @IBAction func Left(_ sender: UIButton) {
        direction = .left

    }
    
    // updateUI
    func updateUI(){
        boardView.shadowSnake = board.snake
        boardView.shadowFruitCol = board.FruitCol
        boardView.shadowFruitRow = board.FruitRow
        //Output Score
        Score.text = String(board.score)
        
        //Output High Score
        if currentHigh <= board.score
        {
            currentHigh = board.score
            HighScore.text = String(currentHigh)
        }
        
        boardView.setNeedsDisplay()
    }
}

