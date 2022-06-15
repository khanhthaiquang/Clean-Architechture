//
//  Assembler.swift
//  Undefine
//
//  Created by KhanhTQ on 18/05/2022.
//

protocol Assembler: AnyObject,
                    MainAssembler,
                    AppAssembler,
                    LoginAssembler,
                    GatewaysAssembler {
    
}

final class DefaultAssembler: Assembler {
    
}
