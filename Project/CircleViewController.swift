//
//  CircleViewController.swift
//  Project
//
//  Created by Patricia Anjelica Lavadia on 2020-07-09.
//  Copyright © 2020 Patricia Anjelica Lavadia. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController {
    var scoreString:String = ""
    var timeLeftString:String = ""
    var yAxis = 0, xAxis = 0;
    var score = 0;
    var time = 0;
    var timer = Timer()
    @IBOutlet weak var countdownTimer: UILabel!
    @IBOutlet weak var scoring: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var controls: UIImageView!
    @IBOutlet weak var scoreOutput: UILabel!
    @IBOutlet weak var gameover: UIImageView!
    
    @objc func action(){
        time = Int(countdownTimer.text!)!;
        time-=1
        countdownTimer.text = String(time)
        if(time <= 0){
            gameover.isHidden = false
            controls.isHidden = true
            imageView.isHidden = true
            scoreOutput.text = scoring.text! + " Points"
            timer.invalidate();
            
        }
    }
    

    @IBAction func up(_ sender: Any) {
        yAxis = yAxis - 2;
        moveCircle(yAx: yAxis, xAx: self.xAxis)
        drawCircle(yAx: self.yAxis, xAx: self.xAxis)
    }

    @IBAction func left(_ sender: Any) {
        xAxis = xAxis - 2 ;
        moveCircle(yAx: self.yAxis, xAx: xAxis)
        drawCircle(yAx: self.yAxis, xAx: self.xAxis)
    }
    
    @IBAction func right(_ sender: Any) {
        xAxis+=1 ;
        moveCircle(yAx: self.yAxis, xAx: xAxis)
        drawCircle(yAx: self.yAxis, xAx: self.xAxis)
    }
    
    @IBAction func down(_ sender: Any) {
        yAxis+=1
        moveCircle(yAx: yAxis, xAx: self.xAxis)
        drawCircle(yAx: self.yAxis, xAx: self.xAxis)
    }
    
    func moveCircle(yAx: Int, xAx: Int) {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 80, height: 80))
    
        let img = renderer.image { ctx in
            let rect = CGRect(x: xAx, y: yAx, width: 70, height: 70)
    ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
            ctx.cgContext.setLineWidth(5)
    
            ctx.cgContext.addEllipse(in: rect)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
    
        controls.image = img
    }
    
    func drawCircle(yAx: Int, xAx: Int) {
      
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 80, height: 80))
        let xCoordinate = 5;
        let yCoordinate = 5;
        let img = renderer.image { ctx in
            let rect = CGRect(x: xCoordinate, y:yCoordinate, width: 70, height: 70)
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(5)
    
            ctx.cgContext.addEllipse(in: rect)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
    
        imageView.image = img
        
        if(xCoordinate == xAx && yCoordinate == yAx){
            score = Int(scoring.text!)! + 1;
            scoring.text = String (score);
            performSegue(withIdentifier: "TriangleController", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         var passData = segue.destination as! TriangleViewController

         passData.scoreString = scoring.text!
         passData.timeLeftString = countdownTimer.text!

     }
    override func viewDidLoad() {
        super.viewDidLoad()
         scoring.text = scoreString
         countdownTimer.text = timeLeftString

         timer = Timer.scheduledTimer(timeInterval:1, target:self, selector: #selector(CircleViewController.action), userInfo: nil, repeats:true)
         drawCircle(yAx:0,xAx:0);
        // Do any additional setup after loading the view.
    }
    
}
