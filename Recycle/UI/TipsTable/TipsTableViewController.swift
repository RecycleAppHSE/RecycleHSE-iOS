//
//  TipsTableViewController.swift
//  Recycle
//
//  Created by Babaev Mikhail on 15.12.2020.
//

import UIKit


class TipsTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @Inject var service: TipService
    
    var tipCollections: [TipsCollection] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.loadTipsCollections { [weak self] result in
            switch result {
            case .success(let collections):
                self?.tipCollections = collections
                self?.tableView.reloadData()
            case .failure(let error):
                self?.show(error: error)
            }
        }
    }
}

extension TipsTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TipsCell") as! TipsTableViewCell
        
        let tips = tipCollections[indexPath.row]
        cell.configure(tips: tips)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tipCollections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tipsCollection = tipCollections[indexPath.row]
        
        service.loadTips(collectionId: tipsCollection.id) { [weak self] result in
            switch result {
            case .success(let tips):
                self?.show(tips: tips, title: tipsCollection.title)
            case .failure(let error):
                self?.show(error: error)
            }
        }
    }
    
    func show(tips: [Tip], title: String) {
        let vc = TipsContainerViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
        
        vc.title = title
        vc.orderedViewControllers = tips.map {
            let page: TipPageViewController = create()
            page.tip = $0
            return page
        }
        
        vc.orderedViewControllers.append(contentsOf: tips.map {
            let page: TipPageViewController = create()
            page.tip = $0
            return page
        })
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
