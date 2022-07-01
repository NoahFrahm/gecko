//
//  AnimationView.swift
//  lizard
//
//  Created by Noah Frahm on 6/29/22.
//

import SwiftUI

struct AnimationView: View {
    @State var endAmount: CGFloat = 0
    @State var isFilled: Bool = false
    @State var phoneFilled: Bool = false
    
    var primary: UIColor = myColorSchemes[0].primary
    var secondary: UIColor = myColorSchemes[0].secondary
    var tertiary: UIColor = myColorSchemes[0].tertiary
    
    var appSize: CGFloat = CGFloat((300/3)/4)
    var appRounding: CGFloat = CGFloat(8)
    var logoSize: CGFloat = CGFloat(300)
    var appSpacing: CGFloat = CGFloat(5)
    @State var logoColor: Color = Color(red: 83/255, green: 64/255, blue: 177/255)
//    Color(red: 148, green: 131, blue: 249)
    
    var darkPurp: Color = Color(red: 83/255, green: 64/255, blue: 177/255)
    var lightPurp: Color = Color(red: 148, green: 131, blue: 249)
    var darkGray: Color = Color(red: 25/255, green: 25/255, blue: 25/255)
    var darkPink: Color = Color(red: 255/255, green: 0/255, blue: 153/255)
    var lightPink: Color = Color(red: 255/255, green: 118/255, blue: 209/255)
    
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    
    @State var background: Color = Color(red: 148/255, green: 131/255, blue: 249/255)
    @State var screenColor: Color = Color(red: 148/255, green: 131/255, blue: 249/255)
    
    let pathBounds = UIBezierPath.calculateBounds(paths: [
        .final_logo_horns,
    ])
    
    //vars for flash and swipe animation
    @State var crunch_height = false
    @State var crunch_width = false
    @State var blackout = false
    @State var flash = false
    @State var pushVal: CGFloat = CGFloat(0)
    @State var loadingBar: CGFloat = CGFloat(1)
    @State var showLoad = false
    @State var blast = false
    
    
    var body: some View {
        VStack{
            ZStack{
                background
                //this vstack contains the screens
                VStack{
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundColor(.clear)
                        .frame(width: 2, height: 40)
                    ZStack{
                        //this hstack has the two screens and rectangles that we use
                        //to push screens left to right
                        HStack(spacing: 0){
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 88, height: 20)
                            screen(backCol: screenColor)
                            screen(backCol: screenColor)
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: pushVal, height: 20)
                        }
                            .frame(width: screenWidth, height: 400)
                        //this vstack contains the static bottom row of apps that don't slide
                        //on swipe
                        VStack{
                            Spacer()
                            HStack(alignment: .center, spacing: 5){
                                AppIconView(appSize: appSize, appRounding: appRounding)
                                AppIconView(appSize: appSize, appRounding: appRounding)
                                    .padding([.trailing], 10)
                            }
                        }
                        .frame(width: logoSize/3, height: logoSize*0.6)
                    }
                }
                //this is the screen flash
                VStack{
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundColor(.clear)
                        .frame(width: 20, height: 10)
                    ZStack{
                        //full black
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.black)
                            .frame(width: logoSize, height: logoSize*0.75)
                            .opacity(flash ? 1 : 0)
                        //full white
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                            .frame(width: crunch_width ? 10: logoSize, height: crunch_height ? 10: logoSize*0.75)
                            .opacity(flash ? 1 : 0)
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(blackout ? .black : .clear)
                            .frame(width: logoSize, height: logoSize*0.75)
                        
                        //loading bar
//                        similar to screen
//                        try with stroke or % fill
                        VStack(alignment: .leading){
                            HStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 100, height: 25)
                            }
                            ZStack(alignment: .leading){
                                RoundedRectangle(cornerRadius: 6)
                                    .foregroundColor(Color(red: 25/255, green: 25/255, blue: 25/255))
                                    .frame(width: 76, height: 5)
                                    .padding(.leading, 6)
                                RoundedRectangle(cornerRadius: 6)
                                    .foregroundColor(.white)
                                    .frame(width: loadingBar, height: 5)
                                    .padding(.leading, 6)
                            }
                            Spacer()
                        }
                        .opacity(showLoad ? 1:0)
                        .frame(width: 90, height: 50)
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(lightPink)
                            .frame(width: logoSize, height: logoSize*0.75)
                            .opacity(blast ? 1 : 0)
                    }
                }
                    
                //hstack with left right blocking rects to hide the screens
                HStack{
                    Rectangle()
                        .foregroundColor(background)
                        .frame(width: 143, height: 400)
                    Spacer()
                    Rectangle()
                        .foregroundColor(background)
                        .frame(width: 146, height: 400)
                }
                //this is the horns logo with a hole cut out of the center
                ShapeWithHole(backy: pathBounds)
                    .foregroundColor(logoColor)
                    .frame(width: logoSize, height: logoSize)
                
            }.ignoresSafeArea()
            HStack{
                //this button animates the loading bar
                Button(action: {
//                    withAnimation(.easeIn(duration: 3)){
//                        loadingBar = 34
//                    }
//                    withAnimation(.linear(duration: 1.5).delay(3)){
//                        loadingBar = 52
//                    }
//                    withAnimation(.easeIn(duration: 0.5).delay(4.5)){
//                        loadingBar = 76
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
//                        blast = true
//                        self.screenColor = lightPink
//                        self.background =  lightPink
//                        self.logoColor = darkPink
//
//                    }
                    withAnimation(.easeIn(duration: 1)){
                        loadingBar = 76
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                        blast = true
                        self.screenColor = lightPink
                        self.background =  lightPink
                        self.logoColor = darkPink
                        
                    }
                    
                }){
                    Text("load")
                }
                Button(action: {
                    withAnimation(){
                        if (pushVal > 0){
                            pushVal = 0
                        }
                        else {
                            self.pushVal = 200
                        }
                    }
                }) {
                    Text("swipe")
                }
                //this button animates screen flash
                Button(action: {
                    let delaying = 0.0
                    self.flash.toggle()
                    
                    withAnimation{
                        self.background = .black
                        self.logoColor = Color(red: 25/255, green: 25/255, blue: 25/255)
                    }
                    withAnimation(.easeIn.delay(delaying)){
                        self.crunch_height.toggle()
                    }
                    withAnimation(.easeIn.delay(0.05 + delaying)){
                        self.crunch_width.toggle()
                    }
                    withAnimation(.easeIn.delay(0.1 + delaying)){
                        self.blackout.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.showLoad.toggle()
                    }
                }) {
                    Text("flash")
                }
                
            }
        }
    }
}


