// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SDWebImage",
    platforms: [
        .iOS(.v8),
        .macOS(.v10_10),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        .library(
            name: "SDWebImage",
            targets: ["SDWebImage"]
        ),
        .library(
            name: "SDWebImageMapKit",
            targets: ["SDWebImageMapKit"]
        ),
        .library(
            name: "SDWebImageGIF",
            targets: ["SDWebImageGIF"]
        )//,
        //.library(
        //    name: "SDWebImageWebP",
        //    targets: ["SDWebImageWebP"]
        //)
    ],
	dependencies: [         .package(url: "https://github.com/Flipboard/FLAnimatedImage.git", from: "1.0.17") ],
    targets: [
        // Core target
        .target(
            name: "SDWebImage",
            path: "SDWebImage",
            exclude: [
                "UIImage+WebP.h",
                "UIImage+WebP.m",
                "MKAnnotationView+WebCache.h",
                "MKAnnotationView+WebCache.m",
                "FLAnimatedImage"
            ],
            publicHeadersPath: ".",

            linkerSettings: [
                .linkedFramework("ImageIO")
            ]
        ),
        // MapKit subspec
        .target(
            name: "SDWebImageMapKit",
            dependencies: ["SDWebImage"],
            path: "SDWebImage",
            sources: ["MKAnnotationView+WebCache.h", "MKAnnotationView+WebCache.m"],
            publicHeadersPath: ".",
            linkerSettings: [
                .linkedFramework("MapKit")
            ]
        ),
        // GIF subspec
        .target(
            name: "SDWebImageGIF",
            dependencies: ["SDWebImage", "FLAnimatedImage"],
            path: "SDWebImage/FLAnimatedImage",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("Vendors/FLAnimatedImage/FLAnimatedImage")
            ]
        )//,
        // WebP subspec
        //.target(
        //    name: "SDWebImageWebP",
        //    dependencies: ["SDWebImage", "libwebp-xcode"],
        //    path: "SDWebImage",
        //    sources: ["UIImage+WebP.h", "UIImage+WebP.m"],
        //    publicHeadersPath: ".",
        //    cSettings: [
        //        .define("SD_WEBP", to: "1"),
        //        .headerSearchPath("Vendors/libwebp/src")
        //    ]
        //)
    ]
)
