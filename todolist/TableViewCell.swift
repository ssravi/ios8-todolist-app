//
//  TableViewCell.swift
//  todolist
//
//  Created by Tristan Himmelman on 2014-10-09.
//  Copyright (c) 2014 Ravi Teja Vadrevu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    class func loadFromNib() -> TableViewCell {
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        let nibContentsArray = nib.instantiateWithOwner(self, options: nil) as NSArray
        return nibContentsArray.objectAtIndex(0) as TableViewCell
    }
    
    func heightWith(string: String, width:CGFloat) -> CGFloat {
        populateCell(string)
        
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
        
        self.bounds = CGRectMake(0.0, 0.0, width, self.bounds.size.height);
        
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        return size.height;
    }
    
    func populateCell(string: String){
        label.text = string
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
        // need to use to set the preferredMaxLayoutWidth below.
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
        
        // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
        // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
        self.label.preferredMaxLayoutWidth = CGRectGetWidth(self.label.frame);
    }
}
