//
//  WaveInfoViewController.swift
//  thunderTool
//
//  Created by thunderduck on 16/06/2021.
//

import UIKit
import theAudioToolKit

// MARK: - Properties & ViewDidLoad
class WaveInfoViewController: UIViewController {

    @IBOutlet private var waveLengthInfoTitle: UILabel!

    @IBOutlet private var freqResultLabel: UILabel!

    @IBOutlet private var resultFullDist: UILabel!
    @IBOutlet private var resultHalfDist: UILabel!
    @IBOutlet private var resultQuarterDist: UILabel!

    @IBOutlet private var resultFullDelay: UILabel!
    @IBOutlet private var resultHalfDelay: UILabel!
    @IBOutlet private var resultQuarterDelay: UILabel!

    @IBOutlet private var resultNoteDwnLabel: UILabel!
    @IBOutlet private var resultNoteDwnLabelFreq: UILabel!
    @IBOutlet private var resultNoteUpLabel: UILabel!
    @IBOutlet private var resultNoteUpLabelFreq: UILabel!

    var freq = Int()

    var result1: Distance!
    var result2: Distance!
    var result4: Distance!

    var delay1: Delay!
    var delay2: Delay!
    var delay4: Delay!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
    }
}

// MARK: - Private extension for UI methods
private extension WaveInfoViewController {
    func setupLabel() {
        freqResultLabel.text = ("\(freq) Hz")

        resultFullDist.text = ("λ = \(result1.strData) \(result1.strUnit)")
        resultHalfDist.text = ("λ/2 = \(result2.strData) \(result2.strUnit)")
        resultQuarterDist.text = ("λ/4 = \(result4.strData) \(result4.strUnit)")

        resultFullDelay.text = ("\(delay1.delayMs) ms")
        resultHalfDelay.text = ("\(delay2.delayMs) ms")
        resultQuarterDelay.text = ("\(delay4.delayMs) ms")

        let root = BasicRootNotes(tuning: .hz440)
        let resultNotes = root.findNote(from: freq)

        if resultNotes.count == 2 {
            resultNoteDwnLabel.text = resultNotes[0].name + " (" + String(resultNotes[0].octave.rawValue)+")"
            resultNoteDwnLabelFreq.text = String(resultNotes[0].frequencyHz) + " Hz"
            resultNoteUpLabel.text = resultNotes[1].name + " (" + String(resultNotes[1].octave.rawValue)+")"
            resultNoteUpLabelFreq.text = String(resultNotes[1].frequencyHz) + " Hz"
        }
    }
}
