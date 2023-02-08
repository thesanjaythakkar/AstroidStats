//
//  StatCell.swift
//  AsteroidState
//
//  Created by Sanjay Thakkar on 07/02/23.
//

import UIKit

class StatCell: UITableViewCell {

    //MARK: -  Outlets
    @IBOutlet var lblType: UILabel!
    @IBOutlet var lblID: UILabel!
    @IBOutlet var lblTypeValue: UILabel!
    @IBOutlet var lblDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ obj:eTypeOfAstroid) {
        var dateValue:String?
        var type:String?
        var idValue:String?
        var typeValue:String?
        type = obj.title
        switch obj {
        case .fastest(let date, let speed, let id):
            dateValue = date
            idValue = "ID:\(id)"
            typeValue = "\(speed) km/s"
            break
        case .closes(let date, let distance, let id):
            dateValue = date
            idValue = "ID:\(id)"
            typeValue = "\(distance) km"
            break
        case .average(let diameter):
            idValue = "Diameter:"
            typeValue = "\(diameter)"
            break
        }
        
        lblID.text = idValue ?? ""
        lblType.text = type ?? ""
        lblDate.text = dateValue ?? ""
        lblTypeValue.text = typeValue ?? ""
    }

}
