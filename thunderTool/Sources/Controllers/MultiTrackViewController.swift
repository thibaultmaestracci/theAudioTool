//
//  MultiViewController.swift
//  thunderTool
//
//  Created by thunderduck on 10/05/2021.
//

import UIKit
import theAudioToolKit

// MARK: - Private Properties & ViewDidLoad
class MultiTrackViewController: UIViewController {

    @IBOutlet private var resultSize: UILabel!
    @IBOutlet private var resultUnit: UILabel!

    @IBOutlet private var sampleRateSelector: UISegmentedControl!
    @IBOutlet private var bitDepthSelector: UISegmentedControl!

    @IBOutlet private var trackNumberSlider: UISlider!
    @IBOutlet private var trackNumberResult: UILabel!
    @IBOutlet private var recTimeSlider: UISlider!
    @IBOutlet private var recTimeResult: UILabel!

    @IBOutlet private var btnInfo: UIBarButtonItem!

    private var multi = MultiTrack()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        refreshUI()
    }
}

// MARK: - Private extension for UI methods
private extension MultiTrackViewController {

    func setupUI() {

        // Sample Rate Segmented Control
        sampleRateSelector.removeAllSegments()
        for value in SampleRates.allCases {
            sampleRateSelector.insertSegment(withTitle: value.name, at: value.rawValue, animated: false)
        }
        sampleRateSelector.selectedSegmentIndex = SampleRates.defaultIndexValue

        // Bit Depth Segmented Control
        bitDepthSelector.removeAllSegments()
        for value in BitDepths.allCases {
            bitDepthSelector.insertSegment(withTitle: value.name, at: value.rawValue, animated: false)
        }
        bitDepthSelector.selectedSegmentIndex = BitDepths.defaultIndexValue
    }

    func refreshUI() {

        // Get data from UI
        let sampleRate = SampleRates.init(rawValue: sampleRateSelector.selectedSegmentIndex)!
        let bitDepth = BitDepths.init(rawValue: bitDepthSelector.selectedSegmentIndex)!
        let numberOfTracks = Int(trackNumberSlider.value)
        let recordingTime = Int(recTimeSlider.value)

        // Calc
        multi = MultiTrack(sampleRate, bitDepth, numberOfTracks, recordingTime)
        let multiResultSize = multi.getSize()

        // Set UI results
        resultSize.text = multiResultSize.value
        resultUnit.text = multiResultSize.unit

        trackNumberResult.text = String(numberOfTracks)
        recTimeResult.text = multi.getTimeFormated()
        setUIwarning(warning: multi.warning())
    }

    func setUIwarning(warning: Bool) {
        if warning {
            btnInfo.image = UIImage.init(named: "info.circle.fill")
        } else {
            btnInfo.image = UIImage.init(named: "info.circle")
        }
    }
}

// MARK: - Private extension for user actions
private extension MultiTrackViewController {

    @IBAction func uiStateChange(_ sender: Any) {
        refreshUI()
    }

    @IBAction func infoClick(_ sender: Any) {
        performSegue(withIdentifier: "multiInfo", sender: self)
    }
}

// MARK: - Extension for segue
extension MultiTrackViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // swiftlint:disable force_cast
        if segue.identifier == "multiInfo"{
            let multiInfoVC = segue.destination as! MultiTrackInfoViewController
            multiInfoVC.multi = multi
        }
    }
}
