//
//  ViewController.swift
//  CameraApp
//
//  Created by Suhyoung Eo on 2022/01/13.
//

import UIKit
import RxSwift 

class ViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var applyFilterButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navigationVC = segue.destination as? UINavigationController,
              let destinationVC = navigationVC.viewControllers.first as? PhotoCollectionViewController
        else {
            fatalError("Could not found segue destination")
        }
        
        destinationVC.selectedPhoto.subscribe { [weak self] photo in
            
            DispatchQueue.main.async {
                self?.updateUI(image: photo)
            }
            
        }.disposed(by: disposeBag)
    }
    
    @IBAction func applyFilterButton(_ sender: Any) {
        
        guard let sourceImage = photoImageView.image else { return }
        
        FilterService().applyFilter(to: sourceImage)
            .subscribe { image in
                
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
                
            }.disposed(by: disposeBag)
    }
    
    
    private func updateUI(image: UIImage) {
        photoImageView.image = image
        applyFilterButton.isHidden = false
    }
    
}