//rounded rectangle phone then logo screen then horns grow

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}


extension Path {
    var reversed: Path {
        let reversedCGPath = UIBezierPath(cgPath: cgPath)
            .reversing()
            .cgPath
        return Path(reversedCGPath)
    }
}


struct ShapeWithHole: Shape {
    
    var backy: CGRect
    
    func path(in rect: CGRect) -> Path {
        let back = CGRect(x: backy.width, y: backy.height, width: backy.maxX, height: backy.maxY)
        
        var path = ShapeView(bezier: .final_logo_horns, pathBounds: back).path(in: back)
        let hole = ShapeView(bezier: .final_logo_phone, pathBounds: back).path(in: back).reversed
        path.addPath(hole)
        
        let pointScale = (rect.width >= rect.height) ? max(back.height, back.width) : min(back.height, back.width)
        let pointTransform = CGAffineTransform(scaleX: 1/pointScale, y: 1/pointScale)
        path = Path(path.cgPath).applying(pointTransform)
        let multiplier = min(rect.width, rect.height)
        let transform = CGAffineTransform(scaleX: multiplier, y: multiplier)
        return path.applying(transform)
    }
}


struct screen: View {
    
    var appSize: CGFloat = CGFloat((300/3)/4)
    var appRounding: CGFloat = CGFloat(8)
    var logoSize: CGFloat = CGFloat(300)
    var appSpacing: CGFloat = CGFloat(5)
    var backCol: Color = .blue

    var body: some View {
        ZStack{
            VStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 30, height: 8)
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(backCol)
                    .frame(width: (logoSize)/3, height: (logoSize)*0.75)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 30, height: 39)
            }
            .frame(width: 300, height: 300)
            VStack(){
                ForEach(0..<3){ _ in
                    HStack(spacing: appSpacing){
                        ForEach(0..<3){ _ in
                            AppIconView(appSize: appSize, appRounding: appRounding)
                        }
                    }
                    .padding([.trailing, .leading])
                }
                HStack(spacing: appSpacing){
                    ForEach(0..<2){ _ in
                        AppIconView(appSize: appSize, appRounding: appRounding)
                    }
                    HStack(spacing: appSpacing){
                        AppIconView(appSize: appSize, appRounding: appRounding, appColor: .clear)
                    }
                    
                }
                .padding([.trailing, .leading])
            }
            .padding([.top, .bottom], 20)
            .frame(width: (logoSize)/3, height: (logoSize)*0.8, alignment: .top)
            
        }
        .frame(width: (logoSize)/3, height: (logoSize)*0.8)
    }

}


struct AppIconView: View {
    
    var appSize: CGFloat
    var appRounding: CGFloat
    var appColor: Color = Color(red: 83/255, green: 64/255, blue: 177/255)
    
    var body: some View {
        RoundedRectangle(cornerRadius: appRounding)
            .foregroundColor(appColor)
            .frame(width: appSize, height: appSize)
    }
}
