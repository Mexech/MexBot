import PackageDescription

let package = Package(
    name: "MexBot",
    dependencies: [
        .Package(url: "https://github.com/Azoy/Sword", majorVersion: 0, minor: 7),
    ]
)
