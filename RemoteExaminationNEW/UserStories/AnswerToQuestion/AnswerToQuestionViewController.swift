//
//  AnswerToQuestionViewController.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 27.04.2022.
//

import Moya
import UIKit

private extension String {
    static let message = "Базовые и производственные типы данных. Иерархия определения типов данных и вложенности компонент переменных. Контекстный способ определения типа данных в Си. Абстрактный тип данных. Спецификация typedef."
    static let time = "10:50"
    static let teacher = "Преподаватель"
    static let student = "Студент"
}

final class AnswerToQuestionViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sendIcon: UIImageView!
    @IBOutlet var messageTextField: UITextField!
    
    // Private dependencies
    private let examQuestion: ExamQuestion
    private var messages: [Message] = []
    private var cells: [ChatTableViewCellType] = []
    
    init(examQuestion: ExamQuestion) {
        self.examQuestion = examQuestion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
        getAllMessages()
    }
    
    private func configureNavigationBar() {
        title = examQuestion.task.text
    }
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.cells.count - 1, section: 0)
            if indexPath.row > 0 {
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
}

private extension AnswerToQuestionViewController {
    
    func configureTableView() {
        tableView.register(UINib(nibName: "FileCellView", bundle: nil), forCellReuseIdentifier: "fileCell")
        tableView.register(UINib(nibName: "MessageCellView", bundle: nil), forCellReuseIdentifier: "messageCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
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
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Network

private extension AnswerToQuestionViewController {
    
    func sendMessage() {
        let answerId = examQuestion.id
        let token = XAccessTokenService.shared.token
        let message = messageTextField.text ?? ""
        let requestBody = SendMessageRequest(
            answerId: answerId,
            token: token,
            message: message
        )
        let route: StudentAPIRoute = .sendMessage(requestBody)
        
        performRequest(MessageList.self, route: route) { [weak self] result in
            switch result {
            case let .success(response):
                break
                
            case let .failure(error):
                break
            }
        }
    }
    
    func getAllMessages() {
        let answerId = examQuestion.id
        let token = XAccessTokenService.shared.token
        let requestBody = GetMessagesRequest(
            answerId: answerId,
            token: token
        )
        let route: StudentAPIRoute = .getMessages(requestBody)
        
        performRequest(MessageList.self, route: route) { [weak self] result in
            switch result {
            case let .success(response):
                self?.cells = response.content.map {
                    ChatTableViewCellType.message(MessageViewCellModel(
                        title: "Преподаватель",
                        message: $0.text,
                        time: DateFormatter.makeTime(from: $0.sendTime)
                    ))
                }
                self?.tableView.reloadData()
                self?.scrollToBottom()
                
            case let .failure(error):
                self?.showRetryAlert(
                    message: error.localizedDescription,
                    onOkAction: nil,
                    onRetryAction: { [weak self] in
                        self?.getAllMessages()
                    }
                )
            }
        }
    }
    
    func getSendersName() -> {
        
    }
    
    func performRequest<T: Codable>(
        _ type: T.Type,
        route: StudentAPIRoute,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let target = ExamsAPITarget(
            endpoint: .production,
            route: route
        )
        let provider = MoyaProvider<ExamsAPITarget>()
        
        provider.request(target) { result in
            switch result {
            case let .success(response):
                guard let result = try? response.map(T.self) else {
                    completion(.failure(ExamsAPIError.wrongChatRequest))
                    return
                }
                completion(.success(result))
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
