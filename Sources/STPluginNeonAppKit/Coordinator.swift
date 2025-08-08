import Cocoa
import STTextView

import Neon
import TreeSitterClient
import SwiftTreeSitter
import SwiftTreeSitterLayer
import RangeState

// tree-sitter-xcframework
//import TreeSitter
import TreeSitterResource

@MainActor
public class Coordinator {
    private let styler: TextSystemStyler<STTextViewSystemInterface>
    private let tsClient: TreeSitterClient
    private let language: TreeSitterLanguage
    private let tsLanguage: SwiftTreeSitter.Language
    private let langConfig: LanguageConfiguration
    private var prevViewportRange: NSTextRange?

    init(textView: STTextView, theme: Theme, language: TreeSitterLanguage) {
        self.language = language
        tsLanguage = Language(language: language.parser)
        
        // Create language configuration with queries
        var queries: [Query.Definition: Query] = [:]
        if let highlightsQuery = try? tsLanguage.query(contentsOf: language.highlightQueryURL!) {
            queries[.highlights] = highlightsQuery
        }
        langConfig = LanguageConfiguration(tsLanguage, name: language.name, queries: queries)

        // set textview default font to theme default font
        textView.font = theme.font(forToken: "plain") ?? textView.font
        
        // Create TreeSitterClient
        tsClient = try! TreeSitterClient(
            rootLanguageConfig: langConfig,
            configuration: TreeSitterClient.Configuration(
                languageProvider: { _ in nil },
                contentProvider: { limit in
                    let str = textView.textContentManager.attributedString(in: nil)?.string ?? ""
                    return LanguageLayer.Content(string: str, limit: limit)
                },
                contentSnapshopProvider: { limit in
                    let str = textView.textContentManager.attributedString(in: nil)?.string ?? ""
                    return LanguageLayer.ContentSnapshot(string: str, limit: limit)
                },
                lengthProvider: { textView.textContentManager.length },
                invalidationHandler: { _ in },
                locationTransformer: { codePointIndex in
                    guard let location = textView.textContentManager.location(at: codePointIndex),
                          let position = textView.textContentManager.position(location)
                    else {
                        return .zero
                    }
                    
                    return Point(row: position.row, column: position.column)
                }
            )
        )
        
        // Create text interface
        let textInterface = STTextViewSystemInterface(textView: textView) { neonToken in
            var attributes: [NSAttributedString.Key: Any] = [:]
            attributes[.font] = textView.font
            
            if let themeColor = theme.color(forToken: TokenName(neonToken.name)) {
                attributes[.foregroundColor] = themeColor
                
                // TODO: Remove this later.
                print("themeColor \(themeColor) for token \(TokenName(neonToken.name))")
                
                if let themeFont = theme.font(forToken: TokenName(neonToken.name)) {
                    attributes[.font] = themeFont
                }
            } else if let themeDefaultColor = theme.color(forToken: "plain") {
                attributes[.foregroundColor] = themeDefaultColor
                
                // TODO: Remove this later.
                print("themeDefaultColor \(themeDefaultColor) for token \(TokenName(neonToken.name))")
                
                if let themeFont = theme.font(forToken: TokenName(neonToken.name)) {
                    attributes[.font] = themeFont
                }
            }
            
            return attributes
        }
        
        // Create token provider
        let tokenProvider = tsClient.tokenProvider(with: { range, _ in
            guard range.isEmpty == false else { return nil }
            return textView.textContentManager.attributedString(in: NSTextRange(range, provider: textView.textContentManager))?.string
        })
        
        // Create styler
        styler = TextSystemStyler(textSystem: textInterface, tokenProvider: tokenProvider)
        
        // Initial parse
        tsClient.didChangeContent(in: NSRange(textView.textContentManager.documentRange, in: textView.textContentManager),
                                  delta: textView.textContentManager.length)
    }


    func updateViewportRange(_ range: NSTextRange?) {
        prevViewportRange = range
        // The styler automatically handles visible range changes through validation
    }

    func willChangeContent(in range: NSRange) {
        // No longer needed with new API
    }

    func didChangeContent(_ textContentManager: NSTextContentManager, in range: NSRange, delta: Int, limit: Int) {
        tsClient.didChangeContent(in: range, delta: delta)
        styler.didChangeContent(in: range, delta: delta)
    }
}