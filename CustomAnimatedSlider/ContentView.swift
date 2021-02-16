//
//  ContentView.swift
//  CustomAnimatedSlider
//
//  Created by Maxim Macari on 16/2/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State var maxHeight: CGFloat = UIScreen.main.bounds.height / 3
    
    //Slider properties
    @State var sliderProgress: CGFloat = 0
    @State var sliderHeight: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    
    var body: some View{
        NavigationView{
            VStack{
                //Slider
                ZStack(alignment: .bottom, content: {
                    Rectangle()
                        .fill(Color.orange.opacity(0.2))
                    
                    Rectangle()
                        .fill(Color.orange.opacity(0.7))
                        .frame(height: sliderHeight)
                })
                .frame(width: 100, height: maxHeight)
                .cornerRadius(35)
                //Container
                .overlay(
                    Text("\(Int(sliderProgress * 100))%")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.vertical, 30)
                        .offset(y: sliderHeight < maxHeight - 105 ? -sliderHeight : -maxHeight + 105)
                    
                    , alignment: .bottom
                )
                .gesture(DragGesture(minimumDistance: 0).onChanged({ (value) in
                    //getting drag value
                    let translation = value.translation
                    sliderHeight = -translation.height + lastDragValue
                    //limit slider heeight value
                    
                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                    
                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                    
                    //updating progress
                    let progress = sliderHeight / maxHeight
                    
                    sliderProgress = progress <= 1.0 ? progress : 1
                    
                }).onEnded({ (value) in
                    //Storing last drag value for reestoration
                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                    
                    //navigation height
                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                    lastDragValue = sliderHeight
                    
                    
                }))
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.secondary.ignoresSafeArea())
            .preferredColorScheme(.dark)
            .navigationTitle("Dashboard")
            
        }
    }
}
