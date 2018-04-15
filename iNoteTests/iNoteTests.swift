//
//  iNoteTests.swift
//  iNoteTests
//
//  Created by Pavan Gopal on 4/14/18.
//  Copyright © 2018 Pavan Gopal. All rights reserved.
//

import XCTest
@testable import iNote


class iNoteTests: XCTestCase {
    
    let title:String = "title"
    let noteDescription:String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the"
    var addNoteViewModel : AddNoteViewModel!
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let note = Note(context: context)
        
        note.title = title
        note.noteDescription = noteDescription
        addNoteViewModel = AddNoteViewModel(note: note)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        addNoteViewModel = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue(addNoteViewModel.noteDescription.value.count < 300 && addNoteViewModel.title.value.count > 0, "Pass")

    }
    
    func testUpdateNote(){
        var viewModel = ViewModel()
        let notesCount = viewModel.notes.count
        addNoteViewModel.createNewNote()
        viewModel.getData()
        
        XCTAssert(viewModel.notes.count == notesCount, "Pass")
        
        
    }
    
    func testNoteCreation(){
        
        var viewModel = ViewModel()
        let notesCount = viewModel.notes.count
        let addNewNoteModel = AddNoteViewModel(note: nil)
        addNewNoteModel.createNewNote()
        viewModel.getData()
        
         XCTAssert(viewModel.notes.count == notesCount+1, "Pass")
        
    }

}
