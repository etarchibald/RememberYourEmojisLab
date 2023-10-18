//
//  addEditEmojiTableViewController.swift
//  tableViewPractice
//
//  Created by Ethan Archibald on 10/17/23.
//

import UIKit

class addEditEmojiTableViewController: UITableViewController {

    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usageTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var emoji: Emoji?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let emoji = emoji {
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
            title = "Edit Emoji"
        } else {
            title = "Add Emoji"
        }
        
        updateSaveButtonState()
    }
    
    init?(coder: NSCoder, emoji: Emoji?) {
        self.emoji = emoji
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBAction func textEditingChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        let symbolText = symbolTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        
        saveButton.isEnabled = !symbolText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty && containsSingleEmoji(symbolTextField)
    }
    
    private func containsSingleEmoji(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count == 1 else { return false }
        
        let isCombinedIntoEmoji = text.unicodeScalars.count > 1 && text.unicodeScalars.first?.properties.isEmoji ?? false
        
        let isEmojiPresentation = text.unicodeScalars.first?.properties.isEmojiPresentation ?? false
        
        return isCombinedIntoEmoji || isEmojiPresentation
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }
        
        let symbol = symbolTextField.text!
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let usage = usageTextField.text ?? ""
        emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
    }

}
