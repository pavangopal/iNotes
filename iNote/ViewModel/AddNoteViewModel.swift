//
//  AddNoteViewModel.swift
//  iNote
//
//  Created by Pavan Gopal on 4/15/18.
//  Copyright © 2018 Pavan Gopal. All rights reserved.
//

import Foundation
import RxSwift

struct AddNoteViewModel {
    var title = Variable<String>("")
    var noteDescription = Variable<String>("")
    
    var isDescriptionRangeMet: Observable<Bool>{
        return Observable.combineLatest(title.asObservable(),noteDescription.asObservable()){ title,noteDescription in
            noteDescription.count < 300  && title.count > 0
        }
    }
    
    var editableNote:Note?
    
    init(note:Note?) {
        
        guard let noteD = note else {
            return
        }
        self.editableNote = noteD
        self.title.value = noteD.title ?? ""
        self.noteDescription.value = noteD.noteDescription ?? ""
    }
    
    func createNewNote(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let noteD = editableNote{
            
            noteD.title = self.title.value
            noteD.noteDescription =  self.noteDescription.value
        }else{
            let note = Note(context: context)
            
            note.title = self.title.value
            note.noteDescription =  self.noteDescription.value
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
}
