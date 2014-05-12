//
//  CBADetailViewController.m
//  Notes
//
//  Created by Caleb Alebiosu on 5/9/14.
//  Copyright (c) 2014 Caleb Alebiosu. All rights reserved.
//

#import "CBADetailViewController.h"
#import "Data.h"

@interface CBADetailViewController ()
- (void)configureView;

@end

@implementation CBADetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [Data setCurrentKey:_detailItem];
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    NSString *currentNote = [[Data getAllNotes] objectForKey:[Data getCurrentKey]];
    
    //UIImage *currentImage = [[Data getAllImages] objectForKey:[Data getCurrentKey]];
    
    
    if(![currentNote isEqualToString:kDeafultText]){
        self.tView.text = currentNote;
    }
    else{
        self.tView.text = @"";
    }
    
    [self.tView becomeFirstResponder];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.tView addGestureRecognizer:gesture];
    gesture.delegate = self;
}


- (void)hide{
    [self.tView endEditing:YES];
   //[self.tView removeGestureRecognizer:self.view.gestureRecognizers[0]];
}

-(void)viewWillDisappear:(BOOL)animated{
    if(![self.tView.text isEqualToString:@""]){
        [Data setNoteForCurrentKey:self.tView.text];
    }
    else{
        [Data removeNoteForKey:[Data getCurrentKey]];
    }
    [Data saveNotes];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.imageToSend = (UIImage *)info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)takePhoto:(UIButton *)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: @"Upload Photo"
                                                             delegate: self
                                                    cancelButtonTitle: @"Cancel"
                                               destructiveButtonTitle: nil
                                                    otherButtonTitles: nil];
    

    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        [actionSheet addButtonWithTitle:@"Photo Library"];
    }
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [actionSheet addButtonWithTitle:@"Camera"];
    }
    
    [actionSheet showInView:self.tView];
}

- (void)sendEmail:(UIButton *)sender {
    NSMutableString *emailBody = [[NSMutableString alloc] initWithString:@"<html><body>"];
    
    NSString *currentNote = [[Data getAllNotes] objectForKey:[Data getCurrentKey]];
    
    [emailBody appendString:currentNote];
    UIImage *emailImage = self.imageToSend;
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(emailImage)];
    
    NSString *base64String = imageData;
    
    [emailBody appendString:[NSString stringWithFormat:@"<p><b><img src='data:image/png;base64,%@'></b></p>",base64String]];
    
    [emailBody appendString:@"</body></html>"];
    
    //mail composer window
    MFMailComposeViewController *emailDialog = [[MFMailComposeViewController alloc] init];
    emailDialog.mailComposeDelegate = self;
    [emailDialog setSubject:@"My Inline Image Document"];
    [emailDialog setMessageBody:emailBody isHTML:YES];
    
    [self presentViewController:emailDialog animated:YES completion:nil];
}

@end