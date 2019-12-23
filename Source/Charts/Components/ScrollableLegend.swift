//
//  ScrollableLegend.swift
//  Charts
//
//  Created by Rameez on 2/14/18.
//

#if !os(OSX)
    import UIKit
#endif

open class ScrollableLegend: NSObject {
    
    typealias RefreshScrollableLegend = (_ sender: Any) -> Void
    typealias ScrollEnabledAction = (_ enable: Bool,_ sender: Any) -> Void
    typealias WidthChnageAction = (_ sender: Any,_ widthPercentage: CGFloat,_ direction: ChartShiftDirection) -> Void

    public enum ChartShiftDirection {
        case left
        case right
    }

    var refreshLegend: RefreshScrollableLegend?
    var widthChnageAction: WidthChnageAction?
    var scrollEnabledAction: ScrollEnabledAction?
    
    /// Size of legends 0.0 to 1.0
    var widthPercentage: CGFloat    =   0.2

    /// Used to enable or disable the scrollable legend. Default value is TRUE
    open var isEnabled: Bool                            = true {
        didSet {
            refreshLegend?(self)
        }
    }
    
    /// Used to enable or disable the scrolling. Default value is TRUE
    open var isScrollEnabled: Bool                      = true {
        didSet {
            scrollEnabledAction?(isScrollEnabled, self)
        }
    }
    
    /// Legend entries to be displayed
    internal var legendEntries: [ScrollableLegendEntry] = [] {
        didSet {
            refreshLegend?(self)
        }
    }
    
    //MARK: Funtions
    init(_ entries: [ScrollableLegendEntry]) {
        super.init()
        self.legendEntries = entries
        self.widthPercentage = isEnabled ? widthPercentage : 0.0
    }
    
    /// Updates legend entries
    open func updateLegends(_ entries: [ScrollableLegendEntry]) {
        self.legendEntries = entries
    }
    
    /// widthPercentage of legends 0.0 to 1.0, direction based on RTL/LTR language
    open func setWidthPercentage(_ widthPercentage: CGFloat, direction: ChartShiftDirection) {
        self.widthPercentage = widthPercentage
        self.widthChnageAction?(self, widthPercentage, direction)
    }

}

