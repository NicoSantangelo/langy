//
//  AppsPopUpButton.m
//  Langy
//
//  Created by Nicolas Santangelo on 8/16/14.
//  Copyright (c) 2014 Nicolas Santangelo. All rights reserved.
//

#import "AppsPopUpButton.h"
#define kOther @"Other..."

@interface AppsPopUpButton() {
    AppFinder *appFinder;
}
@end

@implementation AppsPopUpButton

- (void)populate {
    [self populateWithout:@[]];
}

- (void)populateWithout:(NSArray *)names {
    appFinder = [[AppFinder alloc] init];
    
    [appFinder forEachInstalledApp:^(NSDictionary *app) {
        if ([self itemWithTitle:app[@"name"]] == nil && ![names containsObject:app[@"name"]]) {
            [[self menu] addItem:[[AppMenuItem alloc] initWithApp:app]];
        }
    }];
    
    [self addLastMenuItem];
    [self selectItemAtIndex:0];
}

- (void)triggerSelection {
    NSMenuItem *appMenuItem = [self selectedItem];
    
    if ([[appMenuItem title] isEqualToString:kOther]) {
        [appFinder openDialog:^(NSDictionary *app) {
            [self appendToAppsPopupButton:app];
        }];
    }
}

- (void)appendToAppsPopupButton:(NSDictionary *)app {
    [self removeLastMenuItem];
    
    [[self menu] addItem:[[AppMenuItem alloc] initWithApp:app]];
    [self selectItemAtIndex:[self count]];
    
    [self addLastMenuItem];
}

- (NSInteger)count {
    return [self numberOfItems] - 1;
}

- (NSDictionary *)selectedApp {
    AppMenuItem *menuItem = (AppMenuItem *)[self selectedItem];
    return menuItem ? menuItem.app : @{ };
}

- (void)addLastMenuItem {
    if ([self itemWithTitle:kOther] == nil) {
        [[self menu] addItem:[NSMenuItem separatorItem]];
        [self addItemWithTitle:kOther];
    }
}

- (void)removeLastMenuItem {
    [self removeItemWithTitle:kOther];
    [self removeItemAtIndex:[self count]];
}

@end
