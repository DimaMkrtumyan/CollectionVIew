//
//  ViewController.swift
//  CollectionView_Practice
//
//  Created by Dmitriy Mkrtumyan on 06.08.23.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: - Data
    let headersTitles = [
        "Motorcycles"
    ]
    
//    let motorcyclesImages = (1...4).map { UIImage(named: "moto-\($0)") }
    let motorcyclesImages = Array(repeating: UIImage(named: "moto-1"), count: 100)
    
    var largePhotoIndexPath: IndexPath? {
      didSet {
        var indexPaths: [IndexPath] = []
        if let largePhotoIndexPath = largePhotoIndexPath {
          indexPaths.append(largePhotoIndexPath)
        }

        if let oldValue = oldValue {
          indexPaths.append(oldValue)
        }

        collectionView.performBatchUpdates({
          self.collectionView.reloadItems(at: indexPaths)
        }, completion: { _ in
          // 4
          if let largePhotoIndexPath = self.largePhotoIndexPath {
            self.collectionView.scrollToItem(
              at: largePhotoIndexPath,
              at: .centeredVertically,
              animated: true)
          }
        })
      }
    }

    
    // MARK: - Ui elements
    private var collectionView: UICollectionView!
    private let layout = UICollectionViewFlowLayout()

    // MARK: - Ui setup methods
    private func setupUi() {
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: "item")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardChange), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(offKeyboardChange), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc
    private func onKeyboardChange(notification: Notification) {
        if let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrameHeight = value.cgRectValue.height
            let bottomInset = view.bounds.maxY - collectionView.frame.maxY
            let adjustedHeight = keyboardFrameHeight - bottomInset
            collectionView.contentInset.bottom = adjustedHeight
            collectionView.verticalScrollIndicatorInsets.bottom = adjustedHeight
        }
    }
    
    @objc
    private func offKeyboardChange(notification: Notification) {
        if let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrameHeight = value.cgRectValue.height
            let bottomInset = view.bounds.maxY - collectionView.frame.maxY
            let adjustedHeight = keyboardFrameHeight - bottomInset
            collectionView.contentInset.bottom -= adjustedHeight
            collectionView.verticalScrollIndicatorInsets.bottom -= adjustedHeight
        }
    }
    
    // MARK: - Overrided mothods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        setupConstraints()
    }

}

// MARK: - extensions
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        motorcyclesImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as? MainCollectionCell {
            if let image = motorcyclesImages[indexPath.row] {
                cell.setupCell(with: image)
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegate {
    
    // MARK: - Item selection handling
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if largePhotoIndexPath == indexPath {
          largePhotoIndexPath = nil
        } else {
          largePhotoIndexPath = indexPath
        }

        return false
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Setup Flow Layout and Items growing size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath == largePhotoIndexPath {
            if let photo = motorcyclesImages[indexPath.row]{
                let size = collectionView.bounds.size
                return photo.sizeToFillWidth(of: size, image: photo)
            }
        }
        
        let columns: CGFloat = 4
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let adjustedWidth = collectionViewWidth - spaceBetweenCells
        let eachCellWidth: CGFloat = adjustedWidth / columns
        let height: CGFloat = 100
        
        return CGSize(width: eachCellWidth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                        withReuseIdentifier: "header",
                                                                        for: indexPath) as? MainCollectionReusableView {
            header.setupTitle(for: headersTitles[indexPath.section])
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.bounds.width, height: 50)
    }
}

