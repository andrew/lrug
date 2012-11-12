class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    application.setStatusBarStyle(UIStatusBarStyleBlackOpaque)
    application.idleTimerDisabled = true
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = TweetController.alloc.init
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
    
  end
end
