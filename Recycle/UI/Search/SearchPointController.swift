//
//  SearchPointController.swift
//  Recycle
//
//  Created by Babaev Mikhail on 16.11.2020.
//

import UIKit

protocol SearchPointDelegate: AnyObject {
    func didSelectPoint(_ point: RecyclePoint)
}

final class SearchPointController: UIViewController {
    
    // MARK: - Properties
    
    @Inject var pointService: PointService
    
    weak var delegate: SearchPointDelegate?
    
    private let cellId = "SearchCell"
    private let tableView: UITableView = .init()
    
    private var points: [RecyclePoint] = []
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
}

extension SearchPointController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        print("Search text: \(text)")
        
        pointService.searchPoint(text: text) { [weak self] result in
            switch result {
            case .success(let points):
                self?.points = points
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

extension SearchPointController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellId,
            for: indexPath
        )
        guard let searchCell = cell as? SearchCell else {
            return UITableViewCell()
        }
        
        let point = points[indexPath.row]
        let title = point.name
        let text = point.address
        searchCell.configure(title: title, text: text)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        points.count
    }
}

extension SearchPointController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let point = points[indexPath.row]
        dismiss(animated: true) {
            self.delegate?.didSelectPoint(point)
        }
    }
}

private extension SearchPointController {
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let nib = UINib(nibName: "SearchCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.keyboardDismissMode = .onDrag
    }
}
