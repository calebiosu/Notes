//
//  CBADetailViewController.h
//  Notes
//
//  Created by Caleb Alebiosu on 5/9/14.
//  Copyright (c) 2014 Caleb Alebiosu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface CBADetailViewController : UIViewController <UITextViewDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>{
    MFMailComposeViewController *mailComposer;
}
@property (nonatomic, strong) UIImage *imageToSend;
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UITextView *tView;
@property (strong, nonatomic) IBOutlet UIImageView *iView;
- (IBAction)takePhoto:(UIButton *)sender;

- (IBAction)sendEmail:(UIButton *)sender;

@end
