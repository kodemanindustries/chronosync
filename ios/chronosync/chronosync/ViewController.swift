//
//  ViewController.swift
//  ChronoSync
//
//  Created by Cody Vandermyn on 1/1/19.
//  Copyright © 2019 Kodeman Industries. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var hoursLabel: UILabel!
    @IBOutlet var minutesLabel: UILabel!
    @IBOutlet var secondsLabel: UILabel!
    @IBOutlet var hundredthsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let displayLink = CADisplayLink(target: self, selector: #selector(step))
        displayLink.add(to: .current, forMode: .default)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer.startNow()
    }

    private var timer: ResolutionedLapTimer!
    func inject(timer: ResolutionedLapTimer) {
        self.timer = timer
    }

    @objc private func step(_ displayLink: CADisplayLink) {
        let time = timer.tickingTime
        print(String(describing: time))
        hoursLabel.text = String(describing: (time.hours % 24))
        minutesLabel.text = String(describing: (time.minutes % 60))
        secondsLabel.text = String(describing: (time.seconds % 60))
        hundredthsLabel.text = String(describing: (time.milliseconds % 1000))
    }
}

