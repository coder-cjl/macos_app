import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        let blurryContainerViewController = BlurryContainerViewController()
        let windowFrame = self.frame
        self.contentViewController = blurryContainerViewController
        self.setFrame(windowFrame, display: true)

        self.titleVisibility = .hidden

        // Weirdly, you'd think we wouldn't need this because we're hiding the titlebar
        // on the previous line, but if we don't, then the toolbar is shown opaquely.
        self.titlebarAppearsTransparent = true

        // Allows the user to grab by the title/tool bar and move around
        self.isMovableByWindowBackground = true
        
        if #available(macOS 11.0, *) {
            self.toolbarStyle = .unified
        }
        
        self.styleMask.insert(.fullSizeContentView)
        
        self.isOpaque = false
        self.backgroundColor = .clear
        
        RegisterGeneratedPlugins(registry: blurryContainerViewController.flutterViewController)
        
        super.awakeFromNib()
    }
}
