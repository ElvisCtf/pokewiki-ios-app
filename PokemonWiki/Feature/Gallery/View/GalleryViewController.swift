//
//  GalleryViewController.swift
//  PokemonWiki
//
//  Created by Elvis Cheng (ESD - Software Trainee, Digital Solutions) on 3/7/2024.
//

import UIKit
import SnapKit
import Combine

class GalleryViewController: UIViewController {
    let viewModel = GalleryViewModel()
    var cancellables: Set<AnyCancellable> = []
    
    lazy var galleryCV: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let padding = 16.0
        let cellPadding = 16.0
        let itemWidth = (UIScreen.width - (padding * 2) - cellPadding) / 2
        let itemHeight = itemWidth * 4 / 3
        flow.itemSize = CGSize.init(width: itemWidth, height: itemHeight)
        flow.minimumLineSpacing = 16
        flow.minimumInteritemSpacing = 16
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cv.backgroundColor = .systemGroupedBackground
        cv.contentInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        cv.accessibilityIdentifier = "\(type(of: self))_galleryCV"
        cv.register(PokemonCVCell.self, forCellWithReuseIdentifier: PokemonCVCell.reuseIdentifier)
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setLayout()
        setBinding()
        requestData()
    }
    
    func initUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        title = "PokéWiki"
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithDefaultBackground()
        navigationItem.standardAppearance = barAppearance
        navigationItem.compactAppearance = barAppearance
        navigationItem.scrollEdgeAppearance = barAppearance
        navigationItem.searchController = searchController
        
        view.backgroundColor = .systemBackground
        view.addSubview(galleryCV)
    }
    
    func setLayout() {
        galleryCV.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setBinding() {
       viewModel.$pokemons
            .sink { pokemons in
                DispatchQueue.main.async {
                    self.galleryCV.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    
    func requestData() {
        Task {
            await viewModel.getPokemons()
        }
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = galleryCV.dequeueReusableCell(withReuseIdentifier: PokemonCVCell.reuseIdentifier, for: indexPath) as! PokemonCVCell
        cell.setContent(name: viewModel.pokemons[indexPath.row].name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
