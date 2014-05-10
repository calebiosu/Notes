//
//  CBADetailViewController.h
//  Notes
//
//  Created by Caleb Alebiosu on 5/9/14.
//  Copyright (c) 2014 Caleb Alebiosu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBADetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UITextView *tView;

@end
