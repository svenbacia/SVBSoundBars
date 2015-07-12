//
//  ViewController.swift
//  SoundBars
//
//  Created by Sven Bacia on 10/07/15.
//  Copyright © 2015 Sven Bacia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var soundbars: SVBSoundBars!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func animate() {
    soundbars.animating = !soundbars.animating
  }

}

