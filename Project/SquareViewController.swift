//
//  SquareViewController.swift
//  Project
//
//  by Patricia Anjelica Lavadia.
//  by Francis Fuentebella
//  Copyright © 2020 Group 6. All rights reserved.
//

import UIKit

class SquareViewController: UIViewController {
    var scoreString:String = ""//score 
    var timeLeftString:String = ""//time left
    var yAxis = 0, xAxis = 0; //initialize y and x axis to manipulate user controls
    var score = 0; // score counter
    
    @IBOutlet weak var countdownTimer: UILabel!//label for counter
    
    @IBOutlet weak var imageView: UIImageView! //display the give shapes
    
    @IBOutlet weak var controls: UIImageView! // display player shape
    
    @IBOutlet weak var scoring: UILabel! //label for score
    
    @IBOutlet weak var scoreOutput: UILabel! //label for score if game is over
    
    @IBOutlet weak var gameover: UIImageView! //display game over if time is up
    
    var timer = Timer() // start timer
    var time = 40 // initilize timer to 40 sec

    @objc func action(){
		//set the time to the timer label
        countdownTimer.text = String(time)
        
        if(time <= 0){ //if time is up or 0
            gameover.isHidden = false //display the game over imageview
            controls.isHidden = true //hide the controls to avoid clicking
            imageView.isHidden = true //hide the black shape
            scoreOutput.text = scoring.text! + " Points" //display the final score in the game over image view
            timer.invalidate(); //stop the time
            
        }//if time is still not 0. decrement time by 1 sec
        else{
              time -= 1
            
        }
    }
    //if player press up button
    @IBAction func up(_ sender: Any) {
        yAxis = yAxis - 2;//increment the y axis up
        moveRectangle(yAx: yAxis, xAx: self.xAxis) //call the function
        drawRectangle(yAx: self.yAxis, xAx: self.xAxis)//call the draw rect func and check if it fits with the player
    }
	//if player press left button
    @IBAction func left(_ sender: Any) {
        xAxis = xAxis - 2 ; //move the axis to left
        moveRectangle(yAx: self.yAxis, xAx: xAxis)//call the func
        drawRectangle(yAx: self.yAxis, xAx: self.xAxis)//call the draw rect func to check its axis
    }
    //if player press right button
    @IBAction func right(_ sender: Any) {
            xAxis+=1 ; //move axis to right
			moveRectangle(yAx:self.yAxis, xAx: xAxis)//call the func
            drawRectangle(yAx: self.yAxis, xAx: self.xAxis)//call the draw rect func to check its axis
    }
    //if player press down button    
    @IBAction func down(_ sender: Any) {
        yAxis+=1//move the y axis down
        moveRectangle(yAx: yAxis, xAx: self.xAxis)//call the func
        drawRectangle(yAx: self.yAxis, xAx: self.xAxis)//call the draw rect func to check its axis
    }
	//player axis position function
    func moveRectangle(yAx: Int, xAx: Int) {
		//render the shape, set size, width and position the axis according to the button press
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 80, height: 80))
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: xAx, y: yAx, width: 70, height: 70)
    
            //set the color, stroke or border and width
            ctx.cgContext.setFillColor(UIColor.green.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.green.cgColor)
            ctx.cgContext.setLineWidth(5)
    
            //draw the rectangle
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
    
        controls.image = img
        
    }
    
    func drawRectangle(yAx: Int, xAx: Int) {
		//set the position of the shape
        let xCoordinate = 5;
        let yCoordinate = 5;
		//render the shape, set size, width and position the axis the was set
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 80, height: 80))
    
		//render the player shape set width, height and axis
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: xCoordinate, y: yCoordinate, width: 70, height: 70)
    
            //set color , stroke and width
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(5)
    
            //draw the player shape
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
    
		//display it in the image view
        imageView.image = img
        
		//check if the axis of player and position of the black shape is equals
        if(xCoordinate == xAx && yCoordinate == yAx){
            score = Int(scoring.text!)! + 1; //increment score 
            scoring.text = String (score);//cast score to string and display in the label
            performSegue(withIdentifier: "CircleView", sender: self)//perform the segue to next shape
    }
    }
	//pass the score and time left to next shape controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var passData = segue.destination as! CircleViewController

        passData.scoreString = scoring.text!
        passData.timeLeftString = countdownTimer.text!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
		//if score is not zero *this game is endless after the last shape it will go back to this shape
        if(scoreString == "3" || scoreString == "6")
        {
            scoring.text! = scoreString//set score to whatever the score is from the last shape
            countdownTimer.text! = timeLeftString// set the remaining time
            time = Int(countdownTimer.text!)!;//store the time remaining in time and cast to int
        }
		//schedule the timer
        timer = Timer.scheduledTimer(timeInterval:1, target:self, selector: #selector(SquareViewController.action), userInfo: nil, repeats:true)
		//display shape when the game loads
        drawRectangle(yAx:0,xAx:0);
    }

}
