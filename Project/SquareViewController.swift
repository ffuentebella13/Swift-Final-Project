//
//  SquareViewController.swift
//  Project
//
//  Created by Patricia Anjelica Lavadia on 2020-07-09.
//  Copyright © 2020 Patricia Anjelica Lavadia. All rights reserved.
//

import UIKit

class SquareViewController: UIViewController {
    
    var yAxis = 0, xAxis = 0;
    var score = 0;
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var controls: UIImageView!
    
    @IBOutlet weak var scoring: UILabel!
    
    @IBAction func up(_ sender: Any) {
        yAxis = yAxis - 2;
        moveRectangle(yAx: yAxis, xAx: self.xAxis)
        drawRectangle(yAx: self.yAxis, xAx: self.xAxis)
    }

    @IBAction func left(_ sender: Any) {
        xAxis = xAxis - 2 ;
        moveRectangle(yAx: self.yAxis, xAx: xAxis)
        drawRectangle(yAx: self.yAxis, xAx: self.xAxis)
    }
    
    @IBAction func right(_ sender: Any) {
               xAxis+=1 ; moveRectangle(yAx:self.yAxis, xAx: xAxis)
            drawRectangle(yAx: self.yAxis, xAx: self.xAxis)
    }
    
    @IBAction func down(_ sender: Any) {
        yAxis+=1
        moveRectangle(yAx: yAxis, xAx: self.xAxis)
        drawRectangle(yAx: self.yAxis, xAx: self.xAxis)
    }
    func moveRectangle(yAx: Int, xAx: Int) {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 80, height: 80))
    
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: xAx, y: yAx, width: 70, height: 70)
    
            // 4
            ctx.cgContext.setFillColor(UIColor.green.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.green.cgColor)
            ctx.cgContext.setLineWidth(5)
    
            // 5
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
    
        controls.image = img
        
    }
    
    func drawRectangle(yAx: Int, xAx: Int) {
        let xCoordinate = 5;
        let yCoordinate = 5;
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 80, height: 80))
    
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: xCoordinate, y: yCoordinate, width: 70, height: 70)
    
            // 4
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(5)
    
            // 5
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
    
        imageView.image = img
        
        if(xCoordinate == xAx && yCoordinate == yAx){
            score = Int(scoring.text!)! + 1;
            scoring.text = String (score);
            performSegue(withIdentifier: "CircleView", sender: self)
    }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var passData = segue.destination as! CircleViewController

        passData.scoreString = scoring.text!

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle(yAx:0,xAx:0);
                // Do any additional setup after loading the view.
    }

}
