//
//  MainScreenViewController.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 27.04.2022.
//

import Moya
import UIKit

// TODO: Caching

class MainScreenViewController: UIViewController {
    
    // Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var examsListsSegmentedControl: UISegmentedControl!
    
    // Private properties
    private var cells: [ExamInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Экзамены"
        configureNavigationBar()
        configureTableView()
        loadExams()
    }
    
    @objc func didTapExitButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureNavigationBar() {
        navigationController?.title = "Экзамены"
        navigationItem.hidesBackButton = true
        
        let back = UIImage(named: "Exit")?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: back, style: .plain, target: self, action: #selector(didTapExitButton(_:))
        )
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "ExamViewCell", bundle: nil), forCellReuseIdentifier: "examCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - MainScreenViewController

extension MainScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "examCell", for: indexPath) as! ExamViewCell
        cell.configure(with: ExamViewCellViewModel(from: cells[indexPath.row]))
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = ExaminationTicketViewController(examInfo: cells[indexPath.row])
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Network

private extension MainScreenViewController {
    
    func loadExams() {
        perfromLoadExamsRequest { [weak self] result in
            switch result {
            case let .success(exams):
                self?.cells = exams
                self?.tableView.reloadData()
                
            case let .failure(error):
                self?.showRetryAlert(
                    message: error.localizedDescription,
                    onOkAction: nil,
                    onRetryAction: { [weak self] in
                        self?.loadExams()
                    }
                )
            }
        }
    }
    
    func perfromLoadExamsRequest(completion: @escaping (Result<[ExamInfo], Error>) -> Void) {
        let xAccessToken = XAccessTokenService.shared.token
        let target = ExamsAPITarget(endpoint: .production, route: .allExams(xAccessToken))
        
        let provider = MoyaProvider<ExamsAPITarget>()
        
        provider.request(target) { result in
            switch result {
            case let .success(response):
                guard let examInfo = try? response.map([ExamInfo].self) else {
                    completion(.failure(ExamsAPIError.wrongExamInfoDecode))
                    return
                }
                completion(.success(examInfo))

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
