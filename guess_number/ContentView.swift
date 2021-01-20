//
//  ContentView.swift
//  guess_number
//
//  Created by 林湘羚 on 2020/12/8.
//

import SwiftUI

struct ContentView: View {
    @State private var text:String=""
    @State private var number:Int=0
    @State private var result:Bool=false
    @State private var answer:Int=Int.random(in: 1...100)
    @State private var chance:Int=10
    @State private var alertMessage:Int=0
    @State private var max:Int=100
    @State private var min:Int=0
    
    @State private var moveY=UIScreen.main.bounds.height-50
    var body: some View {
        ZStack{
            Image("Peter_profile")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                //.opacity(0.8)
            VStack{
                
                Text("猜猜看Peter交過幾個女朋友?")
                    .foregroundColor(.black)
                    .font(.title)
                    .shadow(color: .white, radius: 2, x: -3, y: -3)
                    .shadow(color: .lairShadowGray, radius: 2, x: 3, y: 3)
                Text("(1~100個)")
                    .foregroundColor(.black)
                    .font(.title)
                    .shadow(color: .white, radius: 2, x: -3, y: -3)
                    .shadow(color: .lairShadowGray, radius: 2, x: 3, y: 3)
//                Text("你有十次機會")  //動畫
//                    .foregroundColor(.black)
//                    .font(.title)
//                    .shadow(color: .white, radius: 2, x: -3, y: -3)
//                    .shadow(color: .lairShadowGray, radius: 2, x: 3, y: 3)
                HStack{
                    TextEditor(text:$text)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.pink, lineWidth: 0.3))
                        .background(Color.green)
                        .opacity(0.5)
                        .frame(width:150, height:100)
                        .cornerRadius(20)
                        .font(.system(size: 60))
                    Text("個")
                        .font(.title)
                        .shadow(color: .white, radius: 2, x: -3, y: -3)
                        .shadow(color: .lairShadowGray, radius: 2, x: 3, y: 3)
                }
                Button(action: {
                    result=true
                    number=Int(text)!
                    //!!!!!!!!!!
                    if(number==answer){
                        answer=Int.random(in: 1...100)
                        chance=10
                        alertMessage=0
                        max=100
                        min=0
                    }else{
                        if(chance==1){
                            answer=Int.random(in: 1...100)
                            chance=10
                            alertMessage=1
                            max=100
                            min=0
                        }else{
                            chance=chance-1
                            if(number>answer){
                                alertMessage=2
                                if(number<max){
                                    max=number
                                }
                            }else{
                                alertMessage=3
                                if(number>min){
                                    min=number
                                }
                            }
                        }
                    }
                }, label: {
                    Text("確認")
                        .font(.title)
                        .padding(5)
                        .foregroundColor(Color.green)
                        .background(Color.white)
                        .cornerRadius(10)
                })
                .alert(isPresented: $result, content: {
                    let message=["答對囉!\n再玩一次", "失敗囉!\n再玩一次", "太多囉，還有\(chance)次機會", "太少囉，還有\(chance)次機會"]
                    
                    return Alert(title: Text(message[alertMessage]+"\n\(min)~\(max)"))
                })
                
                //Text("\(answer)")
            }
            VStack{
                Text("你有十次機會")  //動畫
                    .foregroundColor(.black)
                    .font(.title)
                    .shadow(color: .white, radius: 2, x: -3, y: -3)
                    .shadow(color: .lairShadowGray, radius: 2, x: 3, y: 3)
                    .transition(.slide)
                    .position(x: UIScreen.main.bounds.width/2, y: moveY)
            }
            .animation(
                Animation.linear(duration: 5)
            .repeatForever(autoreverses: false)
            )
            .onAppear{
                moveY=0
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
