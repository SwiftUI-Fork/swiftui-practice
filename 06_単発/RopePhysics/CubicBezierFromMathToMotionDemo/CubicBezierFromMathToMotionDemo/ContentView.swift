//
//  ContentView.swift
//  CubicBezierFromMathToMotionDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Finally, here's some example code you can try out.
struct ContentView: View {
    var body: some View {
        TabView {
//            LinearInterpolationView()
//                .padding()
//                .tabItem {
//                    Image(systemName: "1.circle.fill")
//                    Text("Linear")
//                }
            QuadraticBezierView()
                .padding()
                .tabItem {
                    Image(systemName: "2.circle.fill")
                }
//
//            CubicBezierView()
//                .padding()
//                .tabItem {
//                    Image(systemName: "3.circle.fill")
//                }
            RopeView()
                .padding()
                .tabItem {
                    Image(systemName: "4.circle.fill")
                }
        }
    }

}
