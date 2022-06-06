//
//  ExamsAPIError.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 04.06.2022.
//

import Foundation

enum ExamsAPIError: Error {
    
    /// Неудачный логин: убедитесь в правильности модели ответа,
    /// либо что пользователь ввел правильные креды
    case wrongLogin
    
    /// Ошибка кодирования кредов пользователя в base64
    case credentialsEncodeError
    
    /// Не удалось декодировать информацию с экзаменами
    case wrongExamInfoDecode
    
    /// Не удалось подгрузить чат
    case wrongChatRequest

}

// MARK: - LocalizedError

extension ExamsAPIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .wrongLogin:
            return "Не удалось войти в систему"
            
        case .credentialsEncodeError:
            return "Не удалось закодировать данные пользователя"
            
        case .wrongExamInfoDecode:
            return "Не удалось загрузить информацию о экзаменах"
            
        case .wrongChatRequest:
            return "Не удалось загрузить сообщения чата"
        }
    }
}
