//
//  UIViewController+NavigationButtons.m
//  Chicisimo
//
//  Created by Miguel Ferrando on 30/07/14.
//  Copyright (c) 2014 Chicisimo. All rights reserved.
//

#import "UIViewController+NavigationButtons.h"

@implementation UIViewController (NavigationButtons)

- (UIButton *)barButtonItemWithTitle:(NSString *)title
{
    UIButton *buttonNext = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonNext.frame = CGRectMake(0, 0, 60, 30);
    buttonNext.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1];
    buttonNext.layer.cornerRadius = 3;
    buttonNext.layer.borderColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1].CGColor;
    // using NSSelectorFromString to avoid compiler warnings as this is implemented by the view controller calling this method
    [buttonNext addTarget:self action:NSSelectorFromString(@"barButtonTapped") forControlEvents:UIControlEventTouchUpInside];
    [buttonNext setTitle:title forState:UIControlStateNormal];
    [buttonNext setTitleColor:[UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1] forState:UIControlStateNormal];
    buttonNext.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:10];
    
    return buttonNext;
}

- (void)customizeBackButton
{
    if (![self embeedInNavigationAndCanGoBack]) return;
    
    UIImage *backButtonImage = [UIImage imageNamed:@"ButtonBack"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = {CGPointZero, backButtonImage.size};
    backButton.frame = frame;
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    [backButton addTarget:self action:NSSelectorFromString(@"popViewController:") forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (BOOL)embeedInNavigationAndCanGoBack
{
    return (self.navigationController && [self.navigationController.viewControllers indexOfObject:self] > 0);
}

@end
