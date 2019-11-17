import Flutter
import UIKit
import AVFoundation

public class SwiftFflashlightPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "fflashlight", binaryMessenger: registrar.messenger())
        let instance = SwiftFflashlightPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    var hasFlashlight: Bool {
        get {
            guard let device = AVCaptureDevice.default(for: .video) else { return false }
            return device.hasTorch || device.hasFlash
        }
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "enable":
            guard let args = call.arguments as? [String: Any] else { return }
            guard let state = args["state"] as? Bool else { return }
            result(enable(state: state))
            break
        case "on":
            result(enable(state: true))
            break
        case "off":
            result(enable(state: false))
            break
        case "hasFlashlight":
            result(hasFlashlight)
            break
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }

    private func enable(state: Bool) {
        
    }
}
