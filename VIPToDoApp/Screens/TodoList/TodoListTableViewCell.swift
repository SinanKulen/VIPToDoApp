//
//  TodoListTableViewCell.swift
//  VIPToDoApp
//
//  Created by Sinan Kulen on 11.02.2022.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {

    @IBOutlet var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(title: String)
    {
        lblTitle.text = title
    }
}
