import SwiftUI
import MapKit
import WebKit
import SafariServices

struct ContentView: View {
    // إعدادات العداد والواجهة
    @State private var speed: Double = 0.0
    @State private var accentColor: Color = .green // اللون الافتراضي (يمكنك تغييره)
    @State private var searchText: String = ""
    @State private var showBrowser = false
    @State private var browserURL = URL(string: "https://www.google.com")!

    var body: some View {
        ZStack {
            // خلفية سوداء فخمة تناسب شاشات السيارات
            Color.black.edgesIgnoringSafeArea(.all)
            
            HStack(spacing: 30) {
                
                // --- الجانب الأيسر: كوكب الأرض والبحث ---
                VStack(spacing: 20) {
                    // كوكب الأرض 3D التفاعلي
                    Map(mapType: .satelliteFlyover)
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue.opacity(0.6), lineWidth: 4))
                        .shadow(color: .blue, radius: 15)
                    
                    // خانة البحث المتطورة
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("بحث أو رابط موقع...", text: $searchText, onCommit: {
                            openSearch()
                        })
                        .textFieldStyle(PlainTextFieldStyle())
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(15)
                    
                    // أزرار الوصول السريع
                    HStack(spacing: 15) {
                        QuickButton(title: "YouTube", color: .red) {
                            self.browserURL = URL(string: "https://www.youtube.com")!
                            self.showBrowser = true
                        }
                        QuickButton(title: "Google", color: .blue) {
                            self.browserURL = URL(string: "https://www.google.com")!
                            self.showBrowser = true
                        }
                    }
                }
                .frame(maxWidth: .infinity)

                // --- الجانب الأيمن: عداد السرعة الاحترافي ---
                VStack {
                    ZStack {
                        // إطار العداد الخلفي
                        Circle()
                            .trim(from: 0, to: 0.7)
                            .stroke(accentColor.opacity(0.2), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                            .rotationEffect(.degrees(135))
                        
                        // مؤشر السر
