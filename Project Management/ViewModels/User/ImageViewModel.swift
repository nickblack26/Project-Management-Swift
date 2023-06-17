//
//  ProfileImageViewModel.swift
//  Project Management
//
//  Created by Nick on 12/22/22.
//

import SwiftUI
import CoreData

class ImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let manager = CoreDataManager.shared
    
    func imageToData(image: UIImage) {
        let jpegImageData = image.jpegData(compressionQuality: 1.0)
        let imageContext = ImageEntity(context: manager.context)
        imageContext.url = jpegImageData
        manager.saveData()
    }

    func fetchImage(user: UserEntity) {
        let imageRequest = NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
        imageRequest.predicate = NSPredicate(format: "user = %@", user)
        var tempImage: [ImageEntity]
        do {
            tempImage = try manager.context.fetch(imageRequest)
        } catch let error {
            print("Error fetching. \(error)")
            return
        }
        dataToImage(result: tempImage)
    }

    func dataToImage(result: [NSManagedObject]) {
        for data in result {
            let rawData = data.value(forKey: "image") as! Data
            self.image = UIImage(data: rawData)
        }
    }
    
}
