//
//  chooseTheme.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 5/26/21.
//

import SwiftUI
import Combine


struct ChooseTheme: View {
    @EnvironmentObject var themes: ThemeDocument
    
    
    @State private var isPresented: Bool = false
    @State private var editMode: EditMode = .inactive
    @State private var themeName: String = ""
    @State private var emojis: String = ""
    @State private var themeColor: Color = Color.red
    @State private var isEmpty: Bool = true
    @State private var showSheet: Bool = false
    
    
    var body: some View {
        VStack {
            NavigationView {
                List{
                    ForEach(themes.returnedEmoji) { theme in
                        NavigationLink(
                            destination: ContentView(viewModel: EmojiMemoryGame(theme: theme))
                                .navigationBarTitle(theme.name, displayMode: .inline).foregroundColor(theme.color))
                        {
                            EditableText(theme, isEditing: self.editMode.isEditing) { name in
                                themes.editTheme(for: theme, emojis: theme.emoji.joined(separator: " "), emojiName: theme.name, color: theme.colorRGB)
                            }
                        }
                        
                        
                       
                    }.onDelete(perform: { indexSet in
                        indexSet.map { self.themes.returnedEmoji[$0] }.forEach { theme in
                            if(theme.name.contains("Default")) {
                                isPresented = true
                            } else {
                                self.themes.removeTheme(for: theme)
                            }
                        }
                    })
                }
                .navigationTitle(self.themes.isThemeEmpty() ? "Create a theme" : "Choose a theme")
                
                .toolbar(content: {
                    EditButton()
                }).environment(\.editMode, $editMode)
                
                .navigationBarItems(leading: Button(action: {
                    showSheet = true
                }, label: {
                    Image(systemName: "plus").imageScale(.large).foregroundColor(.blue)
                }))
                
                .sheet(isPresented: self.$showSheet, content: {
                    addThemeSheet(showSheet: self.$showSheet)
                })
            }
            .navigationViewStyle(DefaultNavigationViewStyle())
        }
    }
    
    func startGame(for theme: EmojiMemoryTheme) -> some View {
        return  ContentView(viewModel: themes.getEmojiMemoryGame(for: theme))
        
    }

    
    func dismissView()  {
        self.showSheet = false
    }
    
    
}

struct addThemeSheet: View {
    @State private var themeName: String = ""
    @State private var emojis: String = ""
    @State private var themeColor: Color = Color.blue
    @Binding var showSheet: Bool
    @State private var borderColor: Color = Color.gray
    
    @EnvironmentObject private var themes: ThemeDocument
    
    //MARK: Display text fields
    
    var body: some View {
        VStack(spacing:0){
            ZStack {
                Text("Add new theme").font(.headline)
                    .bold()
                    .padding()
                HStack{
                    Spacer()
                    Button(action: {
                        done()
                    }, label: {
                        Text("Done")
                    }).padding()
                }
            }
            VStack{
                TextField("Theme Name", text: self.$themeName)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(self.themeName == "" ? borderColor : Color.green, lineWidth: 2)
                    )
                
                TextField("Emojis e.g. 😀", text: self.$emojis)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(self.emojis == "" ? borderColor : Color.green, lineWidth: 2)
                    )
                ColorPicker("Select card color", selection: self.$themeColor, supportsOpacity: true).foregroundColor(.gray)
            }.padding()
            Spacer()
        }
        
        
        
        
    }
    
    
    func done() {
        if(self.themeName != "" && self.emojis != "") {
            self.showSheet = false
            themes.createTheme(themeName: themeName, emojis: emojis, themeColor: themeColor)
        } else {
            self.borderColor = Color.red
        }
    }
    //MARK: vars
    var textFieldBorder: CGFloat =  1.5
}




