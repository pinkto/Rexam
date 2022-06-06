//
//  ExamsAPITarget.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 19.05.2022.
//

import Foundation
import Moya

enum StudentAPIEndpoint {
    case production
    
    var url: URL {
        switch self {
        case .production: return URL(string: "http://217.71.129.139:4502")!
        }
    }
}

enum StudentAPIRoute {
    case ticket(String)
    case login(String)
    case allExams(String)
    case examQuestionsList(ExamQuestionsListRequest)
    case sendMessage(SendMessageRequest)
    case getMessages(GetMessagesRequest)
}

// MARK: - Target

struct ExamsAPITarget: TargetType {
    let endpoint: StudentAPIEndpoint
    let route: StudentAPIRoute
    
    var baseURL: URL {
        endpoint.url
    }
    
    var path: String {
        switch route {
        case .ticket:
            return "/student/ticket"
            
        case .login:
            return "/login"
            
        case .allExams:
            return "/students/exam-infos"
            
        case let .examQuestionsList(params):
            return "/student-rating/\(params.examId)/answer"
            
        case let .sendMessage(request):
            return "/answers/\(request.answerId)/message"
            
        case let .getMessages(request):
            return "/answers/\(request.answerId)/message"
        }
    }
    
    var method: Moya.Method {
        switch route {
        case .ticket: return .get
        case .login: return .post
        case .allExams: return .get
        case .examQuestionsList: return .get
        case .sendMessage: return .post
        case .getMessages: return .get
        }
    }
    
    var task: Task {
        switch route {
        case .ticket: return .requestPlain
        case .login: return .requestPlain
        case .allExams: return .requestPlain
        case .examQuestionsList: return .requestPlain
        case let .sendMessage(request): return .requestJSONEncodable(request.message)
        case let .getMessages(request): return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch route {
        case let .login(credentials): return ["X-Authentication": credentials]
        case let .ticket(token): return ["X-Access-Token": token]
        case let .allExams(token): return ["X-Access-Token": token]
        case let .examQuestionsList(params): return ["X-Access-Token": params.token]
        case let .sendMessage(request): return ["X-Access-Token": request.token]
        case let .getMessages(request): return ["X-Access-Token": request.token]
        }
    }
}
