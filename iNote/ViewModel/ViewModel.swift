//
//  ViewModel.swift
//  iNote
//
//  Created by Pavan Gopal on 4/15/18.
//  Copyright © 2018 Pavan Gopal. All rights reserved.
//

import Foundation
import RxSwift


struct ViewModel{
    var notes: [Note] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        self.getData()
    }
    
   mutating func getData() {
        do {
            
            self.notes = try context.fetch(Note.fetchRequest())
        }
        catch {
            print("Fetching Failed")
            self.notes.removeAll()
        }
    }
    
    mutating func removeNote(index:Int){
        
        let noteToDelete = self.notes.remove(at: index)
        context.delete(noteToDelete)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }

}
