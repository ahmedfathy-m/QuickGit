//
//  ExploreTableCell.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 17/08/2022.
//

import UIKit

class ExploreTableCell: UITableViewCell {
    lazy var viewModel: ExploreCellViewModel = {
        let myViewModel = ExploreCellViewModel()
        myViewModel.delegate = self
        return myViewModel
    }()
    
    var cellType: ExploreSection?
    
    let loadingIndicator: UIActivityIndicatorView = {
        let myIndicator = UIActivityIndicatorView(style: .large)
        myIndicator.hidesWhenStopped = true
        myIndicator.startAnimating()
        return myIndicator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        Task {
            do {
                try await viewModel.start()
            } catch {
                let errorMessage = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .actionSheet)
                errorMessage.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.parentViewController?.present(errorMessage, animated: true)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let layout: UICollectionViewFlowLayout = {
        let myLayout = UICollectionViewFlowLayout()
        myLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 4)
        myLayout.scrollDirection = .horizontal
        myLayout.minimumLineSpacing = 20
        myLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return myLayout
    }()
    lazy var exploreCollectionView = UICollectionView(frame: .null, collectionViewLayout: layout)
    
    override func layoutSubviews() {
        exploreCollectionView.dataSource = self
        exploreCollectionView.register(ExploreCollectionCell.nib(), forCellWithReuseIdentifier: ExploreCollectionCell.identifier)
        exploreCollectionView.translatesAutoresizingMaskIntoConstraints = false
        exploreCollectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(exploreCollectionView)
        NSLayoutConstraint.activate(
            [exploreCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
             exploreCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             exploreCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             exploreCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)]
        )
        contentView.addSubview(loadingIndicator)
        loadingIndicator.center = contentView.center
    }
    
    func didLoadDataModel() {
        DispatchQueue.main.async {
            self.exploreCollectionView.reloadData()
            self.loadingIndicator.stopAnimating()
        }
    }
}

extension ExploreTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellType {
        case .topContributors: return viewModel.topUsersCount
        case .topWatchedRepos: return viewModel.reposCount
        case .allThingsSwift: return viewModel.swiftReposCount
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCollectionCell.identifier, for: indexPath) as! ExploreCollectionCell
        switch cellType {
        case .topContributors: cell.profileModel = viewModel.dataModel?[indexPath.row]
        case .topWatchedRepos: cell.repoModel = viewModel.repos?[indexPath.row]
        case .allThingsSwift: cell.repoModel = viewModel.swiftRepos?[indexPath.row]
        default: break
        }
        
        return cell
    }
}


class ExploreCellViewModel {
    var listModel: UserSearchModel?
    var dataModel: [ProfileModel]? {
        didSet {
            if dataModel?.count == 10 {
                delegate?.didLoadDataModel()
            }
        }
    }
    
    var repos: [Repository]? {
        didSet {
            if repos?.count == 10 {
                delegate?.didLoadDataModel()
            }
        }
    }
    
    var reposCount: Int {
        if repos?.count == 10 {
            return 10
        }
        return 0
    }
    
    var swiftRepos: [Repository]? {
        didSet {
            if swiftRepos?.count == 10 {
                delegate?.didLoadDataModel()
            }
        }
    }
    
    var swiftReposCount: Int {
        if swiftRepos?.count == 10 {
            return 10
        }
        return 0
    }
    
    var topUsersCount: Int {
        if dataModel?.count == 10 {
            return 10
        }
        return 0
    }
    
    weak var delegate: ExploreTableCell?
    
    fileprivate func loadTopContributors() async throws {
        listModel = nil
        dataModel = nil
        let params = ["q":"repos:>30",
                      "per_page":"10",
                      "page":"1",
                      "sort":"repositories"]
        listModel = try await NetworkHandler().loadRequest(using: .searchUsers("repos:>30"), parameters: params, headers: nil)
        if let items = listModel?.items {
            dataModel = [ProfileModel]()
            for userResult in items {
                let profileModel: ProfileModel = try await NetworkHandler().loadRequest(using: .someUser(userResult.userName), parameters: nil, headers: nil)
                dataModel?.append(profileModel)
            }
        }
    }
    
    fileprivate func loadTopRepos() async throws {
        let weekAgoDate = Date.now.addingTimeInterval(-604800)
        let params = ["q":"created:>\(weekAgoDate.formatted(.iso8601))",
                      "per_page":"10",
                      "page":"1",
                      "sort":"followers"]
        let model: RepositorySearchModel = try await NetworkHandler().loadRequest(using: .browseRepos("1"), parameters: params, headers: nil)
        repos = model.items
    }
    
    fileprivate func loadSwiftRepos() async throws {
        let weekAgoDate = Date.now.addingTimeInterval(-604800)
        let params = ["q":"language:swift, created:>\(weekAgoDate.formatted(.iso8601))",
                      "per_page":"10",
                      "page":"1",
                      "sort":"followers"]
        let model: RepositorySearchModel = try await NetworkHandler().loadRequest(using: .browseRepos("1"), parameters: params, headers: nil)
        swiftRepos = model.items
    }
    
    func start() async throws{
        try await loadTopContributors()
        try await loadTopRepos()
        try await loadSwiftRepos()
    }
    
}
