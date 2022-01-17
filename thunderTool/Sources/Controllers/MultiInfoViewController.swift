//
//  MultiInfoViewController.swift
//  thunderTool
//
//  Created by thunderduck on 10/05/2021.
//

import UIKit

// MARK: - Properties & ViewDidLoad
class MultiTrackInfoViewController: UIViewController {

    var multi: MultiTrack!

    @IBOutlet private var lbBitrate: UILabel!
    @IBOutlet private var lbMono: UILabel!
    @IBOutlet private var lbFat32Desc: UILabel!

    @IBOutlet private var imgFw: UIImageView!
    @IBOutlet private var imgUsb2: UIImageView!
    @IBOutlet private var imgFw8: UIImageView!
    @IBOutlet private var imgGiga: UIImageView!
    @IBOutlet private var imgSata: UIImageView!
    @IBOutlet private var imgUsb3: UIImageView!
    @IBOutlet private var imgFat32: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
    }
}

// MARK: - Private extension for UI methods
private extension MultiTrackInfoViewController {

    func refreshUI() {
        let result = multi.getBitRate()
        lbBitrate.text = result.value + result.unit

        mark(img: imgFw, state: multi.isvalid(inter: .fw400))
        mark(img: imgUsb2, state: multi.isvalid(inter: .usb2))
        mark(img: imgFw8, state: multi.isvalid(inter: .fw800))
        mark(img: imgGiga, state: multi.isvalid(inter: .giga))
        mark(img: imgSata, state: multi.isvalid(inter: .sata))
        mark(img: imgUsb3, state: multi.isvalid(inter: .usb3))

        let mono = multi.getMonoSize()
        lbMono.text = mono.value + mono.unit

        let strFat32LimitOK = NSLocalizedString("FAT32 4Go limit OK", comment: "FAT32 4Go limit OK")
        let strFat32LimitOver = NSLocalizedString("FAT32 4Go limit exceeded", comment: "FAT32 4Go limit exceeded")
        if multi.isfat32valid() {
            mark(img: imgFat32, state: true)
            lbFat32Desc.text = strFat32LimitOK
        } else {
            mark(img: imgFat32, state: false)
            lbFat32Desc.text = strFat32LimitOver
        }
    }

    func mark(img: UIImageView, state: Bool) {
        if state {
            img.image = UIImage.init(systemName: "checkmark")
        } else {
            img.image = UIImage.init(systemName: "exclamationmark.triangle")
            img.image = img.image?.withTintColor(UIColor(named: "CustomOrange")!, renderingMode: .alwaysOriginal)
        }
    }
}
