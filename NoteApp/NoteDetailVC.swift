//
//  ViewController.swift
//  NoteApp
//
//  Created by Михаил Железовский on 23.03.2022.
//

import UIKit
import CoreData

class NoteDetailVC: UIViewController {

    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var titleTF: UITextField!
    
    var selectedNote: Note? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(selectedNote != nil)
        {
            descriptionTV!.layer.borderWidth = 1
            descriptionTV!.layer.borderColor = UIColor.lightGray.cgColor
            descriptionTV!.layer.cornerRadius = 5
            descriptionTV!.layer.borderWidth = 1
            
            titleTF.text = selectedNote?.title
            descriptionTV.text = selectedNote?.desc
        }
    }


    @IBAction func saveAction(_ sender: Any)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedNote == nil)
        {
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
            let newNote = Note(entity: entity!, insertInto: context)
            newNote.id = noteList.count as NSNumber
            newNote.title = titleTF.text
            newNote.desc = descriptionTV.text
            do
            {
                try context.save()
                noteList.append(newNote)
                navigationController?.popViewController(animated: true)
            }
            catch
            {
                print("context save error")
            }
        }
        else //edit
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let note = result as! Note
                    if(note == selectedNote)
                    {
                        note.title = titleTF.text
                        note.desc = descriptionTV.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
    }
    
    @IBAction func DeleteNote(_ sender: Any)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let note = result as! Note
                if(note == selectedNote)
                {
                    note.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch
        {
            print("Fetch Failed")
        }
    }
    
}
