//
//  AppDelegate.m
//  Langy
//
//  Created by Nicolas Santangelo on 8/6/14.
//  Copyright (c) 2014 Nicolas Santangelo. All rights reserved.
//

#import "AppDelegate.h"

#define languagesToolbarItem @"LangyLanguages"


@interface AppDelegate() {
    ApplicationObserver *appObserver;
    
    AppToggler *appToggler;
    
    PreferencesWindowController *preferencesWindowController;
    
    NSInteger currentTag;
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    if([self isAccesibilityEnabled]) {
        [UserDefaultsManager registerDefaults];
        
        appObserver = [ApplicationObserver start];
        appToggler = [[AppToggler alloc] init];
        
        [self showStatusBar];
    } else {
        [NSApp terminate:self];
    }
}

- (BOOL)isAccesibilityEnabled {
    NSDictionary *options = @{(__bridge id)kAXTrustedCheckOptionPrompt: @YES};
    return AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)options);
}


// Status bar

- (void)showStatusBar {
    [self.menu addToSystemStatusBar];
    [self.menu setPreferencesPresenter:self];
    [self.menu setAppToggler:appToggler];
}

- (void)showPreferences {
    if (!preferencesWindowController) {
        preferencesWindowController = [[PreferencesWindowController alloc] initWithWindowNibName:@"PreferencesWindowController"];
        [preferencesWindowController setAppToggler:appToggler];
    }
    [preferencesWindowController showWindow:self];
    [NSApp activateIgnoringOtherApps:YES];
}


@end
