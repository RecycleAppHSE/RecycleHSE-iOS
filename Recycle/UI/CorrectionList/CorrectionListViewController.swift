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
    @Inject var userService: UserService
    
    var point: RecyclePoint?
    var user: User?
    
    var ids: [Int]? = nil
    
    var corrections: [Correction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isUserMode {
            navigationItem.rightBarButtonItem = nil
        }
        
        let nib = UINib(nibName: "CorrectionCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        
        userService.getUser { [weak self] result in
            self?.user = result.value
            self?.loadCorrections()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func edit() {
        let isEditing = !tableView.isEditing
        tableView.setEditing(isEditing, animated: true)
        
        let title = tableView.isEditing ? "Done" : "Edit"
        editButton.title = title
    }
    
    func loadCorrections() {
        let callback: ResultCallback<[Correction]> = { [weak self] result in
            switch result {
            case .success(let corrections):
                self?.corrections = corrections.sorted(by: {
                    $0.submitTime > $1.submitTime
                })
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
        cell.point = point ?? pointService.point(with: correction.pointId)
        cell.correction = correction
        cell.configure()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        corrections.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let correction = corrections[indexPath.row]
        guard isUserMode, correction.status == .inProgress else {
            return false
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let correction = corrections[indexPath.row]
        guard isUserMode, correction.status == .inProgress else {
            return nil
        }
        
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete\ncorrection") { [weak self] (action, indexPath) in
            
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
    
    var isUserMode: Bool {
        ids != nil
    }
}
