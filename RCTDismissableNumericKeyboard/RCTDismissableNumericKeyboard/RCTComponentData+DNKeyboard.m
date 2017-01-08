//
//  RCTComponentData+DNKeyboard.m
//  RCTDismissableNumericKeyboard
//
//  Created by Lukas Pawlik on 08/01/2017.
//  Copyright © 2017 Lukas Pawlik. All rights reserved.
//

#import "RCTComponentData+DNKeyboard.h"
#import <objc/runtime.h>

@implementation RCTComponentData (DismissableNumericKeyboard)

- (void)setPropsAndAddToolbar:(NSDictionary<NSString *, id> *)props forView:(id<RCTComponent>)view
{
    if (!view) {
        return;
    }
    
    if ([self shouldCloseButtonBeInjected:props forView:view]) {
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 35.0f)];
        toolbar.barStyle = UIBarStyleBlackOpaque;
        
        NSString *returnKeyTypeName = [props objectForKey:@"returnKeyType"];
        UIReturnKeyType *returnKeyType = [RCTConvert UIReturnKeyType:returnKeyTypeName];
        
        UIBarButtonSystemItem item = UIBarButtonSystemItemDone;
        if (returnKeyType == UIReturnKeySearch) {
            item = UIBarButtonSystemItemSearch;
        }
        if (returnKeyType == UIReturnKeyGo) {
            item = UIBarButtonSystemItemSave;
        }
            

        
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item target:view action:NSSelectorFromString(@"resignFirstResponder")];
            
        [toolbar setItems:[NSArray arrayWithObjects:flexibleSpace, barButtonItem, nil]];
        ((UITextField *)view).inputAccessoryView = toolbar;
            
    }
    
    
    [self setPropsAndAddToolbar:props forView:view];
    
}

-(BOOL)shouldCloseButtonBeInjected:(NSDictionary<NSString *, id> *)props forView:(id<RCTComponent>)view
{
    if (![NSStringFromClass([view class]) isEqualToString:@"RCTTextField"]) {
        return false;
    }
    
    NSArray *keys = @[@"keyboardType", @"returnKeyType"];
    NSArray *objects = [props objectsForKeys:keys notFoundMarker:[NSNull null]];
    
    id keyboardType = [objects objectAtIndex:0];
    id returnKey = [objects objectAtIndex:1];
    
    if (keyboardType == [NSNull null] || returnKey == [NSNull null]) {
        return false;
    }
    
    UIKeyboardType *type = [RCTConvert UIKeyboardType:keyboardType];
    
    BOOL shouldInject = (type == UIKeyboardTypeDecimalPad);
    return shouldInject;
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL setPropsSelector = @selector(setProps:forView:);
        SEL setPropsAndAddToolbarSelector = @selector(setPropsAndAddToolbar:forView:);
        Method originalMethod = class_getInstanceMethod(self, setPropsSelector);
        Method extendedMethod = class_getInstanceMethod(self, setPropsAndAddToolbarSelector);
        method_exchangeImplementations(originalMethod, extendedMethod);
    });
}

@end

