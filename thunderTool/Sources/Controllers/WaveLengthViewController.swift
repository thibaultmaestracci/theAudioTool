//
//  WaveLengthViewController.swift
//  thunderTool
//
//  Created by thunderduck on 23/04/2021.
//

import UIKit
import theAudioToolKit

// MARK: - Private Properties & ViewDidLoad
class WaveLengthViewController: UIViewController {

    private var waveData = WaveLengthData()
    private var waveCalc: WaveLengthCalc!
    private var wav: WaveLengthCalc!
    private var speedselected: SoundSpeeds!
    private var result1: Distance!
    private var result2: Distance!
    private var result4: Distance!
    private var freqSelected: Int!

    @IBOutlet private var uilbFreq: UILabel!
    @IBOutlet private var uislFreq: UISlider!

    @IBOutlet private var lbVelocity: UILabel!
    @IBOutlet private var velocitySeg: UISegmentedControl!
    @IBOutlet private var distanceSeg: UISegmentedControl!

    @IBOutlet private var lbWave: UILabel!
    @IBOutlet private var lbWaveUnit: UILabel!

    @IBOutlet private var btnInfo: UIBarButtonItem!

    override func viewDidLoad() {
        setupUI()
        refreshUI()
    }
}

// MARK: - Private extension for UI methods
private extension WaveLengthViewController {

    func setupUI() {
        uislFreq.minimumValue = 0
        uislFreq.maximumValue = Float(waveData.freqValues.count-1)
        uislFreq.value = Float(waveData.freqDftSelected)

        velocitySeg.removeAllSegments()
        for value in SoundSpeeds.allCases {
            velocitySeg.insertSegment(withTitle: value.name, at: value.rawValue, animated: false)
        }
        velocitySeg.selectedSegmentIndex = SoundSpeeds.defaultIndexValue
    }

    func refreshUI() {

        speedselected = SoundSpeeds.init(rawValue: velocitySeg.selectedSegmentIndex)!
        let speed = Double(speedselected.value)
        lbVelocity.text = ("\(speed) m/s")

        freqSelected = waveData.freqValues[Int(uislFreq.value)]
        uilbFreq.text = "\(waveData.freqText[Int(uislFreq.value)])"
        var displayUnit = DistanceUnit(rawValue: 0)!
        switch distanceSeg.selectedSegmentIndex {
        case 0 : displayUnit = .metre
        case 1 : displayUnit = .centimetre
        case 2 : displayUnit = .millimetre
        default : displayUnit = .centimetre
        }

        wav = WaveLengthCalc(freqHz: freqSelected, soundspeed: speedselected)

        result1 = wav.getDistance(for: .fullWave, unit: displayUnit)
        lbWave.text = result1.strData
        lbWaveUnit.text = result1.strUnit

        result2 = wav.getDistance(for: .halfWave, unit: displayUnit)
        result4 = wav.getDistance(for: .quarWave, unit: displayUnit)

    }
}

// MARK: - Extension for user actions
private extension WaveLengthViewController {

    @IBAction func uisl_freq_changed(_ sender: Any) {
        refreshUI()
    }

    @IBAction func ui_speed_change(_ sender: Any) {
        refreshUI()
    }

    @IBAction func infoClick(_ sender: Any) {
        performSegue(withIdentifier: "waveInfo", sender: self)
    }
}

// MARK: - Extension for segue
extension WaveLengthViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // swiftlint:disable force_cast
        if segue.identifier == "waveInfo"{
            let waveInfoVC = segue.destination as! WaveInfoViewController
            waveInfoVC.freq = freqSelected
            waveInfoVC.result1 = result1
            waveInfoVC.result2 = result2
            waveInfoVC.result4 = result4

            waveInfoVC.delay1 = Delay(distance: result1, soundspeed: speedselected)
            waveInfoVC.delay2 = Delay(distance: result2, soundspeed: speedselected)
            waveInfoVC.delay4 = Delay(distance: result4, soundspeed: speedselected)
        }
    }
}
