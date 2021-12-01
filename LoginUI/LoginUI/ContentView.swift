//
//  ContentView.swift
//  LoginUI
//
//  Created by MTPC-154 on 30/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var showPassword: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ScrollView {
            
            VStack {
                //Logo Imageview
                HStack {
                    Image("logo").padding([.top],50)
                }
                Spacer()
                VStack(alignment: .trailing,spacing: 20){
                    //Username input
                    HStack {
                        Image("ic_username").resizable().frame(width: 16, height: 16).padding()
                        TextField("Username", text: $username)
                            .disableAutocorrection(true)
                            .frame(height: 52)
                            .font(Font.custom("Inter-Regular", size: 17))
                            .accentColor(Color.custom.textfieldColor)
                        
                    }.background(Color.custom.textFieldBackground)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(Color.gray))
                    
                    //Password input
                    HStack {
                        Image("ic_password").resizable().frame(width: 16, height: 16).padding()
                        if showPassword {
                            TextField("Password", text: $password)
                                .disableAutocorrection(true)
                                .frame(height: 52)
                                .font(Font.custom("Inter-Regular", size: 17))
                                .accentColor(Color.custom.textfieldColor)
                        }else {
                            SecureField("Password", text: $password)
                                .disableAutocorrection(true)
                                .frame(height: 52)
                                .font(Font.custom("Inter-Regular", size: 17))
                                .accentColor(Color.custom.textfieldColor)
                        }
                        // Password Show/Hide
                        Button {
                            self.showPassword.toggle()
                        } label: {
                            if showPassword {
                                Image("eye_hide").resizable().frame(width: 20, height: 20).padding()
                            }else {
                                Image("eye").resizable().frame(width: 20, height: 20).padding()
                            }
                        }
                    }.background(Color.custom.textFieldBackground)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(Color.gray))
                    
                    //Email input
                    HStack {
                        Image("ic_email").resizable().frame(width: 16, height: 16).padding()
                        TextField("Email", text: $email)
                            .disableAutocorrection(true)
                            .frame(height: 52)
                            .font(Font.custom("Inter-Regular", size: 17))
                            .accentColor(Color.custom.textfieldColor)
                    }.background(Color.custom.textFieldBackground)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(Color.gray))
                    
                    //Forgot Password button
                    HStack {
                        Button {
                            alert(text: "Forgot password screen is not completed yet, work in progress.")
                        } label: {
                            Text("Forgotten password?")
                                .foregroundColor(Color.custom.textForgot)
                                .font(Font.custom("Inter-Medium", size: 15))
                        }
                    }
                    Spacer()
                    Button(action: {
                        if self.isValidate() {
                            alert(text: "Login Success")
                        }
                    }) {
                        Text("LOGIN").foregroundColor(.white).frame(maxWidth: .infinity)
                            .font(Font.custom("Inter-SemiBold", size: 20))
                    }.buttonStyle(PlainButtonStyle()).frame(height: 50, alignment: .center).background(Color.custom.bgloginbtn).cornerRadius(13)
                    
                }.padding([.top],100).padding([.leading,.trailing],37)
                
                //Signup button
                Button(action: {
                    alert(text: "Signup screen is not completed yet, work in progress.")
                }) {
                
                    HStack(alignment: .center, spacing: 0) {
                        Text("Don’t have an account? ").foregroundColor(Color.custom.textlightgray)
                        .font(Font.custom("Inter-Regular", size: 15))
                        Text("Signup").foregroundColor(Color.custom.textsignup)
                            .font(Font.custom("Inter-Medium", size: 15))
                    }
                }.padding(.top,100)
            }
        }
    }
    //Input field validation
    func isValidate() -> Bool {
        if self.username.isEmpty {
            alert(text: "Please enter username")
            return false
        }else if username.contains(" ") {
            alert(text: "Space and Upprcase not allowd in username")
            return false
        }else if self.checkTextSufficientComplexity(text: username) {
            alert(text: "Space and Upprcase not allowd in username")
            return false
        }
        else if password.isEmpty {
            alert(text: "Please enter password")
            return false
        }else if password.count < 8 {
            alert(text: "Password must be atleast 8 character")
            return false
        }
        else if !textFieldValidatorPassword(password) {
            alert(text: "Password should be one uppercase, lowecase, number")
            return false
        }
        else if email.isEmpty {
            alert(text: "Please enter email")
            return false
        }else if !textFieldValidatorEmail(email) {
            alert(text: "Please enter valid email")
            return false
        }
        return true
    }
    // Uppercase validation
    func checkTextSufficientComplexity(text : String) -> Bool{
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: text)

        return capitalresult

    }
   // Email validation
    func textFieldValidatorEmail(_ string: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    //Password validation
    func textFieldValidatorPassword(_ string: String) -> Bool {
        let passwordRegx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\dd$@$!%*?&#]{8,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegx)
        return emailPredicate.evaluate(with: string)
    }
    // Alert
    func alert(text:String) {
        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            presentationMode.wrappedValue.dismiss()
        })
        showAlert(alert: alert)
    }
    func showAlert(alert: UIAlertController) {
        if let controller = topMostViewController() {
            controller.present(alert, animated: true)
        }
    }
    private func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive}
        .compactMap {$0 as? UIWindowScene}
        .first?.windows.filter {$0.isKeyWindow}.first
    }

    private func topMostViewController() -> UIViewController? {
        guard let rootController = keyWindow()?.rootViewController else {
            return nil
        }
        return topMostViewController(for: rootController)
    }
    private func topMostViewController(for controller: UIViewController) -> UIViewController {
        if let presentedController = controller.presentedViewController {
            return topMostViewController(for: presentedController)
        } else if let navigationController = controller as? UINavigationController {
            guard let topController = navigationController.topViewController else {
                return navigationController
            }
            return topMostViewController(for: topController)
        } else if let tabController = controller as? UITabBarController {
            guard let topController = tabController.selectedViewController else {
                return tabController
            }
            return topMostViewController(for: topController)
        }
        return controller
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
