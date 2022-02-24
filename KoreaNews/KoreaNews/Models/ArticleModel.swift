//
//  ArticleModel.swift
//  KoreaNews
//
//  Created by Suhyoung Eo on 2022/01/17.
//

import Foundation

struct ArticleModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [Articles]
}

struct Articles: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

//extension ArticleModel {
//    static var resourceURL: Resource<ArticleModel> {
//        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=kr&pageSize=100&apiKey=/* API Key */")!
//        return Resource(url: url)
//    }
//}
