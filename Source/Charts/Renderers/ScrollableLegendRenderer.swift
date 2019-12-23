//
//  ScrollableLegendRenderer.swift
//  Charts
//
//  Created by Rameez on 2/8/18.
//

#if canImport(UIKit)
    import UIKit
#endif

open class ScrollableLegendRenderer: UIView {

    public typealias LegendSelectionAction = (_ sender: Any,_ legendEntry: ScrollableLegendEntry,_ index: Int) -> Void

    /// Call back when user select/tap on any legend
    open var legendSelectionAction: LegendSelectionAction?

    /// Legend to be drawn
    var legend: ScrollableLegend = ScrollableLegend([])

    /// Collectionview to show legend
    private var legendCollectionView: UICollectionView?
    
    /// Datasource for collectiomnview
    private var dataSource: [ScrollableLegendEntry] {
        return legend.legendEntries
    }

    //MARK: Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    init(frame: CGRect, legend: ScrollableLegend) {
        super.init(frame: frame)
        
        self.legend = legend
        initialSetup()
    }
        
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        
        backgroundColor = .clear

        let flow = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = 0.0
        flow.minimumInteritemSpacing = 0.0

        legendCollectionView = UICollectionView(frame: frame, collectionViewLayout: flow)
        legendCollectionView?.backgroundColor = .clear
        legendCollectionView?.dataSource = self
        legendCollectionView?.delegate = self
        legendCollectionView?.register(ScrollableLegendCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.cellId)
        let tapGestureRecognizer = NSUITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized(_:)))
        legendCollectionView?.addGestureRecognizer(tapGestureRecognizer)
        
        guard let collectionView = legendCollectionView else{ return }
        addSubview(collectionView)

        legend.refreshLegend = {[weak self] (sender) in
            self?.refreshLegend()
        }
        
        legend.scrollEnabledAction = { [weak self] (enable, sender) in
            self?.legendCollectionView?.isScrollEnabled = enable
        }
        
        setupConstraint()
    }
    
    private func setupConstraint() {
        guard let collectionView = legendCollectionView else{ return }
        legendCollectionView?.translatesAutoresizingMaskIntoConstraints = false

        var constraints = [NSLayoutConstraint]()
        let views: [String: UIView] = ["collectionView": collectionView, "view": self]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-|", options: [], metrics: nil, views: views)
        addConstraints(constraints)
    }
    
    private func refreshLegend() {
        self.isHidden = !self.legend.isEnabled
        self.legendCollectionView?.reloadData()
    }
    
    @objc func tapGestureRecognized(_ gestureReconizer: UILongPressGestureRecognizer) {
        
        let point = gestureReconizer.location(in: legendCollectionView)
        guard let indexPath = legendCollectionView?.indexPathForItem(at: point) else { return }
        
        let legendEntry = dataSource[indexPath.row]
        legendSelectionAction?(self, legendEntry, indexPath.row)
    }

}

extension ScrollableLegendRenderer: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return legend.isEnabled ? dataSource.count : 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.cellId, for: indexPath) as? ScrollableLegendCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .clear
        cell.legendEntry = dataSource[indexPath.row]
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, 0, collectionView.bounds.height, 0)
        cell.layer.transform = transform
        
        let delay = (0.1 * CGFloat(indexPath.row))
        UIView.animate(withDuration: 0.5, delay: TimeInterval(delay), usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: ({
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }), completion: nil)
    }
}

extension ScrollableLegendRenderer: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 30)
    }
}

extension ScrollableLegendRenderer {
    struct CellIdentifiers {
        static let cellId: String    =  "LegendCollectionViewCellId"
    }
}

