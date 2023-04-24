//
//  BlurryContainerViewController.swift
//  Runner
//
//  Created by 雷子 on 2023/4/23.
//

import Cocoa
import FlutterMacOS

class BlurryContainerViewController: NSViewController {

    let flutterViewController = FlutterViewController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
      }

      required init?(coder: NSCoder) {
        fatalError()
      }

      override func loadView() {
        let blurView = NSVisualEffectView()
        blurView.autoresizingMask = [.width, .height]
        blurView.blendingMode = .behindWindow
        blurView.state = .active
        if #available(macOS 10.14, *) {
            blurView.material = .sidebar
        }
        self.view = blurView
      }

      override func viewDidLoad() {
        super.viewDidLoad()

        self.addChild(flutterViewController)

        flutterViewController.view.frame = self.view.bounds
        flutterViewController.backgroundColor = .clear // **Required post-Flutter 3.7.0**
        flutterViewController.view.autoresizingMask = [.width, .height]
        self.view.addSubview(flutterViewController.view)
      }
    
}
