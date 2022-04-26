//
//  Note.swift
//  NoteApp
//
//  Created by Михаил Железовский on 24.03.2022.
//

import CoreData

@objc(Note)
class Note: NSManagedObject
{
    @NSManaged var id: NSNumber!
    @NSManaged var title: String!
    @NSManaged var desc: String!
    @NSManaged var deletedDate: Date?
}
