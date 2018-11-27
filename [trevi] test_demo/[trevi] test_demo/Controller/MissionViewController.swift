//
//  MissionViewController.swift
//  [trevi] test_demo
//
//  Created by Vanilla on 2018/11/24.
//  Copyright © 2018 Vanilla. All rights reserved.
//

import UIKit

enum ScreenStatus {
    case P
    case L
}

class MissionViewController: UIViewController {
    
    @IBOutlet weak var gridCollectionView: UICollectionView!
    @IBOutlet weak var btnCollectionView: UICollectionView!

    var sizeModel : SizeModel!
    private var missionViewModel : MissionViewModel!
    private var observer : NSKeyValueObservation?
    private var missionIndexPath : IndexPath?
    private var isClean = true
    private var hlView : UIView?
    private var topSpace : CGFloat!
    private var bottomSoace : CGFloat!
    private var hightLightIsShow = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        missionViewModel = MissionViewModel(sizeModel: sizeModel)
        
        gridCollectionView.dataSource = self
        gridCollectionView.delegate = self
        btnCollectionView.dataSource = self
        btnCollectionView.delegate = self
        
//        //設定 collectionView interval space = 0
//        let btnlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        btnlayout.minimumInteritemSpacing = 0
//        btnlayout.minimumLineSpacing = 0
//        btnCollectionView.collectionViewLayout = btnlayout
        
        setLineSpace(collectionView: gridCollectionView)
        setLineSpace(collectionView: btnCollectionView)
        
//        let gridlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        gridlayout.minimumInteritemSpacing = 0
//        gridlayout.minimumLineSpacing = 0
//        gridCollectionView.collectionViewLayout = gridlayout
        
        observer = missionViewModel.observe(\MissionViewModel.targetIndexPath, options: [.old, .new, .prior], changeHandler: { (mission, change) in
            DispatchQueue.main.async {
                if let oldIndexPath = change.oldValue {
                    if change.isPrior == false {
                        self.randReset(oldIndexPath: oldIndexPath!)
                    }
                }
                
                if change.newValue != nil && change.isPrior == false {
                    guard let newIndexPath = change.newValue else {return}
                    self.randHighLight(newIndexPath: newIndexPath!)
                }
            }
        })
    }
    
    
    func setLineSpace(collectionView : UICollectionView) {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = flowLayout
    }
    
    
    //於 Screen orientation 時，CollectionViewCell 的尺寸切換
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = btnCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        switch  UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            flowLayout.itemSize = CGSize(width: (CGFloat(btnCollectionView.frame.width) / CGFloat(sizeModel.column)), height: btnCollectionView.frame.height)
        case .landscapeLeft, .landscapeRight:
            flowLayout.itemSize = CGSize(width: (CGFloat(btnCollectionView.frame.height) / CGFloat(sizeModel.column)), height: btnCollectionView.frame.width)
        default:
            flowLayout.itemSize = CGSize(width: (CGFloat(btnCollectionView.frame.width) / CGFloat(sizeModel.column)), height: btnCollectionView.frame.height)
        }
        if hightLightIsShow {
            showHighLightView(isShow: true)
        }
        flowLayout.invalidateLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        missionViewModel.endRandom()
    }
    
    
    func randHighLight(newIndexPath : IndexPath) {
        self.isClean = false
        self.missionIndexPath = newIndexPath
        self.gridCollectionView.reloadItems(at: [newIndexPath])
        let btnIndexPath = IndexPath(row: newIndexPath.row, section: 0)
        self.btnCollectionView.reloadItems(at: [btnIndexPath])
        showHighLightView(isShow: true)
    }
    
    func randReset(oldIndexPath : IndexPath){
        self.isClean = true
        self.missionIndexPath = oldIndexPath
        self.gridCollectionView.reloadItems(at: [oldIndexPath])
        let btnIndexPath = IndexPath(row: oldIndexPath.row, section: 0)
        self.btnCollectionView.reloadItems(at: [btnIndexPath])
    }
    
    func showHighLightView(isShow : Bool){
        hightLightIsShow = isShow
        if hlView != nil {
            hlView!.removeFromSuperview()
        }
        if isShow {
            let window = UIApplication.shared.keyWindow
            guard   let topSafeArea = window?.safeAreaInsets.top,
                let bottomSafeArea = window?.safeAreaInsets.bottom,
                let leftSafeArea = window?.safeAreaInsets.left ,
                let rightSafeArea = window?.safeAreaInsets.right,
                let navibarHeight = self.navigationController?.navigationBar.frame.size.height,
                let indexColumn = missionIndexPath?.row else { return }
            
            let widthOffset = (CGFloat(indexColumn) * CGFloat(UIScreen.main.bounds.width - leftSafeArea - rightSafeArea) / CGFloat(sizeModel.column))
            hlView = HighLightView(frame: CGRect(x: leftSafeArea + widthOffset, y: topSafeArea + navibarHeight, width: CGFloat(UIScreen.main.bounds.width - leftSafeArea - rightSafeArea) / CGFloat(sizeModel.column) , height: UIScreen.main.bounds.height - bottomSafeArea - topSafeArea - navibarHeight))
            
            self.view.addSubview(hlView!)
        }
    }
}

//MARK: UICollectionViewDataSource Methods, UICollectionDelegate Methods, UICollectionViewDelegateFlowLayout Methods
extension MissionViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == gridCollectionView {
            return sizeModel.row
        }
        else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sizeModel.column
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch collectionView {
        case gridCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCollectionViewCell
            if self.missionIndexPath != nil && self.missionIndexPath == indexPath{
                cell.gridLabel.text = isClean ? "" : "Random"
            }
            cell.cellHandler(indexPath: indexPath)
            return cell
        case btnCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridButtonCell", for: indexPath) as! ButtonCollectionViewCell
            cell.delegate = self
            cell.cellHandler(indexPath: indexPath, clean: isClean)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCollectionViewCell
            cell.backgroundColor = UIColor.white
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == gridCollectionView {
            return CGSize(width: (CGFloat(collectionView.frame.width) / CGFloat(sizeModel.column) - 1), height: (CGFloat(collectionView.frame.height)) / CGFloat(sizeModel.row) - 1)
        }
        else {
            return CGSize(width: (CGFloat(collectionView.frame.width) / CGFloat(sizeModel.column)), height: collectionView.frame.height)
        }
    }
}

//MARK: - ButtonCollectionViewCellDelegate Methods
extension MissionViewController : ButtonCollectionViewCellDelegate {
    func cleanBtnPressed(index : Int) {
        guard let currentIndexPath = self.missionIndexPath else { return }
        if index == currentIndexPath.row {
            randReset(oldIndexPath: currentIndexPath)
            showHighLightView(isShow: false)
        }
        
    }
}
