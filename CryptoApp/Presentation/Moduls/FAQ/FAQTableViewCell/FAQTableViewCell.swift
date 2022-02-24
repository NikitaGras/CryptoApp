//
//  FAQTableViewCell.swift
//  CryptoApp
//
//  Created by Nikita Gras on 19.05.2021.
//

import UIKit

class FAQTableViewCell: UITableViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    private(set) var state: State = .closed
    
    override func awakeFromNib() {
        super.awakeFromNib()
        answerLabel.numberOfLines = state.numberOfLines
        self.selectionStyle = .none
    }
    
    func fill(with data: FAQ) {
        questionLabel.text = data.question
        answerLabel.text = data.answer
    }
    
    func changeNumberOfLines(_ completion: @escaping () -> Void) {
        state = state == .closed ? .opened : .closed
        animateCell(for: state, completion)
    }
    
    func animateCell(for state: State, _ completion: @escaping () -> Void) {
        if state == . opened {
            self.answerLabel.numberOfLines = state.numberOfLines
            UIView.animate(withDuration: 0.35) {
                self.arrowImageView.transform = CGAffineTransform(rotationAngle: state.rotationAngle)
            }
            completion()
        }
        
        if state == .closed {
            let closedHeight = getHeight(for: answerLabel, with: state)
            UIView.animate(withDuration: 0.35) {
                self.arrowImageView.transform = CGAffineTransform(rotationAngle: state.rotationAngle)
            } completion: { isComplete in
                if isComplete {
                    self.answerLabel.numberOfLines = state.numberOfLines
                }
                completion()
            }
        }
    }
    
    private func getHeight(for label: UILabel, with state: State) -> CGFloat {
        let newLabel = UILabel(frame: label.frame)
        newLabel.numberOfLines = state.numberOfLines
        newLabel.text = label.text ?? ""
        newLabel.font = label.font
        newLabel.lineBreakMode = .byWordWrapping
        newLabel.sizeToFit()
        return newLabel.frame.height
    }
    
    override func prepareForReuse() {
        state = .closed
        self.arrowImageView.transform = CGAffineTransform(rotationAngle: state.rotationAngle)
        answerLabel.numberOfLines = state.numberOfLines
    }
}

extension FAQTableViewCell {
    enum State {
        case opened
        case closed
        
        // for label
        var numberOfLines: Int {
            switch self {
            case .opened:
                return 0
            case .closed:
                return 2
            }
        }
        
        // for arrow animation
        var rotationAngle: CGFloat {
            switch self {
            case .opened:
                return CGFloat.pi
            case .closed:
                return CGFloat.pi * 2
            }
        }
    }
}
