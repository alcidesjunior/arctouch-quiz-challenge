//
//  TableViewCell.swift
//  ArctouchQuizChallenge
//
//  Created by Alcides Junior on 13/01/20.
//  Copyright © 2020 Alcides Junior. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        titleLabel
            .magicCenterY(0, safeAreaLayoutGuide.centerYAnchor)
            .magicLeading(16, safeAreaLayoutGuide.leadingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
