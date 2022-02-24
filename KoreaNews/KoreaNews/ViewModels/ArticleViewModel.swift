//
//  ArticleViewModel.swift
//  KoreaNews
//
//  Created by Suhyoung Eo on 2022/01/19.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleListViewModel {
    
    let articlesVM: [ArticleViewModel]
    
    init(_ articles: [Articles]) {
        self.articlesVM = articles.compactMap({ article in
            return ArticleViewModel.init(article)
        })
    }
    
    func articleAt(_ index: Int) -> ArticleViewModel {
        return articlesVM[index]
    }
}

struct ArticleViewModel {
    
    let article: Articles
    
    init(_ article: Articles) {
        self.article = article
    }
    
    var title: Observable<String> {
        return Observable<String>.just(article.title ?? "")
    }
    
    var description: Observable<String> {
        return Observable<String>.just(article.description ?? "")
    }
}
