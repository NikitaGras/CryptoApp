//
//  CustomSegmentedControl.swift
//  CryptoApp
//
//  Created by Nikita Gras on 06.06.2021.
//

import UIKit

@IBDesignable class CustomSegmentedControl: UIView {
    private(set) var selectedSegmentIndex: Int = 0
    private var buttons = [UIButton]()
    private var selectorView: UIView!
    var delegate: CustomSegmentedControlDelegate?
    
    @IBInspectable var textColor: UIColor = .systemGray {
        didSet {
            buttons.forEach { button in
                button.setTitleColor(textColor, for: .normal)
            }
        }
    }
    
    @IBInspectable var selectedTextColor: UIColor = .white {
        didSet {
            buttons.forEach { button in
                button.setTitleColor(selectedTextColor, for: .selected)
            }
        }
    }
    
    @IBInspectable var selectorViewBackgroundColor: UIColor = .systemBlue {
        didSet {
            selectorView?.backgroundColor = selectorViewBackgroundColor
        }
    }
    
    var isEnabled: Bool = true {
        didSet {
            buttons.forEach { button in
                button.isEnabled = isEnabled
            }
            selectorView.backgroundColor = isEnabled ? .systemBlue : .lightGray
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        addViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    var isActive: Bool = true {
        didSet {
            buttons.forEach { button in
                button.isEnabled = isActive
            }
            selectorView.backgroundColor = isActive ? .systemBlue : .lightGray
        }
    }
    
    private func addViews() {
        addButtons()
        buttons[selectedSegmentIndex].isSelected = true
        addSelectorView()
        addStackView(with: buttons)
    }
    
    private func setupViews() {
        selectorView.frame.size.width = buttons[selectedSegmentIndex].frame.width
        selectorView.frame.size.height = buttons[selectedSegmentIndex].frame.height
    }
    
    private func addButtons() {
        removeButtons()
        let titles = TimePeriod.getTitles()
        titles.forEach { title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.setTitleColor(selectedTextColor, for: .selected)
            button.tintColor = .clear
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
        }
    }
    
    private func removeButtons() {
        buttons.forEach { button in
            button.removeFromSuperview()
        }
        buttons.removeAll()
    }
    
    private func addSelectorView() {
        selectorView = UIView()
        selectorView.backgroundColor = selectorViewBackgroundColor
        selectorView.layer.cornerRadius = frame.height / 2
        addSubview(selectorView)
    }
    
    private func addStackView(with arrangedSubviews: [UIButton]) {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        setupConstraints(for: stackView)
    }
    
    private func setupConstraints(for stackView: UIStackView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    @objc private func buttonTapped(_ button: UIButton) {
        
        let firstObject = buttons.enumerated().first { iterator in
            return iterator.element == button
        }
        guard let object = firstObject else {
            return
        }
        let button = object.element
        let index = object.offset

        let selectorViewStartPosition = button.frame.minX
        let selectorViewWidth = button.frame.width
        UIView.animate(withDuration: 0.3) {
            self.selectorView.frame.origin.x = selectorViewStartPosition
            self.selectorView.frame.size.width = selectorViewWidth
        }
        
        buttons[selectedSegmentIndex].isSelected = false
        selectedSegmentIndex = index
        button.isSelected = true

        delegate?.segmentedControl(self, didSelectSegmentAt: selectedSegmentIndex)
    }
}
