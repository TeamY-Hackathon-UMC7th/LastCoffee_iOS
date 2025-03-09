//
//  Endpoint.swift
//  LastCoffee
//
//  Created by 김도연 on 2/26/25.
//

import UIKit
import Moya

public enum NoteEndpoint {
    case getAllNotes(page: Int, size: Int)
    case postNewNote(data : NewNoteDTO)
    case getNoteDetail(noteId: Int)
    case deleteNote(noteId: Int)
}

extension NoteEndpoint: TargetType {
    public var baseURL: URL {
        guard let url = URL(string: API.noteURL) else {
            fatalError("noteURL 오류")
        }
        return url
    }
    
    public var path: String {
        switch self {
        case .getNoteDetail(let id), .deleteNote(let id) :
            return "/\(id)"
        default :
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .postNewNote :
            return .post
        case .deleteNote :
            return .delete
        default :
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .getAllNotes(let page, let size) :
            return .requestParameters(parameters: ["page": page, "size": size], encoding: URLEncoding.queryString)
        case .postNewNote(let data) :
            return .requestJSONEncodable(data)
        default :
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        let headers: [String: String] = [
            "Content-type": "application/json"
        ]
        return headers
    }
}

