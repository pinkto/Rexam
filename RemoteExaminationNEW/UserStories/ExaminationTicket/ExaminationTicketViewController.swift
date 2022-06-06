//
//  ExaminationTicketViewController.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 27.04.2022.
//

import Moya
import UIKit

final class ExaminationTicketViewController: UIViewController {
    
    // Outlets
    @IBOutlet private var tableView: UITableView!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var timerWrapperView: UIView!
    
    // Private dependencies
    private let examInfo: ExamInfo
    private var examQuestions: [ExamQuestion] = []
    
    // MARK: Init
    
    init(examInfo: ExamInfo) {
        self.examInfo = examInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadExamQuestions()
    }
    
    private func configureNavigationBar() {
        title = "Билет"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "ExaminationTicketViewCell", bundle: nil), forCellReuseIdentifier: "examinationTicketCell")
        tableView.dataSource = self
        tableView.delegate = self
        timerWrapperView.layer.cornerRadius = 4
    }
}

// MARK: - ExaminationTicketViewController

extension ExaminationTicketViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        examQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "examinationTicketCell", for: indexPath) as! ExaminationTicketViewCell
        let question = examQuestions[indexPath.row]
        cell.configure(
            with: ExaminationTicketViewCellModel(
                title: question.task.text,
                assessmentStatusModel: AssessmentStatusViewModel(
                    status: AssesmentStatus(from: question.state),
                    questionCurrentRating: examInfo.examRule.singleExerciseDefaultRating,
                    questionMaximumRating: 10
                )
            )
        )
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ExaminationTicketViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = AnswerToQuestionViewController(examQuestion: examQuestions[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Network

private extension ExaminationTicketViewController {
    
    func loadExamQuestions() {
        perfromLoadExamsQuestionsRequest { [weak self] result in
            switch result {
            case let .success(examQuestions):
                self?.examQuestions = examQuestions
                self?.tableView.reloadData()
                
            case let .failure(error):
                self?.showRetryAlert(
                    message: error.localizedDescription,
                    onOkAction: nil,
                    onRetryAction: { [weak self] in
                        self?.loadExamQuestions()
                    }
                )
            }
        }
    }
    
    func perfromLoadExamsQuestionsRequest(completion: @escaping (Result<[ExamQuestion], Error>) -> Void) {
        
        let xAccessToken = XAccessTokenService.shared.token
        let target = ExamsAPITarget(
            endpoint: .production,
            route: .examQuestionsList(ExamQuestionsListRequest(
                examId: examInfo.id,
                token: xAccessToken
            ))
        )
        
        let provider = MoyaProvider<ExamsAPITarget>()
        
        provider.request(target) { result in
            switch result {
            case let .success(response):
                guard let examQuestions = try? response.map([ExamQuestion].self) else {
                    completion(.failure(ExamsAPIError.wrongExamInfoDecode))
                    return
                }
                completion(.success(examQuestions))
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
