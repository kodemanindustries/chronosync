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
    @IBOutlet var resolutionSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        timer.resolution = .second
    }

    private var resolution: ResolutionedLapTimer.Resolution = .second {
        didSet {
            timer.resolution = resolution
        }
    }

    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            resolution = .second
        case 1:
            resolution = .tenths
        case 2:
            resolution = .hundredths
        case 3:
            resolution = .thousandths
        default:
            fatalError("Invalid segmented index.")
        }
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
        hoursLabel.text = String(describing: (time.hours % 24))
        minutesLabel.text = String(describing: (time.minutes % 60))
        secondsLabel.text = String(describing: (time.seconds % 60))
        switch timer.resolution {
        case .second:
            hundredthsLabel.text = "0"
        case .tenths:
            hundredthsLabel.text = String(describing: (time.tenths % 10))
        case .hundredths:
            hundredthsLabel.text = String(describing: (time.hundredths % 100))
        case .thousandths:
            hundredthsLabel.text = String(describing: (time.milliseconds % 1000))
        }
    }
}

