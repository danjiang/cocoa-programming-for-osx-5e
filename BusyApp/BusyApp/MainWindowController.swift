//
//  MainWindowController.swift
//  BusyApp
//
//  Created by 但 江 on 15/10/3.
//  Copyright © 2015年 Dan Thought Studio. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    private let SliderGoesUp = "Slider goes up!"
    private let SliderGoesDown = "Slider goes down!"
    private let UncheckMe = "Uncheck me"
    private let CheckMe = "Check me"
    private let SecretMessage = "Busy boards are fun!"
    
    var sliderOldValue = 0
    
    @IBOutlet weak var slider: NSSlider!
    @IBOutlet weak var sliderDirectionTextField: NSTextField!
    @IBOutlet weak var showSliderTickMarksRadio: NSButton!
    @IBOutlet weak var hideSliderTickMarkRadio: NSButton!
    @IBOutlet weak var checkbox: NSButton!
    @IBOutlet weak var secureTextField: NSSecureTextField!
    @IBOutlet weak var textField: NSTextField!
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        initial()
    }

    @IBAction func slide(sender: NSSlider) {
        if sender.integerValue > sliderOldValue {
            self.sliderDirectionTextField.stringValue = SliderGoesUp
        } else {
            self.sliderDirectionTextField.stringValue = SliderGoesDown
        }
        sliderOldValue = sender.integerValue
    }
    
    @IBAction func showSliderTickMarks(sender: NSButton) {
        slider.numberOfTickMarks = 10
        hideSliderTickMarkRadio.state = NSOffState
    }
    
    @IBAction func hideSliderTickMarks(sender: NSButton) {
        slider.numberOfTickMarks = 0
        showSliderTickMarksRadio.state = NSOffState
    }
    
    @IBAction func check(sender: NSButton) {
        if sender.state == NSOnState {
            sender.title = UncheckMe
        } else {
            sender.title = CheckMe
        }
    }
    
    @IBAction func reveal(sender: NSButton) {
        textField.stringValue = secureTextField.stringValue
    }
    
    @IBAction func reset(sender: NSButton) {
        initial()
    }
    
    private func initial() {
        slider.integerValue = 0
        sliderDirectionTextField.stringValue = SliderGoesUp
        slider.numberOfTickMarks = 10
        showSliderTickMarksRadio.state = NSOnState
        hideSliderTickMarkRadio.state = NSOffState
        checkbox.state = NSOnState
        checkbox.title = UncheckMe
        secureTextField.stringValue = SecretMessage
        textField.stringValue = ""
    }

}
