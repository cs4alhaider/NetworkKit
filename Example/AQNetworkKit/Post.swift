//
//  Post.swift
//  AQNetworkKit_Example
//
//  Created by Abdullah Alhaider on 21/08/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import AQNetworkKit

public struct Posts: Codable {
    let id: Int?
    let userId: Int?
    let title: String?
    let body: String?
}

public extension Posts {
    
    static func getPostsFromJsonFile(completion: @escaping DecodedResult<[Posts]>) {
        Router.Placeholder.postsFromJsonFile.requestDecodedResult(completion: completion)
    }
    
    static func getPosts(completion: @escaping DecodedResult<[Posts]>) {
        Router.Placeholder.posts.requestDecodedResult(completion: completion)
    }
    
    static func getStringPosts(completion: @escaping StringResult) {
        Router.Placeholder.posts.requestStringResult(completion: completion)
    }
    
    static func pushNewPost(userId: Int, id: Int, title: String, body: String, completion: @escaping DecodedResult<Posts>) {
        Router.Placeholder.pushPost(userId: userId, id: id, title: title, body: body).requestDecodedResult(completion: completion)
    }
    
    static func updatePost(post id: Int, title: String, completion: @escaping DecodedResult<Posts>) {
        Router.Placeholder.updatePost(postId: id, newTitle: title).requestDecodedResult(completion: completion)
    }
    
    static func deletePost(with id: Int, completion: @escaping DecodedResult<Empty>) {
        Router.Placeholder.deletePost(id: id).requestDecodedResult(completion: completion)
    }
}

