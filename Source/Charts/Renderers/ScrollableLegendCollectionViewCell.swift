//
//  ScrollableLegendCollectionViewCell.swift
//  Charts
//
//  Created by Rameez on 2/8/18.
//

#if !os(OSX)
import UIKit
#endif

class ScrollableLegendCollectionViewCell: UICollectionViewCell {

    var legendEntry: ScrollableLegendEntry = ScrollableLegendEntry() {
        didSet {
            updateCellContent()
        }
    }
    
    fileprivate var legendView =  UIView()
    fileprivate var titleLabel = UILabel()

    fileprivate var legendHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    fileprivate var legendWidthConstraint: NSLayoutConstraint = NSLayoutConstraint()

    //MARK: Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = true
        setupLegendView()
        setupLegendLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLegendView() {
        legendView = UIView()
        legendView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(legendView)
        
        // Constraints
        let centerYContraint = NSLayoutConstraint(item: legendView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let centerXContraint = NSLayoutConstraint(item: legendView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        let legendLeading = NSLayoutConstraint(item: legendView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 5)
        legendHeightConstraint = NSLayoutConstraint(item: legendView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20)
        legendWidthConstraint = NSLayoutConstraint(item: legendView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25)
        
        contentView.addConstraints([legendLeading,centerYContraint, centerXContraint, legendHeightConstraint, legendWidthConstraint])
        NSLayoutConstraint.activate([legendLeading,centerYContraint, centerXContraint, legendHeightConstraint, legendWidthConstraint])
    }
    
    private func setupLegendLabel() {
        titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        // Constraints
        let centerYContraint = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        let leadingConstraint = NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: legendView, attribute: .right, multiplier: 1.0, constant: 5)
        let trailingConstraint = NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: 0)

        let topConstraint = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 5)
        let bottomConstraint = NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 5)

        contentView.addConstraints([leadingConstraint, trailingConstraint, centerYContraint, topConstraint, bottomConstraint])
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, centerYContraint, topConstraint, bottomConstraint])
    }
    
    private func updateCellContent() {

        legendView.backgroundColor = legendEntry.color
        legendView.layer.cornerRadius = legendEntry.cornerRadius
        legendWidthConstraint.constant = legendEntry.size.width
        legendHeightConstraint.constant = legendEntry.size.height

        titleLabel.textColor = legendEntry.titleColor
        titleLabel.text = legendEntry.title
        titleLabel.font = legendEntry.titleFont
    }
}


