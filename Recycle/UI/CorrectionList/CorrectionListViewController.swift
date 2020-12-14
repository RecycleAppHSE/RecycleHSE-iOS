//
//  CorrectionListViewController.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.12.2020.
//

import UIKit

class CorrectionListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @Inject var service: CorrectionService
    
    var point: RecyclePoint!
    
    var ids: [Int]? = nil
    
    var corrections: [Correction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CorrectionCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        
        loadCorrections()
    }
    
    func loadCorrections() {
        let callback: ResultCallback<[Correction]> = { [weak self] result in
            switch result {
            case .success(let corrections):
                self?.corrections = corrections
                self?.tableView.reloadData()
            case .failure(let error):
                self?.show(error: error)
            }
        }
        
        if let ids = ids {
            service.loadCorrections(ids: ids, callback: callback)
        } else {
            service.loadCorrections(pointId: point.id, callback: callback)
        }
        
    }
}

extension CorrectionListViewController: UITableViewDataSource, UITableViewDelegate {

    var cellId: String {
        "CorrectionCell"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellId,
            for: indexPath
        ) as! CorrectionCell
        
        cell.point = point
        cell.correction = corrections[indexPath.row]
        cell.configure()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        corrections.count
    }
}
