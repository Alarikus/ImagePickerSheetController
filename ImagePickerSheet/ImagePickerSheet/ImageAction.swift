//
//  ImageAction.swift
//  ImagePickerSheet
//
//  Created by Laurin Brandner on 24/05/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import Foundation

public typealias Title = Int -> String

public class ImageAction {
    
    public typealias Handler = (ImageAction) -> ()
    public typealias SecondaryHandler = (ImageAction, Int) -> ()
    
    let title: String
    let secondaryTitle: Title
    
    let handler: Handler?
    let secondaryHandler: SecondaryHandler?
    
    public convenience init(title: String, secondaryTitle: String? = nil, handler: Handler? = nil, var secondaryHandler: SecondaryHandler? = nil) {
        if let handler = handler where secondaryTitle == nil && secondaryHandler == nil {
            secondaryHandler = { action, _ in
                handler(action)
            }
        }
        
        self.init(title: title, secondaryTitle: secondaryTitle.map { string in { _ in string }} ?? { _ in title }, handler: handler, secondaryHandler: secondaryHandler)
    }
    
    public init(title: String, secondaryTitle: Title?, handler: Handler? = nil, secondaryHandler: SecondaryHandler? = nil) {
        self.title = title
        self.secondaryTitle = secondaryTitle ?? { _ in title }
        self.handler = handler
        self.secondaryHandler = secondaryHandler
    }
    
    func handle(numberOfPhotos: Int = 0) {
        if numberOfPhotos > 0 {
            secondaryHandler?(self, numberOfPhotos)
        }
        else {
            handler?(self)
        }
    }
    
}

func ?? (left: Title?, right: Title) -> Title {
    if let left = left {
        return left
    }
    
    return right
}