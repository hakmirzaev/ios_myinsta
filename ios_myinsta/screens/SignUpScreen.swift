//
//  SignUpScreen.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 08/02/23.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel = SignUpViewModel()
    @EnvironmentObject var session: SessionStore
    @State var fullname = "Bekhruzjon"
    @State var email = "hakmirzaevbekhruzjon@gmail.com"
    @State var password = "123qwe"
    @State var cpassword = "123qwe"
    
    func doSignUp(){
        viewModel.apiSignUp(email: email, password: password, completion: { result in
            if !result{
                //when error, show dialog or toast
            } else {
                
                var user = User(email: email, displayName: fullname, password: password, imgUser: "")
                user.uid = session.session?.uid
                // save user to Firestore
                presentation.wrappedValue.dismiss()
            }
        })
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Utils.color1, Utils.color2]), startPoint: .top, endPoint: .bottom)
                VStack(spacing: 0){
                    Spacer()
                    Text("app_name").foregroundColor(.white)
                        .font(Font.custom("Billabong", size: 45))
                    TextField("fullname", text: $fullname).frame(height: 50).padding(.leading, 10)
                        .foregroundColor(.white).background(.white.opacity(0.4)).cornerRadius(8).padding(.top, 10)
                    TextField("email", text: $email).frame(height: 50).padding(.leading, 10)
                        .foregroundColor(.white).background(.white.opacity(0.4)).cornerRadius(8).padding(.top, 10)
                    SecureField("password", text: $password).frame(height: 50).padding(.leading, 10)
                        .foregroundColor(.white).background(.white.opacity(0.4)).cornerRadius(8).padding(.top, 10)
                    SecureField("cpassword", text: $cpassword).frame(height: 50).padding(.leading, 10)
                        .foregroundColor(.white).background(.white.opacity(0.4)).cornerRadius(8).padding(.top, 10)
                    Button(action: {
                        doSignUp()
                    }, label: {
                        Text("sign_up")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1.5)
                                    .foregroundColor(.white.opacity(0.4))
                            )
                    }).padding(.top, 10)
                    Spacer()
                    HStack{
                        Text("already_have_account").foregroundColor(.white)
                        Button(action: {
                            self.presentation.wrappedValue.dismiss()
                        }, label: {
                            Text("sign_in").foregroundColor(.white).fontWeight(.bold)
                        })
                    }.frame(maxWidth: .infinity, maxHeight: 70)
                }.padding()
                if viewModel.isLoading {
                    ProgressView()
                }
            }.edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentation.wrappedValue.dismiss()
        }, label: {
            HStack{
                Image(systemName: "chevron.backward").foregroundColor(.white)
                Text("Back").foregroundColor(.white)
            }
        }))
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
