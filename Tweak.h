#import <objc/NSObject.h>


@interface UIView ()
- (UIViewController*)_viewControllerForAncestor;
@property(nonatomic, readwrite) UIWebView *webView;
@property(nonatomic, readwrite) UIWebView *webViewDelegate;
@end

@interface YTBrowseViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end

@interface YTSearchResultsViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end

@interface  YTGuideResponseViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end

@interface  YTWatchNextResultsViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end

@interface ViewController : UIViewController <UIWebViewDelegate>
@end

