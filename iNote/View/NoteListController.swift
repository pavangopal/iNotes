//
//  ViewController.swift
//  iNote
//
//  Created by Pavan Gopal on 4/14/18.
//  Copyright © 2018 Pavan Gopal. All rights reserved.
//

import UIKit


class NoteListController: UIViewController{
    
    lazy var tableView:UITableView = {
        var tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    var viewModel =  ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        registerCells()
        setUpNavigationBar()
        
    }
    
    func registerCells(){
        
        tableView.register(NoteCell.self, forCellReuseIdentifier: String(describing: NoteCell.self))
    }
    
    func setUpNavigationBar(){
        let addNewNote = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addNewNoteButtonPressed))
        self.navigationItem.rightBarButtonItem = addNewNote
        
    }
    
    @objc func addNewNoteButtonPressed(){
        let addNoteController = AddNoteController(noteViewModel: nil)
        self.navigationController?.pushViewController(addNoteController, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.getData()
        self.tableView.reloadData()
    }
    
}

extension NoteListController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoteCell.self), for: indexPath) as! NoteCell
        noteCell.accessoryType = .disclosureIndicator
        let note = viewModel.notes[indexPath.row]
        noteCell.configure(title: note.title, description: note.noteDescription)
        return noteCell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeNote(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .right)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let noteViewModel = AddNoteViewModel(note: self.viewModel.notes[indexPath.row])
        let addNoteController = AddNoteController(noteViewModel: noteViewModel)
        self.navigationController?.pushViewController(addNoteController, animated: true)
    }
}


