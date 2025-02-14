#import <Foundation/Foundation.h>
#import "YRPRootListController.h"

@implementation YTRRootListController

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
    }
    return _specifiers;
}

- (void)save {
    [self.view endEditing:YES];
}

- (void)version {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/ahmadjerjawi/Invidious-list/refs/heads/main/output/youtube-version"]];
}

// Handle settings changes
- (void)settingsChanged:(NSNotification *)notification {
    // Fetch the current value of customVersion
    NSString *customVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"customVersion"];
    if (!customVersion || [customVersion length] == 0) {
        NSLog(@"Custom version not set or empty.");
        return;
    }

    // Find YouTube's Info.plist
    NSString *youTubePath = [self findYouTubeAppPath];
    if (!youTubePath) {
        NSLog(@"YouTube.app not found.");
        return;
    }

    NSString *plistPath = [youTubePath stringByAppendingPathComponent:@"Info.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        NSLog(@"Info.plist not found at path: %@", plistPath);
        return;
    }

    // Load and modify the plist
    NSMutableDictionary *plistDict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    if (!plistDict) {
        NSLog(@"Failed to load Info.plist.");
        return;
    }

    plistDict[@"CFBundleVersion"] = customVersion;
    if ([plistDict writeToFile:plistPath atomically:YES]) {
        NSLog(@"Successfully updated CFBundleVersion to %@", customVersion);
    } else {
        NSLog(@"Failed to write updated Info.plist.");
    }
}

// Helper to find YouTube app path
- (NSString *)findYouTubeAppPath {
    NSArray *searchPaths = @[
        @"/var/mobile/Applications",
        @"/var/containers/Bundle/Application"
    ];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    for (NSString *searchPath in searchPaths) {
        NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:searchPath];
        NSString *file;
        while ((file = [enumerator nextObject])) {
            if ([file.lastPathComponent isEqualToString:@"YouTube.app"]) {
                return [searchPath stringByAppendingPathComponent:file];
            }
        }
    }

    return nil;
}

@end
