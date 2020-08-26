//
//  FilterViewController.swift
//  BreakingBad
//
//  Created by Sheikh Ahmed on 26/08/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import UIKit

protocol SelectedSeasonDelegate: class{
    func seasonSelected(index: Int)
}


class FilterViewController: UIViewController {
    // IB outlet
    @IBOutlet weak var topView: UIView!
    @IBAction func closeButtonPressed(_ sender: Any) {
        hideView()
    }
    @IBAction func doneButtonClicked(_ sender: Any) {
        delegate?.seasonSelected(index: selectedSession == -1 ? 0 : selectedSession)
        hideView()
    }
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    // variables
    var maxSeason: Int?
    internal weak var delegate: SelectedSeasonDelegate?
    private var seasons: [Int] = []
    private var selectedSession: Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopView()
        setupPickerView()
    }
    private func setupTopView(){
        topView.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    private func setupPickerView(){
        pickerView.delegate = self
        pickerView.dataSource = self
        guard let maxSeason = maxSeason, maxSeason > 1 else { return }
        seasons = Array(1...maxSeason)
    }
    private func hideView(){
        self.dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == topView {
            hideView()
        }
    }
}

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        maxSeason ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Season: \(seasons[row])"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSession = row
    }
}
