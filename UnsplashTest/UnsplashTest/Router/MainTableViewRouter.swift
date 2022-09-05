//
//  TabBarIndex.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

import UIKit

protocol TabRouterProtocol {
    var tabBarController: MainTabBarViewController { get set }
    
    func selectPage(_ index: TabBarIndex)
    func setSelectedIndex(_ index: Int)
    func currentPage() -> TabBarIndex?
    func create()
}

class TabRouter: NSObject, TabRouterProtocol {
    var navigationController: UINavigationController
    var tabBarController = MainTabBarViewController()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func currentPage() -> TabBarIndex? {
        TabBarIndex.init(index: tabBarController.selectedIndex)
        
    }
    
    func selectPage(_ index: TabBarIndex) {
        tabBarController.selectedIndex = index.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarIndex.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func create() {
        let pages: [TabBarIndex] = [.photo, .favourite]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: controllers)
    }
}

extension TabRouter {
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarIndex.photo.pageOrderNumber()
        navigationController.navigationBar.backgroundColor = .white
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ page: TabBarIndex) -> UINavigationController {
        navigationController.isNavigationBarHidden = true
        let navController = UINavigationController()
        navController.tabBarItem = UITabBarItem(title: page.pageTitleValue(),
                                                image: UIImage(systemName: page.pageImage() ?? "")?.withRenderingMode(.alwaysOriginal),
                                                tag: page.pageOrderNumber())
        
        switch page {
        case .photo:
            let vc1 = Builder.buildPhotoViewController()
            
            navController.pushViewController(vc1, animated: true)
        case .favourite:
            let vc2 = Builder.buildFavouriteViewController()
            
            navController.pushViewController(vc2, animated: true)
        }
        return navController
    }
}
