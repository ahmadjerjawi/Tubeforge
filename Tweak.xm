#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/NSString+UIKitAdditions.h>
#import <UIKit/UIWebView.h>
#import <dlfcn.h>
#import "Tweak.h"
#import <Cephei/HBPreferences.h>
#import <objc/message.h>

#include <spawn.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#include <unistd.h>
extern char **environ;

static HBPreferences *preferences;
static UIWebView *homeWebView;
static UIWebView *menuWebView;
static NSMutableArray *homeWebViewsArray;
static BOOL wantsHome;
static BOOL wantsMenu;
static BOOL wantsSearch;
static BOOL wantsRedirectHome;
static BOOL wantsRedirectSearch;

#define MAX_WEBVIEW_INSTANCES 2

static void loadPreferences() {
    // Cache preferences values
    wantsHome = [preferences boolForKey:@"wantsHome" default:YES];
    wantsMenu = [preferences boolForKey:@"wantsMenu" default:YES];
    wantsSearch = [preferences boolForKey:@"wantsSearch" default:YES];
    wantsRedirectHome = [preferences boolForKey:@"wantsRedirectHome" default:NO];
    wantsRedirectSearch = [preferences boolForKey:@"wantsRedirectSearch" default:NO];
}

%group gSearchNewWay

// [Previous hooks remain the same, but use static variables instead]
%hook YTSearchResultsViewController
- (void)viewDidLoad {
    %orig;
    
    id searchRequest = [self valueForKey:@"_searchRequest"];
    NSString *query = nil;
    
    if (searchRequest && [searchRequest respondsToSelector:@selector(query)]) {
        query = ((NSString *(*)(id, SEL))objc_msgSend)(searchRequest, @selector(query));
    }
    
    if (wantsSearch) {
        NSString *encodedQuery = (query != nil) ? [query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] : @"";
        NSString *searchPageURLString = wantsRedirectSearch ? 
            [NSString stringWithFormat:@"http://localhost:4321/redirect-search.html?q=%@", encodedQuery] :
            [NSString stringWithFormat:@"http://localhost:4321/search.html?q=%@", encodedQuery];
            
        UIWebView *webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:searchPageURLString]]];
        [self.view addSubview:webView];
    }
}
%end

// [Other hooks remain the same but use static variables instead of accessing preferences directly]

%end

%ctor {
    preferences = [[HBPreferences alloc] initWithIdentifier:@"com.ahmadjerjawi.tubeforgepref"];
    homeWebViewsArray = [NSMutableArray new];
    
    // Load preferences immediately
    loadPreferences();
    
    // Register for preference changes
    [preferences registerPreferenceChangeBlock:^{
        loadPreferences();
    }];
    
    %init(gSearchNewWay);
    
    const char *path = "/bin/tubeforge";
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:path]]) {
        pid_t pid;
        char *const argv[] = { (char *)path, NULL };
        posix_spawn(&pid, path, NULL, NULL, argv, environ);
    }
}
