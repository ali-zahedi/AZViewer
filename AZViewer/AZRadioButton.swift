//
//  AZRadioButton.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/23/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public class AZRadioButton: AZCheckBox{
    
}

extension AZRadioButton{
    
    // override table view selected
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        for (index, d) in self.data.value.enumerated(){
            
            // check current tap index
            if index == indexPath.row{
            
                if d.isActive == false{
                    
                    d.isActive = true
                }
                continue
            }
            
            // deactive other box
            if d.isActive {
                
                d.isActive = false
            }
        }
    }
}
