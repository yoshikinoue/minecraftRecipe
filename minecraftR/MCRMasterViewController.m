//
//  MCRMasterViewController.m
//  minecraftR
//
//  Created by Inoue Yoshiki on 12/06/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MCRMasterViewController.h"

#import "MCRDetailViewController.h"

@interface MCRMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MCRMasterViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //editボタン
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //「＋」ボタン
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    //検索データの準備
    items = [[NSMutableArray alloc] init]; 
    results = [[NSMutableArray alloc] init];
    
    NSString *fileURL = [[NSBundle mainBundle]
                         URLForResource:@"minecraftR" withExtension:@"csv"];
    NSString *Str = [[NSString alloc]initWithContentsOfURL:fileURL 
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];  
    
    [Str enumerateLinesUsingBlock:^(NSString *line, BOOL *stop){
        NSArray *comps = [line componentsSeparatedByString:@","];
        NSString *title = @"",*category = @"",*comment = @"";
        if ([comps count] < 1){
            *stop = YES;
        } 
        title = [comps objectAtIndex:0];
        if ([comps count] >= 2){
            category = [comps objectAtIndex:1];
        } 
        if ([comps count] >= 3){
            comment = [comps objectAtIndex:2];
        } 
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              title,@"title",
                              category,@"category",
                              comment,@"comment",nil];
        [items addObject:dict];
    }];

    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


//「＋」ボタンを押した時の処理
//- (void)insertNewObject:(id)sender
//{
//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //検索対象がない場合すべてのデータを表示する。
    if([results count] == 0){
        return [items count];
        
    }
    return [results count];
    
    
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//
//    NSDate *object = [_objects objectAtIndex:indexPath.row];
//    cell.textLabel.text = [object description];
//    return cell;
//}

- (void)searchDisplayController:(UISearchDisplayController *)controller
 willShowSearchResultsTableView:(UITableView *)tableView
{
//    tableView.backgroundColor = [UIColor clearColor];
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.separatorColor = RGB(1, 1, 1);
    
    tableView.backgroundColor = RGB(138, 138, 138);
    
}

//サーチ処理
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    //NSLog(@"Search: %@" , searchString);

    [results removeAllObjects];
    
    for (NSDictionary *dict in items){
        NSString *title = [dict objectForKey:@"title"];
        if ([title rangeOfString:searchString].location != NSNotFound) {
            [results addObject:dict];
        }                   
        
    }
    
    return YES;
    
}

//セル生成
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]
                initWithStyle:(UITableViewCellStyleSubtitle)
                reuseIdentifier:CellID];
    }
    
    NSDictionary *dict;
    if([results count] == 0){
        dict = [items objectAtIndex:indexPath.row]; 
        
    }else {
        //NSDictionary *dict = [items objectAtIndex:indexPath.row];
        dict = [results objectAtIndex:indexPath.row];
    }
    
    
    NSString * title = [dict objectForKey:@"title"];
    NSString * category = [dict objectForKey:@"category"];
    NSString * comment = [dict objectForKey:@"comment"];
    
    
    
    //アクセサリーボタンの設定
//    if ((comment && comment.length > 15) ||
//        (title  && title.length > 15)) 
//    {
//        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    comment = [NSString stringWithFormat:@"【%@】 %@",
               category,comment];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = comment;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", category, @".png"]];
    
    return cell;
    
}


//テーブルデリゲート
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    tableView.bounces = NO; 
    
    //カラー設定
    tableView.separatorColor = RGB(100, 100, 100);

    cell.backgroundColor = RGB(138, 138, 138);
    
    // For even
    if (indexPath.row % 2 == 0) {
        //カラー指定
        //cell.backgroundColor = [UIColor whiteColor];
    }
    // For odd
    else {
        //カラー指定
        //cell.backgroundColor = RGB(138, 138, 138);
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


//エディット時の処理
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/





//セグウェイ時の処理
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSDate *object = [_objects objectAtIndex:indexPath.row];
        
        NSDictionary *dict = [items objectAtIndex:indexPath.row];
        
        NSString * title = [dict objectForKey:@"title"];
        NSString * category = [dict objectForKey:@"category"];
        NSString * comment = [dict objectForKey:@"comment"];
        //画像
        NSString * detailImagetag = [NSString stringWithFormat:@"%@%@%@",@"c_", category, @".png"];
        
        comment = [NSString stringWithFormat:@"【%@】 %@",
                   category,comment];
        //タイトル
        [[segue destinationViewController] setDetailItem:title];
        
        //画像
        [[segue destinationViewController] setDetailImagetag:detailImagetag];
        
        //コメント
        [[segue destinationViewController] setDetailText:comment];
    }
}

@end
