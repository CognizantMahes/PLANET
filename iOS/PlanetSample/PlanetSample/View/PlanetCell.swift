//
//  PlanetCell.swift
//  PlanetSample
//
//  Created by C, Maheswaran (Cognizant) on 20/06/21.
//

import Foundation
import UIKit

class PlanetCell: UITableViewCell {
    var planet: PlanetViewModel!{
        didSet{
            textLabel?.text = planet.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
