//
//  TableCurrentObjVC.m
//  RussianToast
//
//  Created by Евгений Иванов on 04.08.12.
//
//

#import "MediaListTableVC.h"
#import "DetailVC.h"
#import "MediaDB.h"
#import "GroupDB.h"
#import "SongCell.h"

@interface MediaListTableVC ()

@end

@implementation MediaListTableVC

-(void)dealloc
{
    self.parentGroup = nil;
    [mediaArray release];
    [super dealloc];
}
//-------------------------------------------------------------------------------
- (id)initWithMediaArray:(NSArray*)arrayData
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        mediaArray = [[NSArray alloc] initWithArray:arrayData];
    }
    return self;
}
//--------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setCustomTitle:self.parentGroup.name];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49.0f - 46.0f)];
    table.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgrnd.png"]];
    table.delegate = self;
    table.dataSource = self;
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:table];
    [table release];
}
//-----------------------------------------------------------------------------------
#pragma mark
#pragma mark TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
//-----------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}
//-----------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"mediaArray objects - %d",[mediaArray count]);
    return [mediaArray count];
}
//-----------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"id";
    SongCell *cell = (SongCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if(!cell)
	{
		cell = [[[SongCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = RGB_Color(66.0f, 42.0f, 2.0f, 2.0f);
        cell.textLabel.font = [UIFont fontWithName:@"MyriadPro-Bold" size:16];
	}
    
    MediaDB *mediaDB = [mediaArray objectAtIndex:indexPath.row];
    if(mediaDB)
        cell.textLabel.text = mediaDB.fullText;
    
	return cell;
}
//-----------------------------------------------------------------------------------
#pragma mark -
#pragma mark TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"");
    
    MediaDB *mediaDB = [mediaArray objectAtIndex:indexPath.row];
    
    DetailVC *textViewVC = [[DetailVC alloc] init];
    textViewVC.media = mediaDB;
    
    [textViewVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:textViewVC animated:YES];
    [textViewVC release];
}
//-----------------------------------------------------------------------------------
@end
