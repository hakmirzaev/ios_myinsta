//
//  HomeUploadScreen.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 15/02/23.
//

import SwiftUI

struct HomeUploadScreen: View {
    @EnvironmentObject var session: SessionStore
    var viewModel = UploadViewModel()
    @Binding var tabSelection: Int
    @State var caption = ""
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State var isImagePickerDisplay = false
    @State var action = false
    
    func uploadPost() {
        if caption.isEmpty || selectedImage == nil {
            return
        }
        //Send the post to server
        let uid = (session.session?.uid)!
        viewModel.apiUploadPost(uid: uid, caption: caption, image: selectedImage!){result in
            if result {
                self.selectedImage = nil
                self.caption = ""
                self.tabSelection = 0
            }
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    ZStack{
                        if selectedImage != nil {
                            Image(uiImage: selectedImage!).resizable()
                                .frame(maxWidth: UIScreen.width, maxHeight: UIScreen.width)
                            VStack{
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        self.selectedImage = nil
                                    }, label: {
                                        Image(systemName: "xmark.square").resizable().scaledToFit().frame(width: 25, height: 25).foregroundColor(.white)
                                    }).padding()
                                }
                                Spacer()
                            }
                        } else {
                            Button(action: {
                                self.action.toggle()
                            }, label: {
                                Image("ic_camera_add").resizable().scaledToFit()
                                    .frame(width: 40, height: 40)
                            }).actionSheet(isPresented: $action, content: {
                                ActionSheet(title: Text("Actions"), buttons: [
                                    .cancel(),
                                    .default(Text("Pick Photo")) {
                                        self.sourceType = .photoLibrary
                                        self.isImagePickerDisplay.toggle()
                                    },
                                    .default(Text("Take Photo")) {
                                        self.sourceType = .camera
                                    }
                                ])
                            })
                            .sheet(isPresented: $isImagePickerDisplay, content: {
                                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                            })
                            
                        }
                    }.frame(maxWidth: UIScreen.width, maxHeight: UIScreen.width)
                        .background(.gray.opacity(0.2))
                    VStack{
                        TextField("Caption", text: $caption)
                            .font(.system(size: 17, design: .default))
                            .frame(height: 45)
                        Divider()
                    }.padding(.top, 10).padding(.leading, 20).padding(.trailing, 20)
                    Spacer()
                }
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.uploadPost()
            }, label: {
                Image(systemName: "square.and.arrow.up").resizable().foregroundColor(.black).font(.system(size: 15))
            }))
            .navigationBarTitle("Upload", displayMode: .inline)
        }
    }
}

struct HomeUploadScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeUploadScreen(tabSelection: .constant(0))
    }
}
