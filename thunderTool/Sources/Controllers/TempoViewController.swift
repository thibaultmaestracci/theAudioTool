//
//  TempoViewController.swift
//  thunderTool
//
//  Created by thunderduck on 11/05/2021.
//

import UIKit
import SwiftUI
import theAudioToolKit

// MARK: - Properties & ViewDidLoad
class TempoViewController: UIViewController {

    @IBOutlet private var lbBpmResult: UILabel!
    @IBOutlet private var tap: UIButton!
    @IBOutlet private var note1: UILabel!
    @IBOutlet private var note2: UILabel!
    @IBOutlet private var note4: UILabel!
    @IBOutlet private var note8: UILabel!
    @IBOutlet private var lbModeInfo: UILabel!

    @IBOutlet private var precisionMode: UISegmentedControl!

    let txtModeInfoAverage = NSLocalizedString("Average mode is the more accurate ( uses 21 values )", comment: "AVERAGE MODE DESC")
    let txtModeInfoInstant = NSLocalizedString("Instant mode is the quickest ( uses 4 values )", comment: "INSTANT MODE DESC")

    private let locStrNote1 = NSLocalizedString("1/1 Note", comment: "1/1 Note")
    private let locStrNote2 = NSLocalizedString("1/2 Note", comment: "1/2 Note")
    private let locStrNote4 = NSLocalizedString("1/4 Note", comment: "1/4 Note")
    private let locStrNote8 = NSLocalizedString("1/8 Note", comment: "1/5 Note")

    private var tempo = Tempo()

    override func viewDidLoad() {
        super.viewDidLoad()
        tap.layer.cornerRadius = 5.0
        tap.layer.borderColor = UIColor(named: "secondarySystemFill")!.cgColor
        tap.layer.borderWidth = 2.0
        changeCalcMode_AND_RESET_FromUI()
        refreshUI()

    }
}

// MARK: - Private extension for UI methods
private extension TempoViewController {

    func refreshUI() {
        lbBpmResult.text = String(tempo.bpm())
        note1.text = locStrNote1 + " : \(tempo.noteDelay()*4) ms"
        note2.text = locStrNote2 + " : \(tempo.noteDelay()*2) ms"
        note4.text = locStrNote4 + " : \(tempo.noteDelay()) ms"
        note8.text = locStrNote8 + " : \(tempo.noteDelay()/2) ms"
    }

    func changeCalcMode_AND_RESET_FromUI() {
        switch precisionMode.selectedSegmentIndex {
        case 0 : tempo.setModeAndReset(mode: .average); lbModeInfo.text = txtModeInfoAverage
        case 1 : tempo.setModeAndReset(mode: .instant); lbModeInfo.text = txtModeInfoInstant
        default: tempo.setModeAndReset(mode: .average); lbModeInfo.text = txtModeInfoAverage
        }
    }
}

// MARK: - Extension for user actions and UI style
private extension TempoViewController {

    @IBAction func tap(_ sender: Any) {
        tempo.newtap()
        refreshUI()
    }

    @IBAction func buttonClicked(sender: AnyObject) {
        // Touch Up Inside action
        tap.layer.backgroundColor = UIColor(named: "secondarySystemFill")!.cgColor
    }

    @IBAction func buttonReleased(sender: AnyObject) {
        // Touch Down action
        tap.layer.backgroundColor = UIColor(named: "AccentColor")!.cgColor
    }

    @IBAction func reset(_ sender: Any) {
        tempo.reset()
        refreshUI()
    }

    @IBAction func changeMode(_ sender: Any) {
        changeCalcMode_AND_RESET_FromUI()
        refreshUI()
    }
}
