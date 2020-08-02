//
//  TriangleViewController.swift
//  Project
//
//  Created by Patricia Anjelica Lavadia
//  		   Francis Fuentebella
//  Copyright © 2020 Group 6. All rights reserved.
//

import UIKit

class TriangleViewController: UIViewController {
    var scoreString:String = ""//score
    var timeLeftString:String = ""//time left
    var yAxis = 0, xAxis = 0; //initialize the y and x axis
    var score = 0; //initialize score
    var time = 0;// initialize the score
    var timer = Timer()//start the time

    @IBOutlet weak var countdownTimer: UILabel!//label for timer
    @IBOutlet weak var imageView: UIImageView!//display the black shape
    @IBOutlet weak var controls: UIImageView!//display the player's shape
    @IBOutlet weak var scoring: UILabel!//label for the scoring
    @IBOutlet weak var gameover: UIImageView!//display game over image view if time is up
    @IBOutlet weak var scoreOutput: UILabel!//display the final score if time is up
  
    @objc func action(){
        time = Int(countdownTimer.text!)!;//set the time from the time remaining
        time-=1//decrement time by 1 sec
        countdownTimer.text = String(time)//set the time remaining in the timer label
        if(time <= 0){ //if time is 0 or less
            gameover.isHidden = false //display the game over image view
            controls.isHidden = true //hide the player's shape
            imageView.isHidden = true //hide the black shape
            scoreOutput.text = scoring.text! + " Points"//display the final score
            timer.invalidate();//stop the time
            
        }
    }
	//it button press up
    @IBAction func up(_ sender: Any) {
		//move the axis up
        yAxis = yAxis - 1;
        xAxis = xAxis - 2;
        moveTriangle(yAx: yAxis, xAx: xAxis)//call the move shape func
        drawTriangle(yAx: self.yAxis, xAx: self.xAxis)//call the draw shape func
    }
	//it button press left
    @IBAction func left(_ sender: Any) {
		//move the axis left
        xAxis = xAxis - 1;
        yAxis = yAxis + 2;
        moveTriangle(yAx: yAxis, xAx: xAxis)//call the move shape func
        drawTriangle(yAx: self.yAxis, xAx: self.xAxis)//call the draw shape func
    }
    //it button press right
    @IBAction func right(_ sender: Any) {
	//move the shape right
        xAxis = xAxis + 1;
        yAxis = yAxis - 2;
        moveTriangle(yAx: yAxis, xAx: xAxis)//call the move shape func
        drawTriangle(yAx: self.yAxis, xAx: self.xAxis)//call the draw shape func
    }
    //it button press down
    @IBAction func down(_ sender: Any) {
		//move the shape down
        yAxis = yAxis + 1;
        xAxis = xAxis + 2;
        moveTriangle(yAx: yAxis, xAx: xAxis)//call the move shape func
        drawTriangle(yAx: self.yAxis, xAx: self.xAxis)//call the draw shape func
    }
	//move the player's shape
    func moveTriangle(yAx: Int, xAx: Int) {
		//render and set the size width and height alson set the possition according to the button that was pressed
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 80, height: 80))
        
        let img = renderer.image { ctx in
        let rectangle = CGRect(x: xAx, y: yAx, width: 30, height: 30)
    
		//set the shape color, stroke and width
        ctx.cgContext.setFillColor(UIColor.purple.cgColor)
        ctx.cgContext.setStrokeColor(UIColor.purple.cgColor)
        ctx.cgContext.setLineWidth(5)
		//rotate the shape to make a diamond
        ctx.cgContext.translateBy(x: 0, y: 0)
        ctx.cgContext.rotate(by: 45)
        ctx.cgContext.addRect(rectangle)
        ctx.cgContext.drawPath(using: .fillStroke)
        }
		//display the image in the imageview
        controls.image = img

    }
	//draw the black shape
    func drawTriangle(yAx: Int, xAx: Int) {
			//set the position of the shape
            let xCoordinate = 30;
            let yCoordinate = -30;
			//render and set the size width and height alson set the position according to the axis that was set on top
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 80, height: 80))
        
            let img = renderer.image { ctx in
                let rectangle = CGRect(x: xCoordinate, y: yCoordinate, width: 30, height: 30)
        
				//set the shape color, stroke and width
                ctx.cgContext.setFillColor(UIColor.black.cgColor)
                ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
                ctx.cgContext.setLineWidth(5)
        
				//rotate the shape to make a diamond
                ctx.cgContext.translateBy(x: 0, y: 0)
                ctx.cgContext.rotate(by: 45)
                ctx.cgContext.addRect(rectangle)
                ctx.cgContext.drawPath(using: .fillStroke)
        }
				//display the shape in the image view
				imageView.image = img
            
				//if the draw shape and player's shape is align 
				if(xCoordinate == xAx && yCoordinate == yAx){
                score = Int(scoring.text!)! + 1;//increment score by 1
                scoring.text = String (score); //display score in the label
                performSegue(withIdentifier: "SquareController", sender: self)//perform segue back to square controller
        }
    }
	//pass the score and time left to the square controller 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         var passData = segue.destination as! SquareViewController

         passData.scoreString = scoring.text!
         passData.timeLeftString = countdownTimer.text!

     }
    override func viewDidLoad() {
        super.viewDidLoad()
        scoring.text = scoreString //set the score that was pass from circle controller
        countdownTimer.text = timeLeftString //set the time left from the circle controller
		//activate the timer
        timer = Timer.scheduledTimer(timeInterval:1, target:self, selector: #selector(CircleViewController.action), userInfo: nil, repeats:true)
		//display the black shape during the onload of the page
        drawTriangle(yAx:0,xAx:0);
    }
}
