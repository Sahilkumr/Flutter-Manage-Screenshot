import Flutter
import UIKit

class AppDelegate: FlutterAppDelegate,UIResponder,UIApplicationDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name:CHANNEL, binaryMessenger: controller.binaryMessenger)

    NotificationCenter.default.addObserver(self, selector: #selector(self.screenshotTaken), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    
    return true
  }
   @objc func screenshotTaken() {
    // Hide any sensitive information on the screen
    hideSensitiveContent()
    
    // Take a snapshot of the current screen
    guard let window = UIApplication.shared.keyWindow else { return }
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, UIScreen.main.scale)
    window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
    guard let snapshotImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
    UIGraphicsEndImageContext()
    
    // Create a black view to overlay on top of the screenshot
    let blackView = UIView(frame: window.bounds)
    blackView.backgroundColor = .black
    window.addSubview(blackView)
    
    // Remove the black view after a short delay (for visual effect)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        blackView.removeFromSuperview()
        
        // Take another snapshot after removing the black view
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, UIScreen.main.scale)
        window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
        guard let finalImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
        // Save the final modified image to the photo library
        UIImageWriteToSavedPhotosAlbum(finalImage, nil, nil, nil)
    }
}

    
    func hideSensitiveContent() {
       guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
    
    // Iterate through the subviews of the root view controller and hide sensitive content
    hideSensitiveContentInView(rootViewController.view)
}

func hideSensitiveContentInView(_ view: UIView) {
    for subview in view.subviews {
        // Hide specific views or elements based on their type or identifier
        // For example, you can hide UILabels, UITextFields, UIImageViews, etc.
        if let label = subview as? UILabel {
            label.isHidden = true
        } else if let textField = subview as? UITextField {
            textField.isHidden = true
        } else if let imageView = subview as? UIImageView {
            imageView.isHidden = true
        }
        
        // Recursively hide sensitive content in subviews
        hideSensitiveContentInView(subview)
    }
}
}