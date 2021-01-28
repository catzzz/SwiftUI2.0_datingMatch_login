//
//  CustomTextField.swift
//  SwiftUI2.0_Login_DatingApp
//
//  Created by Jimmy Leu on 1/27/21.
//

import SwiftUI

struct CustomTextField: View {
    var image: String
    var placeHolder : String
    @Binding var txt: String
    
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .leading, vertical:.center)){
            
            
            Image(systemName:image)
                .font(.system(size:24))
                .foregroundColor(Color("bottom"))
                .frame(width:60, height:60)
                .background(Color.white)
                .clipShape(Circle())
            ZStack{
                if placeHolder == "password"{
                    SecureField(placeHolder, text:$txt)
                }else{
                    TextField(placeHolder, text:$txt)
                }
            }
            .padding(.horizontal)
            .padding(.leading, 65)
            .frame(height:60)
            .background(Color.white.opacity(0.3))
            .clipShape(Capsule())
            
            
        }
        .padding(.horizontal)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    
    
    static var previews: some View {
        CustomTextField(image: "person", placeHolder: "Email", txt: .constant(""))
    }
}
