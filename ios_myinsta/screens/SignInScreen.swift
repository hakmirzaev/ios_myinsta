//
//  SignInScreen.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 08/02/23.
//

import SwiftUI

struct SignInScreen: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Utils.color1, Utils.color2]), startPoint: .top, endPoint: .bottom)
                VStack(spacing: 0){
                    Spacer()
                    Text("Instagram").foregroundColor(.white).font(.system(size: 35))
                    TextField("Email", text: $email).frame(height: 50).padding(.leading, 10)
                        .foregroundColor(.white).background(.white.opacity(0.4)).cornerRadius(8).padding(.top, 30)
                    SecureField("Password", text: $password).frame(height: 50).padding(.leading, 10)
                        .foregroundColor(.white).background(.white.opacity(0.4)).cornerRadius(8).padding(.top, 10)
                    Button(action: {
                        
                    }, label: {
                        Text("Sign In")
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
                        Text("Don't have an account?").foregroundColor(.white)
                        NavigationLink(destination: SignUpScreen(), label: {
                            Text("SignUp").foregroundColor(.white).fontWeight(.bold)
                        })
                    }.frame(maxWidth: .infinity, maxHeight: 70)
                }.padding()
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
