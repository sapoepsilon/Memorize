//
//  EditableText.swift
//  EmojiArt
//
//  Created by CS193p Instructor on 5/6/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import SwiftUI

struct EditableText: View {
    var theme: EmojiMemoryTheme
    var isEditing: Bool
    var onChanged: (String) -> Void
    
    init(_ theme: EmojiMemoryTheme, isEditing: Bool, onChanged: @escaping (String) -> Void) {
        self.theme = theme
        self.isEditing = isEditing
        self.onChanged = onChanged
        
    }
    
    @State private var editableText: String = ""
    @State private var showPopUp: Bool  = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack{
                VStack{
                    HStack {
                        Text("\(theme.name) \(theme.emoji.joined(separator: " "))")
                            .sheet(isPresented: self.$showPopUp, content: {
                                appendEmojis(newEmojis: theme.emoji.joined(separator: " "), newName: theme.name, newColor: theme.color, theme: theme, showPopup: $showPopUp)
                            })
                        Spacer()
                    }
                    HStack(spacing:0){
                        Text("theme color: ")
                        Circle().foregroundColor(theme.color).frame(width: 20, height: 20)
                        Spacer()
                    }
                }
                Spacer()
                Image.init(systemName: "pencil")
                    .scaleEffect(2)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        showPopUp = true
                    }
            }.opacity(isEditing ? 1 : 0)
            
            if(!isEditing) {
                Text("\(theme.name) \(theme.emoji.joined(separator: " "))")
            }

        }
        .onAppear {
            self.editableText = self.theme.name
        }
        
    }
    
    func callOnChangedIfChanged() {
        if editableText != theme.name{
            onChanged(editableText)
        }
        
    }
    
    
}



//
struct appendEmojis: View {
    @State  var newEmojis: String
    @State var newName: String
    @State  var borderColor: Color = Color.gray
    @State var newColor: Color
    var theme: EmojiMemoryTheme
    @Binding var showPopup: Bool
    
    @EnvironmentObject var themes: ThemeDocument

    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("Theme Editor").font(.headline).padding()
                HStack {
                    Spacer()
                    Button(action: {
                        done()
                    }, label: {
                        Text("Done")
                    }).padding()
                    
                }
            }
            VStack{
                Form{
                    Section(header: Text("Edit Name"), content: {
                        TextField("", text: self.$newName)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(self.newName == "" ? Color.red : Color.gray, lineWidth: 2))
                            .padding()
                    }).lineSpacing(0)
                    Section(header: Text("Add or remove emojis"), content: {
                        TextField("", text: self.$newEmojis)
                            .padding()
                            .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(self.newEmojis == "" ? Color.red : Color.gray, lineWidth: 2))
                        .padding()
                    })
                    Section(header: Text("Change color"), content: {
                        ColorPicker(selection: self.$newColor, label: {
                            Text("Change color")
                        })
                    })
                }
            }
            
            Spacer()
        }.padding()
        
        
        
    }
    func done() {
        if(self.newEmojis != "" && self.newName != "") {
            themes.editTheme(for: theme, emojis: newEmojis, emojiName: newName, color: UIColor(newColor).rgb)
            showPopup = false
        }
    }
}

