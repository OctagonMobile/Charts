//
//  ScrollableLegendEntry.swift
//  Charts
//
//  Created by Rameez on 2/14/18.
//

#if !os(OSX)
    import UIKit
#endif

open class ScrollableLegendEntry: NSObject {

    /// Chart entry for the legend
    var dataEntry: ChartDataEntry?
    
    /// Title/Value to be displayed on legend
    var title: String           = ""
    
    /// Legend view color
    var color: NSUIColor          = NSUIColor.clear
    
    /// Size of the legend view.
    var size: CGSize            = CGSize(width: 25, height: 20)
    
    /// corner radius of the legend view.
    var cornerRadius: CGFloat   = 5.0
    
    /// Title color.
    var titleColor: NSUIColor     = NSUIColor.black
    
    /// Title font.
    var titleFont: NSUIFont       = NSUIFont.systemFont(ofSize: 12.0)
    
    //MARK: Functions
    override init() {
        super.init()
    }
    
    public init(dataEntry: ChartDataEntry?, title: String = "", color: NSUIColor, size: CGSize = CGSize(width: 25, height: 20), cornerRadius: CGFloat = 5.0, titleColor: NSUIColor = .black, font: NSUIFont = NSUIFont.systemFont(ofSize: 12.0)) {
        super.init()
        
        self.dataEntry = dataEntry
        self.title = title
        self.color = color
        self.size = size
        self.cornerRadius = cornerRadius
        self.titleColor = titleColor
        self.titleFont = font
    }

}

