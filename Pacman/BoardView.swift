//
//  BoardView.swift
//  Pacman
//
//  Created by Kairui Hu on 4/24/23.
//

import UIKit

class BoardView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let originX: CGFloat = 15   // X position of board on screen
    let originY: CGFloat = 20   // Y position of board on screen
    var cellSide: CGFloat = 20  // size of cell
    
    var shadowSnake: [SnakeCell] = []
    
    
    var shadowFruitCol: Int = Int.min
    var shadowFruitRow: Int = Int.min
    
    // main draw
    override func draw(_ rect: CGRect){
        drawGrid()
        drawSnake()
        drawFruit()
        //drawPacGrid()
    }
    
    func drawFruit(){
        UIColor.green.setFill()
        UIBezierPath(roundedRect: CGRect(x: originX + CGFloat(shadowFruitCol) * cellSide, y: originY + CGFloat(shadowFruitRow) * cellSide, width: cellSide,height: cellSide), cornerRadius: 6).fill()
    }
    
    func drawSnake(){
        UIColor.green.setFill()
        if shadowSnake.isEmpty
        {
            return
        }
        let snakeHead = shadowSnake.first!
        
        UIColor.purple.setFill()
        UIBezierPath(roundedRect: CGRect(x: originX + CGFloat(snakeHead.col) * cellSide, y: originY + CGFloat(snakeHead.row) * cellSide , width: cellSide, height: cellSide), cornerRadius: 6).fill()
        
        UIColor.brown.setFill()
        for i in 1..<shadowSnake.count{
            let cell = shadowSnake[i]
            
            UIBezierPath(roundedRect: CGRect(x: originX + CGFloat(cell.col) * cellSide, y: originY + CGFloat(cell.row) * cellSide, width: cellSide, height:cellSide), cornerRadius: 6).fill()
        }
         
    }
    
    
    func drawGrid(){
        let gridPath = UIBezierPath()
        
        for i in 0...SnakeBoard.rows{
            gridPath.move(to: CGPoint(x: originX, y:originY + CGFloat(i) * cellSide))
            gridPath.addLine(to: CGPoint(x:originX+CGFloat(SnakeBoard.cols) * cellSide,y: originY + CGFloat(i) * cellSide))
        }
        for i in 0...SnakeBoard.cols{
            gridPath.move(to: CGPoint(x: originX + CGFloat(i) * cellSide, y:originY ))
            gridPath.addLine(to: CGPoint(x:originX+CGFloat(i) * cellSide,y: originY + CGFloat(SnakeBoard.rows) * cellSide))
        }
        UIColor.lightGray.setStroke()
        gridPath.stroke()
    }
     
    
}
