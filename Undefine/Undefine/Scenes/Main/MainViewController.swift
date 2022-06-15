//
//  MainViewController.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

import UIKit
import Reusable
import SDWebImage
import RxSwift
import RxCocoa
import MGArchitecture

final class MainViewController: UIViewController, Bindable {
    
    // MARK: - IBOutlets
    
    // MARK: - Properties

    var viewModel: MainViewModel!
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configView()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        title = "Main"
    }
    
    func bindViewModel() {
        let input = MainViewModel.Input(
            load: Driver.just(())
        )
        
        let output = viewModel.transform(input, disposeBag: disposeBag)
    }
}

// MARK: - StoryboardSceneBased
extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
