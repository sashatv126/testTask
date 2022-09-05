//
//  TabBarIndex.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 04.09.2022.
//

enum TabBarIndex {
    case photo
    case favourite

    init?(index: Int) {
        switch index {
        case 0:
            self = .photo
        case 1:
            self = .favourite
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .photo:
            return "Photos"
        case .favourite:
            return "Favourite"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .photo:
            return 0
        case .favourite:
            return 1
        }
    }
    
    func pageImage() -> String? {
        switch self {
        case .photo:
            return "photo.on.rectangle.angled"
        case .favourite:
            return "heart.circle"
        }
    }
}
