//
//  Bundle.swift
//  AutoMate
//
//  Created by Bartosz Janda on 28.03.2017.
//  Copyright © 2017 PGS Software. All rights reserved.
//

import Foundation

extension Bundle {
    /// AutoMate framework bundle
    public class var autoMate: Bundle {
        return Bundle(for: AppUITestCase.self)
    }
}
