//
//  SignUpScreen.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 08/02/23.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.presentationMode) var presentation
    @State var fullname = ""
    @State var email = ""
    @State var password = ""
    @State var cpassword = ""
    
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
