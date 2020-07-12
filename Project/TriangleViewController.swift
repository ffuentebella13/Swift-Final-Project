//
//  TriangleViewController.swift
//  Project
//
//  Created by Patricia Anjelica Lavadia on 2020-07-09.
//  Copyright © 2020 Patricia Anjelica Lavadia. All rights reserved.
//

import UIKit

class TriangleViewController: UIViewController {
    var scoreString:String = ""
    var yAxis = 0, xAxis = 0;
    var score = 0;
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var controls: UIImageView!
    
    @IBOutlet weak var scoring: UILabel!
    
    @IBAction func up(_ sender: Any) {
        yAxis = yAxis - 1;//up
        xAxis = xAxis - 2;
        moveTriangle(yAx: yAxis, xAx: xAxis)
        drawTriangle(yAx: self.yAxis, xAx: self.xAxis)
    }

    @IBAction func left(_ sender: Any) {
        xAxis = xAxis - 1;
        yAxis = yAxis + 2;
        moveTriangle(yAx: yAxis, xAx: xAxis)
        drawTriangle(yAx: self.yAxis, xAx: self.xAxis)
    }
    
    @IBAction func right(_ sender: Any) {
        xAxis = xAxis + 1;
        yAxis = yAxis - 2;
        moveTriangle(yAx: yAxis, xAx: xAxis)
        drawTriangle(yAx: self.yAxis, xAx: self.xAxis)
    }
    
    @IBAction func down(_ sender: Any) {
        yAxis = yAxis + 1;//down
        xAxis = xAxis + 2;
        moveTriangle(yAx: yAxis, xAx: xAxis)
        drawTriangle(yAx: self.yAxis, xAx: self.xAxis)
    }
    func moveTriangle(yAx: Int, xAx: Int) {

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 80, height: 80))
        
        let img = renderer.image { ctx in
        let rectangle = CGRect(x: xAx, y: yAx, width: 30, height: 30)
    
        ctx.cgContext.setFillColor(UIColor.purple.cgColor)
        ctx.cgContext.setStrokeColor(UIColor.purple.cgColor)
        ctx.cgContext.setLineWidth(5)
        ctx.cgContext.translateBy(x: 0, y: 0)
        ctx.cgContext.rotate(by: 45)
        ctx.cgContext.addRect(rectangle)
        ctx.cgContext.drawPath(using: .fillStroke)
        }
        controls.image = img

    }
    func drawTriangle(yAx: Int, xAx: Int) {
            let xCoordinate = 30;
            let yCoordinate = -30;
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 80, height: 80))
        
            let img = renderer.image { ctx in
                let rectangle = CGRect(x: xCoordinate, y: yCoordinate, width: 30, height: 30)
        
                // 4
                ctx.cgContext.setFillColor(UIColor.black.cgColor)
                ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
                ctx.cgContext.setLineWidth(5)
        
                // 5
                ctx.cgContext.translateBy(x: 0, y: 0)
                ctx.cgContext.rotate(by: 45)
                ctx.cgContext.addRect(rectangle)
                ctx.cgContext.drawPath(using: .fillStroke)
        }
            imageView.image = img
            
            if(xCoordinate == xAx && yCoordinate == yAx){
                score = Int(scoring.text!)! + 1;
                scoring.text = String (score);
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scoring.text = scoreString
        drawTriangle(yAx:0,xAx:0);
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
