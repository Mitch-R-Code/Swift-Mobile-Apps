import SwiftUI

struct GrahamDedicationView: View {
    var body: some View {
        VStack {
            Image("Face image")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .padding(.top, 20)
            
            Text("This app is also dedicated to Graham,")
                .font(.custom("MarkerFelt-Wide", size: 24))
                .foregroundColor(.blue)
                .padding()
            
            Text("my amazing friend!")
                .font(.custom("MarkerFelt-Wide", size: 24))
                .foregroundColor(.blue)
                .padding()
        }
    }
}

#Preview {
    GrahamDedicationView()
} 