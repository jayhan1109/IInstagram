//
//  ProfileHeader.swift
//  IInstagram
//
//  Created by Jeongho Han on 2021-07-05.
//

import UIKit
import SDWebImage

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    var profileHeaderModel: ProfileHeaderModel? {
        didSet {
            configure()
        }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        iv.clipsToBounds = true
        return iv
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var editProfileFollowButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit Profile", for: .normal)
        btn.layer.cornerRadius = 3
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 0.5
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(handlerEditProfileFollowTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var postsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedStatText(value: 5, label: "posts")
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedStatText(value: 2, label: "followers")
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedStatText(value: 1, label: "following")
        return label
    }()
    
    private let gridButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        btn.tintColor = .link
        return btn
    }()
    
    private let listButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        btn.tintColor = .lightGray
        return btn
    }()
    
    private let bookmarkButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        btn.tintColor = .lightGray
        return btn
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 12)
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        
        addSubview(nameLabel)
        nameLabel.anchor(top:profileImageView.bottomAnchor, paddingTop: 12)
        nameLabel.centerX(view: profileImageView)
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 24, paddingRight: 24)
        
        let stack = UIStackView(arrangedSubviews: [postsLabel, followersLabel,followingLabel])
        stack.distribution = .fillEqually
        stack.axis = .horizontal
            
        addSubview(stack)
        stack.centerY(view: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12, height: 50)
        
        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .lightGray
        
        let buttonStack = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        buttonStack.distribution = .fillEqually
        
        addSubview(buttonStack)
        addSubview(topDivider)
        addSubview(bottomDivider)
        
        buttonStack.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        
        topDivider.anchor(top: buttonStack.topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        bottomDivider.anchor(top: buttonStack.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func handlerEditProfileFollowTapped(){
        print("edit profile tapped")
    }
    
    // MARK: - Helpers
    
    func configure(){
        guard let profileHeaderModel = profileHeaderModel else { return }
        
        nameLabel.text = profileHeaderModel.fullname
        profileImageView.sd_setImage(with: profileHeaderModel.profileImageUrl, completed: nil)
        
        editProfileFollowButton.setTitle(profileHeaderModel.followButtonText, for: .normal)
        editProfileFollowButton.setTitleColor(profileHeaderModel.followButtonTextColor, for: .normal)
        editProfileFollowButton.backgroundColor = profileHeaderModel.followButtonBackgroundColor
    }
}
