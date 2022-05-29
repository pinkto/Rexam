//
//  AnswerToQuestionViewController.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 27.04.2022.
//

import UIKit

private extension String {
    static let message = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    static let time = "10:50"
    static let teacher = "Преподаватель"
    static let student = "Студент"
}

final class AnswerToQuestionViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let cells: [ChatTableViewCellType] = [
        .message(MessageViewCellModel(
            title: .student,
            message: .message,
            time: .time)),
        .message(MessageViewCellModel(
            title: .teacher,
            message: .message,
            time: .time)),
        .file(FileViewCellModel(
            title: .teacher,
            image: UIImage(named: "Exit")!,
            time: .time))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}

private extension AnswerToQuestionViewController {
    
    func configureTableView() {
        tableView.register(UINib(nibName: "FileCellView", bundle: nil), forCellReuseIdentifier: "fileCell")
        tableView.register(UINib(nibName: "MessageCellView", bundle: nil), forCellReuseIdentifier: "messageCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

enum ChatTableViewCellType {
    case file(FileViewCellModel)
    case message(MessageViewCellModel)
}

extension AnswerToQuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cells[indexPath.row] {
        case let .file(model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "fileCell", for: indexPath) as! FileViewCell
            cell.configure(with: model)
            return cell
            
        case let .message(model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageViewCell
            cell.configure(with: model)
            return cell
        }
    }
}

extension AnswerToQuestionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ChatViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
