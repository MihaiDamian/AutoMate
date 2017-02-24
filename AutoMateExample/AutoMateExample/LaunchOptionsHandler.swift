//
//  LaunchOptionsHandler.swift
//  AutoMateExample
//
//  Created by Joanna Bednarz on 24/02/2017.
//  Copyright © 2017 PGS Software. All rights reserved.
//

import Foundation
import AutoMate_AppBuddy

struct LaunchOptionsHandler {

    let launchEnvironmentManager: LaunchEnvironmentManager

    init() {
        launchEnvironmentManager = LaunchEnvironmentManager()
        launchEnvironmentManager.add(handler: defaultEventKitHander, for: .reminders)
        launchEnvironmentManager.add(handler: defaultEventKitHander, for: .events)
        launchEnvironmentManager.add(handler: defaultContactsHander, for: .contacts)
    }

    func setup() {
        launchEnvironmentManager.setup()
    }

    static let mockEnvironment: [String: String] = {
        return [ AutoMateLaunchOptionKey.events.rawValue: "nil:events",
            AutoMateLaunchOptionKey.reminders.rawValue: "nil:reminders",
            AutoMateLaunchOptionKey.contacts.rawValue: "nil:contacts"]
    }()
}
