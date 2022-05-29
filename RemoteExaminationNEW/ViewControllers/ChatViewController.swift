//
//  ChatViewController.swift
//  RemoteExaminationNEW
//
//  Created by Anna Abdeeva on 27.04.2022.
//

import MessageKit
import UIKit

final class ChatViewController: MessagesViewController, MessagesDisplayDelegate, MessagesLayoutDelegate {
    
    private let sender = ChatSender(displayName: "Борис")
    private let messages = [
        ChatMessage(
            sender: ChatSender(displayName: "Преподаватель"),
            kind: .text("Здравствуйте, студент!")
        ),
        ChatMessage(
            sender: ChatSender(displayName: "Преподаватель"),
            kind: .text("К сожалению, в вашем экзаменационном билете найдена ошибка.")
        ),
        ChatMessage(
            sender: ChatSender(displayName: "Преподаватель"),
            kind: .text("Прошу прощения, в течение 5 минут я заменю Ваш билет.")
        ),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
}

extension ChatViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        sender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        messages.count
    }
}

struct ChatMessage: MessageType {
    let sender: SenderType
    let messageId: String = UUID().uuidString
    let sentDate: Date = Date.now
    let kind: MessageKind
}

struct ChatSender: SenderType {
    let senderId: String = UUID().uuidString
    let displayName: String
}


