//
//  Router+Placeholder.swift
//  AQNetworkKit_Example
//
//  Created by Abdullah Alhaider on 21/08/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import AQNetworkKit

extension Router {
    
    enum Placeholder: Endpoint {
        
        case posts
        case post(withId: Int)
        case postsFromJsonFile
        case postsFromTxtFile
        case pushPost(userId: Int, id: Int, title: String, body: String)
        case updatePost(postId: Int, newTitle: String)
        case deletePost(id: Int)
        
        var pathURL: Path {
            switch self {
            case .posts:
                return .url("/posts")
            case .post:
                return .url("/posts")
            case .postsFromJsonFile:
                return .bundle(fileName: "Posts", extension: .json)
            case .postsFromTxtFile:
                return .bundle(fileName: "Posts", extension: .txt)
            case .pushPost:
                return .url("/posts")
            case .updatePost(let postId, _):
                return .url("/posts/\(postId)")
            case .deletePost(let postId):
                return .url("/posts/\(postId)")
            }
        }
        
        var parameters: [String : Any]? {
            var params: [String: Any] = [:]
            switch self {
            case .posts:
                return nil
            case .post(let postId):
                params["id"] = postId
                return params
            case .postsFromJsonFile:
                return nil
            case .postsFromTxtFile:
                return nil
            case .pushPost(let userId, let id, let title, let body):
                params["userId"] = userId
                params["id"] = id
                params["title"] = title
                params["body"] = body
                return params
            case .updatePost(_, let title):
                params["title"] = title
                return params
            case .deletePost:
                return nil
            }
        }
        
        var headers: [String : String]? {
            return nil
        }
        
        var method: HTTPMethod {
            switch self {
            case .posts:
                return .get
            case .post:
                return .get
            case .postsFromJsonFile:
                return .get
            case .postsFromTxtFile:
                return .get
            case .pushPost:
                return .post
            case .updatePost:
                return .put
            case .deletePost:
                return .delete
            }
        }
        
        var isPrintable: Bool {
            return true // For all cases
        }
        
    }
}
