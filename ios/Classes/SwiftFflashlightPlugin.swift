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
            result(enable(state: state, result: result))
            break
        case "on":
            result(enable(state: true, result: result))
            break
        case "off":
            result(enable(state: false, result: result))
            break
        case "hasFlashlight":
            result(hasFlashlight)
            break
        default:
            result(FlutterMethodNotImplemented)
            break
        }
    }

    private func enable(state: Bool, result: @escaping FlutterResult) {
        if (hasFlashlight) {
            guard let device = AVCaptureDevice.default(for: .video) else {
                result(FlutterError(code: "1", message: "Failed to initialize AVCaptureDevice", details: nil))
                return
            }

            do {
                try device.lockForConfiguration()
                device.torchMode = state ? .on : .off
                device.unlockForConfiguration()
            } catch {
                result(FlutterError(code: "2", message: error.localizedDescription, details: nil))
            }
        }
    }
}
