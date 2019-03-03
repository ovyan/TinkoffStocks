//
//  ViewController.swift
//  tinkoff_Stocks
//
//  Created by Mike Ovyan on 26/01/2019.
//  Copyright © 2019 Mike Ovyan. All rights reserved.
//

import UIKit

final class FeedController: UIViewController {


    private let header = FeedHeaderView()

    private let noInternetPopup = MessagePopup(with: CSTR.noConnectionMessage)

    private lazy var stockCollection: UICollectionView = {
        let collection = UICollectionView(scrollDirection: .vertical)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false

        let width = view.frame.width - 32
        let height = width / 4 < 80 ? 80 : width / 4
        collection.flowLayout.itemSize = CGSize(width: width, height: height)

        return collection
    }()


    private let reachability = Reachability()!

    private let service: FeedServiceDataProvider = FeedServiceDataProviderImp()

    private var stockList: [StockViewModel] = []

    private var loadInProgress = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CUI.Feed.backgroundColor

        addSubviews()
        setupHeader()
        setupCollectionView()
        loadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        observeInternetConnection()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func addSubviews() {
        view.addSubviews(stockCollection, header)
    }

    private func setupHeader() {
        header.onRefresh = { [weak self] in
            self?.loadData()
        }
    }

    private func setupCollectionView() {
        stockCollection.register(StockCell.self)
        stockCollection.delegate = self
        stockCollection.dataSource = self

        stockCollection.contentInset.bottom = 86
        stockCollection.contentInset.top = 16
    }

    private func observeInternetConnection() {
        reachability.whenUnreachable = { [weak self] _ in
            guard let `self` = self else { return }
            self.present(self.noInternetPopup, animated: true)
        }

        reachability.whenReachable = { [weak self] _ in
            self?.noInternetPopup.dismiss(animated: true)
            self?.loadData()
        }

        try? reachability.startNotifier()
    }

    private func loadData() {
        guard !loadInProgress else { return }
        loadInProgress = true

        service.loadData()
            .then(on: DispatchQueue.main, updateStockList)
            .catch(handelApiError)
            .always { self.loadInProgress = false }
    }

    private func updateStockList(with stocks: [StockModel]) {
        stockList = stocks.map { StockViewModel(with: $0) }

        for path in stockCollection.indexPathsForVisibleItems {
            if let cell = stockCollection.cellForItem(at: path) as? StockCell {
                let model = stockList[path.row]
                cell.update(with: model)
            }
        }

        if stockCollection.visibleCells.isEmpty {
            stockCollection.reloadData()
        }
    }

    private func handelApiError(_ error: Error) {
        let popup = MessagePopup(with: CSTR.apiErrorMessage)
        present(popup, animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        header.layoutSubviews()
        header.pin
            .hCenter()
            .bottom(view.pin.safeArea)
            .marginBottom(22)

        stockCollection.pin
            .all()
    }
}

extension FeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stockList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StockCell = collectionView.dequeueReusableCell(at: indexPath)
        cell.layer.cornerRadius = 8

        let model = stockList[indexPath.row]
        cell.update(with: model)

        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 16 }
}
