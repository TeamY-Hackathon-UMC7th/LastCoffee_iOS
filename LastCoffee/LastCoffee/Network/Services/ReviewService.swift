//
//  CoffeeService.swift
//  LastCoffee
//
//  Created by 김도연 on 1/12/25.
//

import Foundation
import Moya

public final class NoteService : NetworkManager {
    typealias Endpoint = NoteEndpoint
    
    // MARK: - Provider 설정
    let provider: MoyaProvider<NoteEndpoint>
    
    public init(provider: MoyaProvider<NoteEndpoint>? = nil) {
        // 플러그인 추가
        let plugins: [PluginType] = [
            BearerTokenPlugin(),
            NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)) // 로그 플러그인
        ]
        
        // provider 초기화
        self.provider = provider ?? MoyaProvider<NoteEndpoint>(plugins: plugins)
    }
    
    //MARK: - API funcs
    /// 노트 리스트 받아오기 페이지네이션 API
    public func getAllNoteList(page: Int, size: Int = 10) async throws -> GetAllNotesDTO {
        return try await requestAsync(target: .getAllNotes(page: page, size: size), decodingType: GetAllNotesDTO.self)
    }
    
    /// 개별 노트 정보 받아오기 API
    public func getNote(noteId: Int) async throws -> NoteDTO {
        return try await requestAsync(target: .getNoteDetail(noteId: noteId), decodingType: NoteDTO.self)
    }
    
    /// 노트 삭제 API
    public func deleteNote(noteId: Int) async throws -> String {
        return try await requestAsync(target: .deleteNote(noteId: noteId))
    }
    
    // 노트 생성 API
    
}
