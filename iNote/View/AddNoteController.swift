//
//  AddNoteController.swift
//  iNote
//
//  Created by Pavan Gopal on 4/15/18.
//  Copyright © 2018 Pavan Gopal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddNoteController: UIViewController {
    
    var textField:UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 4
        return textView
    }()
    
    var addNewNote : UIBarButtonItem!
    var addNoteViewModel: AddNoteViewModel!

    
    required init(noteViewModel:AddNoteViewModel?) {
        super.init(nibName: nil, bundle: nil)
        
        if let noteModelToEdit = noteViewModel{
            self.addNoteViewModel = noteModelToEdit
            textField.text = self.addNoteViewModel.title.value
            descriptionTextView.text = self.addNoteViewModel.noteDescription.value
        }else{
            addNoteViewModel = AddNoteViewModel(note: nil)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(textField)
        view.addSubview(descriptionTextView)
        
        
        textField.anchor(self.topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 80, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        descriptionTextView.anchor(textField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 200)
        
        setUpNavigationBar()
        
        _ = textField.rx.text.map{$0 ?? ""}.bind(to: addNoteViewModel.title)
        _ = descriptionTextView.rx.text.map{$0 ?? ""}.bind(to: addNoteViewModel.noteDescription)
        
        _ = addNoteViewModel.isDescriptionRangeMet.bind(to: addNewNote.rx.isEnabled)
        
    }
    
    func setUpNavigationBar(){
        addNewNote = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveButtonPressed))
        self.navigationItem.rightBarButtonItem = addNewNote
        
    }
    
    @objc func saveButtonPressed(){

        addNoteViewModel.createNewNote()
        
        self.navigationController?.popViewController(animated: true)
    }
}
