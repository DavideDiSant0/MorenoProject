import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)
    self.minSize = NSSize(width: 900, height: 620)
    if self.frame.width < self.minSize.width || self.frame.height < self.minSize.height {
      self.setFrame(
        NSRect(
          x: self.frame.origin.x,
          y: self.frame.origin.y,
          width: max(self.frame.width, self.minSize.width),
          height: max(self.frame.height, self.minSize.height)
        ),
        display: true
      )
    }

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
