import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let CHANNEL = "com.example.anotherapp/params"

    override func application(
        _ application: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let param1 = components?.queryItems?.first { $0.name == "param1" }?.value
        let param2 = components?.queryItems?.first { $0.name == "param2" }?.value

        // Sending data to Flutter using Method Channel
        if let controller = window?.rootViewController as? FlutterViewController {
            let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)
            methodChannel.invokeMethod("sendParams", arguments: ["param1": param1 ?? "", "param2": param2 ?? ""])
        }

        return true
    }
}
