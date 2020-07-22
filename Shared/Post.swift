//
//  Post.swift
//  Example
//
//  Created by Abdullah Alhaider on 21/08/2019.
//  Copyright © 2019 Abdullah Alhaider. All rights reserved.
//

import NetworkKit

public struct Posts: Codable {
    let id: Int?
    let userId: Int?
    let title: String?
    let body: String?
}

public extension Posts {
    
    static func getPostsFromJsonFile(completion: @escaping DecodedResult<[Posts]>) {
        Router.Placeholder.postsFromJsonFile.request(completion: completion)
    }
    
    static func getPostsFromTextFile(completion: @escaping DecodedResult<[Posts]>) {
        Router.Placeholder.postsFromTxtFile.request(completion: completion)
    }
    
    static func getPosts(completion: @escaping DecodedResult<[Posts]>) {
        Router.Placeholder.posts.request(completion: completion)
    }
    
    static func getPost(with id: Int, completion: @escaping DecodedResult<[Posts]>) {
        Router.Placeholder.post(withId: id).request(completion: completion)
    }
    
    static func getStringPosts(completion: @escaping StringResult) {
        Router.Placeholder.posts.request(completion: completion)
    }
    
    static func pushNewPost(userId: Int, id: Int, title: String, body: String, completion: @escaping DecodedResult<Posts>) {
        Router.Placeholder.pushPost(userId: userId, id: id, title: title, body: body).request(completion: completion)
    }
    
    static func updatePost(post id: Int, title: String, completion: @escaping DecodedResult<Posts>) {
        Router.Placeholder.updatePost(postId: id, newTitle: title).request(completion: completion)
    }
    
    static func deletePost(with id: Int, completion: @escaping DecodedResult<Empty>) {
        Router.Placeholder.deletePost(id: id).request(completion: completion)
    }
}

