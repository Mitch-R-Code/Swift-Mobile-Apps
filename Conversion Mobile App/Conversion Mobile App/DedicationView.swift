import SwiftUI

struct DedicationView: View {
    var body: some View {
        VStack {
            Image("Face image")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .padding(.top, 20)
            
            Text("This app is dedicated to Claire,")
                .font(.custom("MarkerFelt-Wide", size: 24))
                .foregroundColor(.pink)
                .padding()
            
            Text("the love of my life!")
                .font(.custom("MarkerFelt-Wide", size: 24))
                .foregroundColor(.pink)
                .padding()
        }
    }
}

#Preview {
    DedicationView()
} 