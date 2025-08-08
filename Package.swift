// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "STTextView-Plugin-Neon",
    platforms: [.macOS(.v12), .iOS(.v16), .macCatalyst(.v16)],
    products: [
        .library(
            name: "STTextView-Plugin-Neon",
            targets: ["STPluginNeon"])
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/STTextView", from: "2.0.0"),
        .package(url: "https://github.com/ChimeHQ/Neon", branch: "main"),
        .package(url: "https://github.com/ChimeHQ/SwiftTreeSitter", from: "0.9.0"),
    ],
    targets: [
        .target(
            name: "STPluginNeon",
            dependencies: [
                .target(name: "STPluginNeonAppKit", condition: .when(platforms: [.macOS])),
                .target(
                    name: "STPluginNeonUIKit", condition: .when(platforms: [.iOS, .macCatalyst])),
            ],
            resources: [.process("Themes.xcassets")]
        ),
        .target(
            name: "STPluginNeonAppKit",
            dependencies: [
                .product(name: "STTextView", package: "STTextView"),
                .product(name: "Neon", package: "Neon"),
                .target(name: "TreeSitterResource"),
            ],
            resources: [.process("Themes.xcassets")]
        ),
        .target(
            name: "STPluginNeonUIKit",
            dependencies: [
                .product(name: "STTextView", package: "STTextView"),
                .product(name: "Neon", package: "Neon"),
                .target(name: "TreeSitterResource"),
            ],
            resources: [.process("Themes.xcassets")]
        ),
        .target(
            name: "TreeSitterResource",
            dependencies: [
                .product(name: "SwiftTreeSitter", package: "SwiftTreeSitter"),
                .target(name: "TreeSitterBash"),
                .target(name: "TreeSitterBashQueries"),
                .target(name: "TreeSitterC"),
                .target(name: "TreeSitterCQueries"),
                .target(name: "TreeSitterCPP"),
                .target(name: "TreeSitterCPPQueries"),
                .target(name: "TreeSitterCSharp"),
                .target(name: "TreeSitterCSharpQueries"),
                .target(name: "TreeSitterCSS"),
                .target(name: "TreeSitterCSSQueries"),
                .target(name: "TreeSitterGo"),
                .target(name: "TreeSitterGoQueries"),
                .target(name: "TreeSitterHTML"),
                .target(name: "TreeSitterHTMLQueries"),
                .target(name: "TreeSitterJava"),
                .target(name: "TreeSitterJavaQueries"),
                .target(name: "TreeSitterJavaScript"),
                .target(name: "TreeSitterJavaScriptQueries"),
                .target(name: "TreeSitterJSON"),
                .target(name: "TreeSitterJSONQueries"),
                .target(name: "TreeSitterMarkdown"),
                .target(name: "TreeSitterMarkdownQueries"),
                .target(name: "TreeSitterPHP"),
                .target(name: "TreeSitterPHPQueries"),
                .target(name: "TreeSitterPython"),
                .target(name: "TreeSitterPythonQueries"),
                .target(name: "TreeSitterRuby"),
                .target(name: "TreeSitterRubyQueries"),
                .target(name: "TreeSitterRust"),
                .target(name: "TreeSitterRustQueries"),
                .target(name: "TreeSitterSwift"),
                .target(name: "TreeSitterSwiftQueries"),
                .target(name: "TreeSitterSQL"),
                .target(name: "TreeSitterSQLQueries"),
                .target(name: "TreeSitterTOML"),
                .target(name: "TreeSitterTOMLQueries"),
                .target(name: "TreeSitterTSX"),
                .target(name: "TreeSitterTSXQueries"),
                .target(name: "TreeSitterTypeScript"),
                .target(name: "TreeSitterTypeScriptQueries"),
                .target(name: "TreeSitterYAML"),
                .target(name: "TreeSitterYAMLQueries"),
            ]
        ),
        .target(name: "TreeSitterAstro", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterAstroQueries",
            resources: [.copy("highlights.scm"), .copy("injections.scm")]),
        .target(name: "TreeSitterBash", cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterBashQueries", resources: [.copy("highlights.scm")]),
        .target(name: "TreeSitterC", cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterCQueries", resources: [.copy("highlights.scm")]),
        .target(
            name: "TreeSitterComment",
            exclude: ["src/tree_sitter_comment/chars.c", "src/tree_sitter_comment/parser.c"],
            cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterCommentQueries", resources: [.copy("highlights.scm")]),
        .target(name: "TreeSitterCSharp", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterCSharpQueries",
            resources: [.copy("highlights.scm"), .copy("tags.scm")]),
        .target(name: "TreeSitterCPP", cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterCPPQueries", resources: [.copy("highlights.scm")]),
        .target(name: "TreeSitterCSS", cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterCSSQueries", resources: [.copy("highlights.scm")]),
        .target(name: "TreeSitterElixir", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterElixirQueries",
            resources: [.copy("highlights.scm"), .copy("tags.scm")]),
        .target(name: "TreeSitterElm", cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterElmQueries", resources: [.copy("highlights.scm")]),
        .target(name: "TreeSitterGo", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterGoQueries", resources: [.copy("highlights.scm"), .copy("tags.scm")]),
        .target(name: "TreeSitterHaskell", cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterHaskellQueries", resources: [.copy("highlights.scm")]),
        .target(name: "TreeSitterHTML", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterHTMLQueries",
            resources: [.copy("highlights.scm"), .copy("injections.scm")]),
        .target(name: "TreeSitterJava", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterJavaQueries", resources: [.copy("highlights.scm"), .copy("tags.scm")]),
        .target(name: "TreeSitterJavaScript", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterJavaScriptQueries",
            resources: [
                .copy("highlights-jsx.scm"), .copy("highlights-params.scm"),
                .copy("highlights.scm"), .copy("injections.scm"), .copy("locals.scm"),
                .copy("tags.scm"),
            ]),
        .target(name: "TreeSitterJSDoc", cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterJSDocQueries", resources: [.copy("highlights.scm")]),
        .target(name: "TreeSitterJSON", cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterJSONQueries", resources: [.copy("highlights.scm")]),
        .target(name: "TreeSitterJSON5", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterJSON5Queries",
            resources: [.copy("highlights.scm"), .copy("injections.scm")]),
        .target(name: "TreeSitterJulia", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterJuliaQueries",
            resources: [.copy("highlights.scm"), .copy("injections.scm")]),
        .target(name: "TreeSitterLaTeX", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterLaTeXQueries",
            resources: [.copy("highlights.scm"), .copy("injections.scm")]),
        .target(name: "TreeSitterLua", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterLuaQueries",
            resources: [.copy("highlights.scm"), .copy("injections.scm")]),
        .target(name: "TreeSitterMarkdown", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterMarkdownQueries",
            resources: [.copy("highlights.scm"), .copy("injections.scm")]),
        .target(name: "TreeSitterMarkdownInline", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterMarkdownInlineQueries",
            resources: [.copy("highlights.scm"), .copy("injections.scm")]),
        .target(name: "TreeSitterOCaml", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterOCamlQueries",
            resources: [.copy("highlights.scm"), .copy("locals.scm"), .copy("tags.scm")]),
        .target(name: "TreeSitterPerl", cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterPerlQueries", resources: [.copy("highlights.scm")]),
        .target(name: "TreeSitterPHP", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterPHPQueries",
            resources: [.copy("highlights.scm"), .copy("injections.scm"), .copy("tags.scm")]),
        .target(name: "TreeSitterPython", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterPythonQueries",
            resources: [.copy("highlights.scm"), .copy("tags.scm")]),
        .target(name: "TreeSitterR", cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterRQueries", resources: [.copy("highlights.scm")]),
        .target(name: "TreeSitterRegex", cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterRegexQueries", resources: [.copy("highlights.scm")]),
        .target(name: "TreeSitterRuby", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterRubyQueries",
            resources: [.copy("highlights.scm"), .copy("locals.scm"), .copy("tags.scm")]),
        .target(name: "TreeSitterRust", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterRustQueries",
            resources: [.copy("highlights.scm"), .copy("injections.scm")]),
        .target(name: "TreeSitterSCSS", cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterSCSSQueries", resources: [.copy("highlights.scm")]),
        .target(name: "TreeSitterSQL", cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterSQLQueries", resources: [.copy("highlights.scm")]),
        .target(name: "TreeSitterSvelte", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterSvelteQueries",
            resources: [.copy("highlights.scm"), .copy("injections.scm")]),
        .target(name: "TreeSitterSwift", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterSwiftQueries",
            resources: [.copy("highlights.scm"), .copy("locals.scm")]),
        .target(name: "TreeSitterTOML", cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterTOMLQueries", resources: [.copy("highlights.scm")]),
        .target(name: "TreeSitterTSX", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterTSXQueries",
            resources: [.copy("highlights.scm"), .copy("locals.scm"), .copy("tags.scm")]),
        .target(name: "TreeSitterTypeScript", cSettings: [.headerSearchPath("src")]),
        .target(
            name: "TreeSitterTypeScriptQueries",
            resources: [.copy("highlights.scm"), .copy("locals.scm"), .copy("tags.scm")]),
        .target(
            name: "TreeSitterYAML", exclude: ["src/schema.generated.cc"],
            cSettings: [.headerSearchPath("src")]),
        .target(name: "TreeSitterYAMLQueries", resources: [.copy("highlights.scm")]),
    ]
)
