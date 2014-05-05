//
//  MCRMasterViewController.h
//  minecraftR
//
//  Created by Inoue Yoshiki on 12/06/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//RGBカラー設定用
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface MCRMasterViewController : UITableViewController
{
    //CSVの入れ物
    NSMutableArray * items;
    
    //検索後の値
    NSMutableArray * results;
    
    
    
}
@end
