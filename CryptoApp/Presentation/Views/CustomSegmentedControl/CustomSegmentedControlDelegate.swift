//
//  CustomSegmentedControlDelegate.swift
//  CryptoApp
//
//  Created by Nikita Gras on 07.06.2021.
//

import Foundation

protocol CustomSegmentedControlDelegate {
    func segmentedControl(_ segmentedControl: CustomSegmentedControl, didSelectSegmentAt index: Int)
}
