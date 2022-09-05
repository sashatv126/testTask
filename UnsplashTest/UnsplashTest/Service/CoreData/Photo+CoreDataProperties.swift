//
//  Photo+CoreDataProperties.swift
//  UnsplashTest
//
//  Created by Александр Александрович on 05.09.2022.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var url: String?
    @NSManaged public var author: String?
    @NSManaged public var created: String?
    @NSManaged public var location: String?
    @NSManaged public var downloads: Int32
    @NSManaged public var flag: Bool

}

extension Photo : Identifiable {

}
