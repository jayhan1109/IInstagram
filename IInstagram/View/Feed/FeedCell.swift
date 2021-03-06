//
//  FeedCell.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-02.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "baptist")
        return iv
    }()
    
    private lazy var usernameButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("venom", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return btn
    }()
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "dva")
        return iv
    }()
    
    private lazy var likeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    private lazy var commentButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    private lazy var shareButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "1 like"
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Some text caption for now.."
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2 days ago"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12, width: 40, height: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        addSubview(usernameButton)
        usernameButton.centerY(view: profileImageView,leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        configureActionButtons()
        
        addSubview(likesLabel)
        likesLabel.anchor(top: likeButton.bottomAnchor, left:leftAnchor, paddingTop: -4, paddingLeft: 8)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: likesLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left:leftAnchor, paddingTop: 8, paddingLeft: 8)
    }
    
    // MARK: - Actions
    
    @objc func didTapUsername(){
        print("hey")
    }
    
    // MARK: - Helpers
    
    func configureActionButtons(){
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: postImageView.bottomAnchor, width: 120, height: 50)
    }
}
