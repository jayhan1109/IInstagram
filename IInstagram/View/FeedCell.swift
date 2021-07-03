//
//  FeedCell.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-02.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemPurple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
