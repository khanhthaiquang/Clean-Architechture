//
//  OutlineTextfield+.swift
//  Undefine
//
//  Created by KhanhTQ on 31/05/2022.
//

import Foundation
import MaterialComponents

extension MDCOutlinedTextField {
    func initBasic(with Placeholder: String = "") {
        setOutlineColor(Constants.normalColor, for: .normal)
        setOutlineColor(Constants.normalColor, for: .editing)
        setNormalLabelColor(Constants.normalColorLabel, for: .normal)
        setNormalLabelColor(Constants.normalColorLabel, for: .editing)
        setFloatingLabelColor(Constants.editingColorLabel, for: .normal)
        setFloatingLabelColor(Constants.editingColorLabel, for: .editing)
        label.text = Placeholder
        placeholder = Placeholder
        backgroundColor = .white
    }
}
