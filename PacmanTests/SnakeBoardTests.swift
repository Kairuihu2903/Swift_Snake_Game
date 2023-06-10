//
//  SnakeBoardTests.swift
//  PacmanTests
//
//  Created by Kairui Hu on 4/24/23.
//

import XCTest

@testable import Pacman

class SnakeBoardTests: XCTestCase{
    
    func testPrintingBoard(){
        var board = SnakeBoard()
        board.snake.append(SnakeCell(row: 2, col: 1))
        print(board)
        board.moveLeft()
        board.moveLeft()
        print(board)
    }
}

