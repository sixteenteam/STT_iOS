import SwiftUI

struct MultiColoredText: View {
    var originalText: String
    var coloredSubstrings: [(String, Color)]
    
    var body: some View {
        var currentIndex = originalText.startIndex
        var result: Text = Text("")
        
        for (substring, color) in coloredSubstrings {
            if let range = originalText.range(of: substring, range: currentIndex ..< originalText.endIndex) {
                let beforeRange = originalText[currentIndex ..< range.lowerBound]
                let coloredText = originalText[range]
                
                result = result + Text(beforeRange)
                    .foregroundColor(.black)
                result = result + Text(coloredText)
                    .foregroundColor(color)
                
                currentIndex = range.upperBound
            }
        }
        
        let remainingText = originalText[currentIndex...]
        result = result + Text(remainingText)
            .foregroundColor(.black)
        
        return result
    }
}
