//: Playground - noun: a place where people can play
//
//  Caculator.playground
//  Caculator
//
//  Created by Xiaoyu Liang on 3/20/17.
//  Copyright © 2017 Mac. All rights reserved.
//
import UIKit
import PlaygroundSupport

class TextFieldViewController : UIViewController, UITextFieldDelegate {
    let textView = UILabel(frame: .zero)
    var number = 0.0
    var savedNumber = 0.0
    var operation = 0
    func makeButtonWith(title: String, selector: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.black
        switch tag {
        case 0...10:
            button.backgroundColor = UIColor(white: 0.90, alpha: 1.0)
            button.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 30)
            button.layer.cornerRadius = 20
        case 100...110:
            button.backgroundColor = UIColor(red:0.91, green:0.77, blue:0.67, alpha:1.0)
            button.tintColor = .white
            button.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
            button.layer.cornerRadius = 20
        default:
            button.backgroundColor = UIColor(white: 0.90, alpha: 1.0)
            button.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 25)
            button.layer.cornerRadius = 20
        }
        button.setTitle(title, for: UIControlState())
        button.tag = tag
        return button
    }
    
    func initiateView() -> UIView {
        let hostView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 500))
        let color = UIColor(red:0.91, green:0.77, blue:0.67, alpha:1.0)
        hostView.layer.borderColor = color.cgColor
        hostView.backgroundColor = .white
        
        let zeroButton  = makeButtonWith(title: "0", selector: "", tag: 0)
        let dotButton   = makeButtonWith(title: ".", selector: "", tag: 10)
        let equalButton = makeButtonWith(title: "=", selector: "", tag: 101)
        let oneButton   = makeButtonWith(title: "1", selector: "", tag: 1)
        let twoButton   = makeButtonWith(title: "2", selector: "", tag: 2)
        let threeButton = makeButtonWith(title: "3", selector: "", tag: 3)
        let plusButton  = makeButtonWith(title: "+", selector: "", tag: 102)
        let fourButton  = makeButtonWith(title: "4", selector: "", tag: 4)
        let fiveButton  = makeButtonWith(title: "5", selector: "", tag: 5)
        let sixButton   = makeButtonWith(title: "6", selector: "", tag: 6)
        let minusButton = makeButtonWith(title: "−", selector: "", tag: 103)
        let sevenButton = makeButtonWith(title: "7", selector: "", tag: 7)
        let eightButton = makeButtonWith(title: "8", selector: "", tag: 8)
        let nineButton  = makeButtonWith(title: "9", selector: "", tag: 9)
        let timesButton = makeButtonWith(title: "×", selector: "", tag: 104)
        let clearButton   = makeButtonWith(title: "C", selector: "", tag: 100)
        let openParenthesesButton = makeButtonWith(title: "±", selector: "", tag: 106)
        let closeParenthesesButton = makeButtonWith(title: "%", selector: "", tag: 107)
        let divideButton = makeButtonWith(title: "÷", selector: "", tag: 105)
        
        
        // bind action for numbers
        oneButton.addTarget(self, action: #selector(numberButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        twoButton.addTarget(self, action: #selector(numberButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        threeButton.addTarget(self, action: #selector(numberButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        fourButton.addTarget(self, action: #selector(numberButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        fiveButton.addTarget(self, action: #selector(numberButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        sixButton.addTarget(self, action: #selector(numberButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        sevenButton.addTarget(self, action: #selector(numberButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        eightButton.addTarget(self, action: #selector(numberButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        nineButton.addTarget(self, action: #selector(numberButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        zeroButton.addTarget(self, action: #selector(numberButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        
        //
        plusButton.addTarget(self, action: #selector(operationButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        
        minusButton.addTarget(self, action: #selector(operationButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        
        equalButton.addTarget(self, action: #selector(operationButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        
        timesButton.addTarget(self, action: #selector(operationButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        
        divideButton.addTarget(self, action: #selector(operationButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        
        clearButton.addTarget(self, action: #selector(operationButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
    
        openParenthesesButton.addTarget(self, action: #selector(operationButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        closeParenthesesButton.addTarget(self, action: #selector(operationButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "0"
        textView.font = UIFont(name: "HelveticaNeue-Thin", size: 60)

        textView.textColor = UIColor.black
        textView.textAlignment = .right
        
        
        let textHostView = UIView(frame: .zero)
        textHostView.backgroundColor = UIColor.white
        textHostView.addSubview(textView)
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(textView.bottomAnchor.constraint(equalTo: textHostView.bottomAnchor, constant: -5))
        constraints.append(textView.leadingAnchor.constraint(equalTo: textHostView.leadingAnchor, constant: 5))
        constraints.append(textView.trailingAnchor.constraint(equalTo: textHostView.trailingAnchor, constant: -5))
        
        NSLayoutConstraint.activate(constraints)
        
        let firstRow = UIStackView(arrangedSubviews: [equalButton,dotButton,zeroButton ])
        firstRow.distribution = .fillProportionally
        firstRow.spacing = 0.5
        
        zeroButton.widthAnchor.constraint(equalTo: dotButton.widthAnchor, multiplier: 2.0, constant: 0.5).isActive = true
        dotButton.widthAnchor.constraint(equalTo: equalButton.widthAnchor).isActive = true
        
        let secondRow = UIStackView(arrangedSubviews: [divideButton,sevenButton, eightButton, nineButton])
        secondRow.distribution = .fillEqually
        secondRow.spacing = 0.5
        
        let thirdRow = UIStackView(arrangedSubviews: [timesButton,fourButton, fiveButton, sixButton,])
        thirdRow.distribution = .fillEqually
        thirdRow.spacing = 0.5
        
        let fourthRow = UIStackView(arrangedSubviews: [minusButton,oneButton,twoButton, threeButton])
        fourthRow.distribution = .fillEqually
        fourthRow.spacing = 0.5
        
        let fifthRow = UIStackView(arrangedSubviews: [plusButton,openParenthesesButton,closeParenthesesButton,clearButton])
        fifthRow.distribution = .fillEqually
        fifthRow.spacing = 0.5
        
        let buttonStackView = UIStackView(arrangedSubviews: [fifthRow, fourthRow, thirdRow, secondRow, firstRow])
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 0.5
        
        let hostStackView = UIStackView(arrangedSubviews: [textHostView, buttonStackView])
        hostStackView.frame = hostView.bounds
        hostStackView.axis = .vertical
        //  hostStackView.distribution = .FillEqually
        hostStackView.spacing = 0.5
        
        textHostView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        hostView.addSubview(hostStackView)
        return hostView
    }
    
    
    override func loadView() {
        let view = initiateView();
        
        self.view = view
    }
    
    
    func updateView() {
        textView.text = String(number)
    }
    
    func numberButtonClicked(sender: UIButton) {
        number = number * 10 + Double(sender.tag)
        updateView()
    }
    
    func operationButtonClicked(sender: UIButton) {
        switch sender.tag {
        case 100:// clear
            number = 0
            updateView()
        case 101:// equal
            switch operation {
            case 0:
                number = number + savedNumber
            case 1:
                number = savedNumber - number
            case 2:
                number = savedNumber * number
            case 3:
                number = savedNumber / number
            case 4:
                number = savedNumber.truncatingRemainder(dividingBy: number)
            default:
                number = 0
            }
            updateView()
        case 102:// plus
            savedNumber = number
            number = 0
            operation = 0 // plus
            updateView()
        case 103:// min
            savedNumber = number
            number = 0
            operation = 1
            updateView()
        case 104:// times
            savedNumber = number
            number = 0
            operation = 2 // plus
            updateView()
        case 105:// divide
            savedNumber = number
            number = 0
            operation = 3
            updateView()
        case 106:// + or -
            number = number * (-1)
            updateView()
        case 107:// %
            savedNumber = number
            number = 0
            operation = 4
            updateView()
        default:
            number = 0
        }
    }
}

PlaygroundPage.current.liveView = TextFieldViewController()
