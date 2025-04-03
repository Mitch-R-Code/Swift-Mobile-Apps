import SwiftUI

struct DedicationView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Heart icon
            Image(systemName: "heart.fill")
                .font(.system(size: 60))
                .foregroundColor(.pink)
                .padding(.top, 40)
            
            // Dedication text
            VStack(spacing: 15) {
                Text("For Claire")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                
                Text("Thank you for being my inspiration and support throughout this journey. Your encouragement and belief in me have made all the difference.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text("With love,")
                    .font(.headline)
                    .padding(.top)
                
                Text("Your Developer")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.pink.opacity(0.1))
    }
}

#Preview {
    DedicationView()
} 