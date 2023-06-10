//
//  SnakeBoard.swift
//  Pacman
//
//  Created by Kairui Hu on 4/24/23.
//

import Foundation
import UIKit

struct SnakeBoard: CustomStringConvertible{
    var score: Double = 0 // current score
    
    static var cols:Int = 15    // # of cols on board
    static var rows: Int = 20   //# of rows on board
    
    var isMoving: Bool  = true  //determins when snake stops
    var FruitCol: Int = 2       //positon of fruit
    var FruitRow: Int = 1       //position of fruit
    
    var snake: [SnakeCell] = [] //snake position
    
    var currentD = "s"          // direction the snake is moving in
    
    // randomizing the postion of the fruit
    mutating func randomizeFruit(){
        FruitCol = Int(arc4random()) % SnakeBoard.cols
        FruitRow = Int(arc4random()) % SnakeBoard.rows
        // make sure fruit is not on snake
        while isOnSnake(col: FruitCol, row: FruitRow){
            FruitCol = Int(arc4random()) % SnakeBoard.cols
            FruitRow = Int(arc4random()) % SnakeBoard.rows
        }
    }
    
    //checks to see if snake is off the board
    mutating func isOutOfBounds() -> Bool {
        if snake[0].row == -1 || snake[0].row >= SnakeBoard.rows{
            return true
        }
        if snake[0].col == -1 || snake[0].col >= SnakeBoard.cols{
            return true
        }
        return false
    }
    
    //checks to see if snake is on itself
    mutating func isOnSelf() -> Bool{
        if score >= 2 && isMoving == true
        {
           for i in 1...snake.count-1{
               if snake[0].col == snake[i].col && snake[0].row == snake[i].row{
                    return true
                }
            }
        }
            return false
    }
    
    
    //move left
    mutating func moveLeft(){
        //stop if snake off board or on itself
        if isOutOfBounds()
        {
            isMoving = false
        }
        if isOnSelf()
        {
            isMoving = false
        }
        if isMoving == true {
            // make sure the snake cant go though itself
            if currentD != "d"{
                updateSnake(newHead: SnakeCell(row: snake[0].row, col: snake[0].col - 1))
                currentD = "a"
            }
            else{
                updateSnake(newHead: SnakeCell(row: snake[0].row, col: snake[0].col + 1))
            }
        }

    }
    
    
    //move right
    mutating func moveRight(){
        //stop if snake off board or on itself
        if isOutOfBounds()
        {
            isMoving = false
        }
        if isOnSelf()
        {
            isMoving = false
        }
        if isMoving == true {
            // make sure the snake cant go though itself
            if currentD != "a"{
                updateSnake(newHead: SnakeCell(row: snake[0].row, col: snake[0].col + 1))
                currentD = "d"
            }
            else{
                updateSnake(newHead: SnakeCell(row: snake[0].row, col: snake[0].col - 1))
            }

        }
    }
    
    //move up
    mutating func moveUp(){
        //stop if snake off board or on itself
        if isOutOfBounds()
        {
            isMoving = false
        }
        if isOnSelf()
        {
            isMoving = false
        }
        if isMoving == true{
            // make sure the snake cant go though itself
            if currentD != "s"{
                updateSnake(newHead: SnakeCell(row: snake[0].row - 1, col: snake[0].col ))
                currentD = "w"
            }
            else{
                updateSnake(newHead: SnakeCell(row: snake[0].row + 1, col: snake[0].col ))
            }
            

        }

    }
    //move down
    mutating func moveDown(){
        //stop if snake off board or on itself
        if isOutOfBounds()
        {
            isMoving = false
        }
        if isOnSelf()
        {
            isMoving = false
        }
        if isMoving == true{
            // make sure the snake cant go though itself
            if currentD != "w" {
                updateSnake(newHead: SnakeCell(row: snake[0].row + 1, col: snake[0].col ))
                currentD = "s"
            }
            else{
                updateSnake(newHead: SnakeCell(row: snake[0].row - 1, col: snake[0].col ))
            }

        }
    }
    
    //updates snake
    mutating func updateSnake(newHead: SnakeCell)
    {
        var newSnake: [SnakeCell] = []
        newSnake.append(newHead)
        for i in 0..<snake.count-1 {
            newSnake.append(snake[i])
        }
        
        
        let oldTail = snake[snake.count - 1]
        
        // if snake eats fruit grow
        if snake[0].col == FruitCol && snake[0].row == FruitRow{
            newSnake.append(oldTail)
            score += 1
            randomizeFruit()
        }
        
    
        snake = newSnake
    }
    
    // checks if something is on the snake
    func isOnSnake(col : Int, row: Int) -> Bool {
        for cell in snake {
            if cell.col == col && cell.row == row{
                return true
            }
        }
        return false
    }
    
    
    //test board
    var description: String {
        var desc = ""
        
        for i in 0..<SnakeBoard.cols{
            desc += " \(i)"
        }
        
        desc += "\n"
        
        for row in 0..<SnakeBoard.rows{
            desc += "\(row)"
            for col in 0..<SnakeBoard.cols{
                if isOnSnake(col : col, row: row){
                    if snake[0].col == col && snake[0].row == row{
                        desc += " x"
                    }else{
                        desc += " o"
                    }
                }else{
                    desc += " ."
                }
            }
            desc += "\n"
        }
        return desc
    }
}
