//
//  NewsTableViewController.swift
//  KoreaNews
//
//  Created by Suhyoung Eo on 2022/01/16.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {

    let disposeBag = DisposeBag()
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchNews()
    }
    
    private func fetchNews() {
        
        guard let url = URL(string: K.newsApiUrl) else { return }
        
        let resource = Resource<ArticleModel>(url: url)
        
        URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)  // DispatchQueue.main.async 와 같은 역할
            .subscribe(onNext: { articleModel in
                self.articleListVM = ArticleListViewModel(articleModel.articles)
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListVM == nil ? 0 : articleListVM.articlesVM.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("Could not find ArticleTableViewCell")
        }
        
        cell.selectionStyle = .none
        
        let article = articleListVM.articleAt(indexPath.row)
        
        article.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        article.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        return cell
    }
}
