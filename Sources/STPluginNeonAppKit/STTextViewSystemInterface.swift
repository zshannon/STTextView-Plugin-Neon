import Cocoa
import STTextView
import Neon
import RangeState

@MainActor
class STTextViewSystemInterface: TextSystemInterface {

    typealias AttributeProvider = (Neon.Token) -> [NSAttributedString.Key: Any]?

    private let textView: STTextView
    private let attributeProvider: AttributeProvider

    init(textView: STTextView, attributeProvider: @escaping AttributeProvider) {
        self.textView = textView
        self.attributeProvider = attributeProvider
    }

    typealias Content = UnversionableContent
    
    var content: Content {
        UnversionableContent { [weak self] in
            self?.textView.textContentManager.length ?? 0
        }
    }
    
    func applyStyles(for application: TokenApplication) {
        // Clear existing styles in the range if a range is provided
        if let range = application.range {
            clearStyle(in: range)
        }
        
        // Apply new styles for each token
        for token in application.tokens {
            applyStyle(to: token)
        }
    }
    
    private func clearStyle(in range: NSRange) {
        guard let textRange = NSTextRange(range, in: textView.textContentManager) else {
            assertionFailure()
            return
        }

        textView.textLayoutManager.removeRenderingAttribute(.foregroundColor, for: textRange)
        textView.addAttributes([.font: textView.font], range: range)
    }

    private func applyStyle(to token: Neon.Token) {
        guard let attrs = attributeProvider(token),
              let textRange = NSTextRange(token.range, in: textView.textContentManager)
        else {
            return
        }

        for attr in attrs {
            if attr.key == .foregroundColor {
                textView.textLayoutManager.addRenderingAttribute(.foregroundColor, value: attr.value, for: textRange)
            } else {
                textView.addAttributes([attr.key: attr.value], range: token.range)
            }
        }
    }
}
