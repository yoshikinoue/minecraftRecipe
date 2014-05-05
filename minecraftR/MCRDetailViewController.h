//
//  MCRDetailViewController.h
//  minecraftR
//
//  Created by Inoue Yoshiki on 12/06/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCRDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) id detailText;

@property (strong, nonatomic) id detailImagetag;

@property (strong, nonatomic) id detailImage;

@property (strong, nonatomic) IBOutlet UITextView *detailDescriptionLabel2;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) IBOutlet UIImageView *detailDescriptionImage;


@end
