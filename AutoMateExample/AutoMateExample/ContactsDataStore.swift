//
//  ContactsDataStore.swift
//  AutoMateExample
//
//  Created by Joanna Bednarz on 22/02/2017.
//  Copyright © 2017 PGS Software. All rights reserved.
//

import Contacts

class ContactsDataStore: DataStore {

    // MARK: DataStore - Typealias
    typealias T = CNContact

    // MARK: DataStore - Properties
    private(set) var data = [[T]()]

    // MARK: Private - Properties
    private let store = CNContactStore()
    private let fetchRequest: CNContactFetchRequest = {
        return CNContactFetchRequest(keysToFetch: [
                                         CNContactEmailAddressesKey,
                                         CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                                         CNContactPhoneNumbersKey,
                                         CNContactUrlAddressesKey,
                                         CNContactSocialProfilesKey,
                                         CNContactThumbnailImageDataKey,
                                         CNContactNicknameKey
                                     ].flatMap { $0 as? CNKeyDescriptor })
    }()

    // MARK: DataStore - Methods
    func title(for section: Int) -> String? {
        return nil
    }

    func reloadData(completion: @escaping () -> Void) {
        requestPermission { [weak self] authenticated in
            guard let strongSelf = self, authenticated else {
                completion()
                return
            }
            try? strongSelf.store.enumerateContacts(with: strongSelf.fetchRequest) { strongSelf.data[0].append($0.0) }
            completion()
        }
    }

    // MARK: Private - Methods
    private func requestPermission(with completion: @escaping (Bool) -> Void) {
        guard CNContactStore.authorizationStatus(for: .contacts) != .authorized else {
            completion(true)
            return
        }

        store.requestAccess(for: .contacts) { authenticated, _ in
            completion(authenticated)
        }
    }
}
