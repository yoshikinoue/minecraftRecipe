//
//  MCRDetailViewController.m
//  minecraftR
//
//  Created by Inoue Yoshiki on 12/06/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MCRDetailViewController.h"

@interface MCRDetailViewController ()
- (void)configureView;
@end

@implementation MCRDetailViewController

@synthesize detailItem = _detailItem;

@synthesize detailImagetag = _detailImagetag;
@synthesize detailImage = _detailImage;

@synthesize detailText = _detailText;

@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize detailDescriptionImage = _detailDescriptionImage;

@synthesize detailDescriptionLabel2 = _detailDescriptionLabel2;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
        self.detailDescriptionLabel2.text = [self.detailText description];
        self.detailDescriptionImage.image = [UIImage imageNamed:self.detailImagetag];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [self.detailItem description];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{

    [self setDetailText:nil];
    [self setDetailDescriptionImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.detailDescriptionLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
