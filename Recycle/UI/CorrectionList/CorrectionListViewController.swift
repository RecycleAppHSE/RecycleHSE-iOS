//
//  CorrectionListViewController.swift
//  Recycle
//
//  Created by Babaev Mikhail on 13.12.2020.
//

import UIKit

class CorrectionListViewController: UIViewController {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    @Inject var service: CorrectionService
    @Inject var pointService: PointService
    
    var point: RecyclePoint?
    
    var ids: [Int]? = nil
    
    var corrections: [Correction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CorrectionCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        
        loadCorrections()
    }
    
    @IBAction func edit() {
        let isEditing = !tableView.isEditing
        tableView.setEditing(isEditing, animated: true)
        
        let title = tableView.isEditing ? "Готово" : "Править"
        editButton.title = title
    }
    
    func loadCorrections() {
        let callback: ResultCallback<[Correction]> = { [weak self] result in
            switch result {
            case .success(let corrections):
                self?.corrections = corrections
                self?.tableView.reloadData()
                self?.view.layoutIfNeeded()
            case .failure(let error):
                self?.show(error: error)
            }
        }
        
        if let ids = ids {
            service.loadCorrections(ids: ids, callback: callback)
        } else if let point = point {
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
        
        let correction = corrections[indexPath.row]
        cell.point = point ?? pointService.point(with: correction.id)
        cell.correction = correction
        cell.configure()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        corrections.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let correction = corrections[indexPath.row]
        
        let delete = UITableViewRowAction(style: .destructive, title: "Удалить\nисправление") { [weak self] (action, indexPath) in
            
            self?.service.delete(id: correction.id) { result in
                switch result {
                case .success:
                    self?.corrections.remove(at: indexPath.row)
                    self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                case .failure(let error):
                    self?.show(error: error)
                }
            }
        }

        return [delete]
    }
}
