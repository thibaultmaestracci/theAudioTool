//
//  DelayViewController.swift
//  thunderTool
//
//  Created by thunderduck on 10/05/2021.
//  v0.7
//

import UIKit
import Foundation
import theAudioToolKit

// MARK: - Private Properties & ViewDidLoad
class DelayViewController: UIViewController {

    @IBOutlet private var delayTitle: UILabel!
    @IBOutlet private var delayResult: UILabel!

    @IBOutlet private var spkAslider: UISlider!
    @IBOutlet private var spkAdst: UILabel!

    @IBOutlet private var spkBslider: UISlider!
    @IBOutlet private var spkBdst: UILabel!
    @IBOutlet private var sgcSoundSpeed: UISegmentedControl!
    @IBOutlet private var lbVelocity: UILabel!

    private var deltaDistM = Double()
    private var delay: Delay!

    let locStrDelay = NSLocalizedString("DELAY", comment: "DELAY")
    let locStrDelayA = NSLocalizedString("DELAY FOR A", comment: "DELAY FOR A")
    let locStrDelayB = NSLocalizedString("DELAY FOR B", comment: "DELAY FOR B")

    override func viewDidLoad() {
        super.viewDidLoad()

        sgcSoundSpeed.removeAllSegments()
        for value in SoundSpeeds.allCases {
            sgcSoundSpeed.insertSegment(withTitle: value.name, at: value.rawValue, animated: false)
        }
        sgcSoundSpeed.selectedSegmentIndex = SoundSpeeds.defaultIndexValue

        refreshUI()
    }
}

// MARK: - Private extension for UI methods
private extension DelayViewController {

    func refreshUI() {

        // Get and set data for slider and distance values
        let valueA = Double(spkAslider.value)
        let valueB = Double(spkBslider.value)
        let distA = Double(round(valueA*10 / 100)/10)
        let distB = Double(round(valueB*10 / 100)/10)
        spkAdst.text = String(distA) + " m"
        spkBdst.text = String(distB) + " m"

        // Get and set data for speed values
        let speedselected = SoundSpeeds.init(rawValue: sgcSoundSpeed.selectedSegmentIndex)!
        let speed = Double(speedselected.value)
        lbVelocity.text = ("\(speed) m/s")

        // calc delta and set result
        deltaDistM = round((distA - distB)*10)/10
        setDelayTitle()
        delay = Delay(distance: Distance(data: deltaDistM, unit: .metre), soundspeed: speedselected)
        delayResult.text = String(delay.delayMs)
    }

    func setDelayTitle() {
        if deltaDistM < 0 {
            delayTitle.text = locStrDelayA + " (\(-deltaDistM)m) :"
            deltaDistM = -deltaDistM
        } else if deltaDistM > 0 {
            delayTitle.text = locStrDelayB + " (\(deltaDistM)m) :"
        } else if deltaDistM == 0 {
            delayTitle.text = locStrDelay
        }
    }
}

// MARK: - Extension for user actions
private extension DelayViewController {
    @IBAction func uiStateChange(_ sender: Any) {
        refreshUI()
    }}
