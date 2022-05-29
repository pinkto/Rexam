//
//  MainScreenViewController.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 27.04.2022.
//

import UIKit

// TODO: Caching

class MainScreenViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    private var cells = [
        ExamViewCellViewModel(
            title: "Название дисциплины",
            score: 56,
            timeStart: "Начало: 26.02.22 10:00"
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Экзамены"
        configureNavigationBar()
        configureTableView()
    }
    
    @objc func popViewController(animated: Bool) -> UIViewController? {
        let loginViewController = LoginViewConroller()
        return loginViewController
    }
    
    private func configureNavigationBar() {
        let label = UILabel()
        label.text = "Экзамены"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        navigationItem.titleView = label
        
        
        navigationItem.hidesBackButton = true
        
        
        let back = UIImage(named: "Exit")?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: back, style:.plain, target: nil, action: #selector(popViewController))
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "ExamViewCell", bundle: nil), forCellReuseIdentifier: "examCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //    var counter = 30
    //
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    //    }
    //
    //
    //
    //    @objc func updateCounter() {
    //        //example functionality
    //        if counter > 0 {
    //            print("\(counter) seconds to the end of the world")
    //            counter -= 1
    //        }
    //    }
    
}

extension MainScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "examCell", for: indexPath) as! ExamViewCell
        cell.configure(with: cells[indexPath.row])
        return cell
    }
}

extension MainScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ExaminationTicketViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
