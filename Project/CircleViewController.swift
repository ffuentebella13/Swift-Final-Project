//
//  CircleViewController.swift
//  Project
//
//  Created by Patricia Anjelica Lavadia
//  		   Francis Fuentebella
//  Copyright © 2020 Group 6. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController {
    var scoreString:String = "" //score
    var timeLeftString:String = "" //timeleft
    var yAxis = 0, xAxis = 0; //player axis initialize
    var score = 0;//score counter
    var time = 0;//time counter
    var timer = Timer()//start timer
    @IBOutlet weak var countdownTimer: UILabel!//timer label
    @IBOutlet weak var scoring: UILabel!//score label
    @IBOutlet weak var imageView: UIImageView!//display the black shape
    @IBOutlet weak var controls: UIImageView!//display the players shape
    @IBOutlet weak var scoreOutput: UILabel//displays the score if game is over or time is up
    @IBOutlet weak var gameover: UIImageView!//display if time is up
    
    @objc func action(){
        time = Int(countdownTimer.text!)!;//display time in the time label
        time-=1//decrement time by 1 sec
        countdownTimer.text = String(time)//set the time to string to display in the label
        if(time <= 0){ //if time is up
            gameover.isHidden = false //display the game over imageview
            controls.isHidden = true //hide buttons for player
            imageView.isHidden = true// hide the black shape
            scoreOutput.text = scoring.text! + " Points"//display the final score
            timer.invalidate();//stop the time
            
        }
    }
    
	//it button press up
    @IBAction func up(_ sender: Any) {
        yAxis = yAxis - 2; //move the y axis up
        moveCircle(yAx: yAxis, xAx: self.xAxis)//call the move func
        drawCircle(yAx: self.yAxis, xAx: self.xAxis)//call the draw circle to check positions
    }
	//it button press left
    @IBAction func left(_ sender: Any) {
        xAxis = xAxis - 2 ;//move the x axis left
        moveCircle(yAx: self.yAxis, xAx: xAxis)//call the move func
        drawCircle(yAx: self.yAxis, xAx: self.xAxis)//call the draw circle to check positions
    }
    //it button press right
    @IBAction func right(_ sender: Any) {
        xAxis+=1 ;//move the axis to right
        moveCircle(yAx: self.yAxis, xAx: xAxis)//call the move func
        drawCircle(yAx: self.yAxis, xAx: self.xAxis)//call the draw circle to check position
    }
    //if down button is press
    @IBAction func down(_ sender: Any) {
        yAxis+=1//move the y axis down
        moveCircle(yAx: yAxis, xAx: self.xAxis)//call the move func
        drawCircle(yAx: self.yAxis, xAx: self.xAxis)//call the drawa circle to check position
    }
    //func to move the circle
    func moveCircle(yAx: Int, xAx: Int) {
		//render the image width, height and axis position according to button pressed
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 80, height: 80))
    
        let img = renderer.image { ctx in
            let rect = CGRect(x: xAx, y: yAx, width: 70, height: 70)
			//setting the color, stroke and width
			ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
            ctx.cgContext.setLineWidth(5)
    
            ctx.cgContext.addEllipse(in: rect)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
    
		//display the current position in the image view
        controls.image = img
    }
    //draw the black shape
    func drawCircle(yAx: Int, xAx: Int) {
      
		//render the image set width, height and the coordinates that was set
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 80, height: 80))
        let xCoordinate = 5;
        let yCoordinate = 5;
        let img = renderer.image { ctx in
            let rect = CGRect(x: xCoordinate, y:yCoordinate, width: 70, height: 70)
			//setting the color, stroke and width
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(5)
    
            ctx.cgContext.addEllipse(in: rect)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
    
		//display the black shape in the image view
        imageView.image = img
        
		//if the player shape is properly position to the draw shape
        if(xCoordinate == xAx && yCoordinate == yAx){
            score = Int(scoring.text!)! + 1;//increment score by 1
            scoring.text = String (score);//cast and display the score in the label
            performSegue(withIdentifier: "TriangleController", sender: self)//perform the segue to triangle
        }
    }
	//pass the score and time remaining to the next shape
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         var passData = segue.destination as! TriangleViewController

         passData.scoreString = scoring.text!
         passData.timeLeftString = countdownTimer.text!

     }
    override func viewDidLoad() {
        super.viewDidLoad()
         scoring.text = scoreString //set the score that was pass from prev shape
         countdownTimer.text = timeLeftString // set theh time remaining from the prev shape
		 
		 //activate timer
         timer = Timer.scheduledTimer(timeInterval:1, target:self, selector: #selector(CircleViewController.action), userInfo: nil, repeats:true)
		 //display the black shape when the this page loads
         drawCircle(yAx:0,xAx:0);
    }
    
}
