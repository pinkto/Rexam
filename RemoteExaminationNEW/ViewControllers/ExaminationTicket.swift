//
//  ExaminationTicket.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 27.04.2022.
//

import UIKit

class ExaminationTicketViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    private var cells = [
        ExaminationTicketViewCellModel(title: "Вопрос #1")
    ]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "ExaminationTicketViewCell", bundle: nil), forCellReuseIdentifier: "examinationTicketCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ExaminationTicketViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "examinationTicketCell", for: indexPath) as! ExaminationTicketViewCell
        cell.configure(with: cells[indexPath.row])
        return cell
    }
}

extension ExaminationTicketViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = AnswerToQuestionViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
