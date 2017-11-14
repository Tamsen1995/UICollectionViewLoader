//
//  ImageData.swift
//  UICollectionViewLoader
//
//  Created by Nguyen Tam Anh Bui on 11/2/17.
//  Copyright © 2017 Nguyen Tam Anh Bui. All rights reserved.
//


import Foundation

class ImageData {
    
    // the loadedCount variable is global for all instances of this class
    static var loadedCount : Int = 0
    
    // And array of images, also global to all instances of this class
    static var images: [(String, String)] = [
        ("Floating man", "https://www.nasa.gov/sites/default/files/images/576200main_s84-27017_full.jpg"),
        ("Dream car", "https://upload.wikimedia.org/wikipedia/commons/4/4d/NASA_Apollo_17_Lunar_Roving_Vehicle.jpg"),
        ("The shuttle", "https://apod.nasa.gov/apod/image/1408/shuttleapproaching_nasa_6048.jpg"),
        ("Spain from above", "https://www.nasa.gov/sites/default/files/thumbnails/image/14797031062_4cbe0f218f_o.jpg")
    ]
}
