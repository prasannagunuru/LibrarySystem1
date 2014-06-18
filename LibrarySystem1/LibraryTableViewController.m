//
//  LibraryTableViewController.m
//  LibrarySystem1
//
//  Created by prasanna gunuru on 6/5/14.
//  Copyright (c) 2014 PrasannaProjects. All rights reserved.
//

#import "LibraryTableViewController.h"

#import "ShelfTableViewController.h"

#import "LibrarySystem.h"

#import "Library.h"

@interface LibraryTableViewController ()

@property (nonatomic,strong) NSMutableArray *libraryList ;

@end

@implementation LibraryTableViewController

@synthesize libraryList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //self.myLibrariesList =[[NSMutableArray alloc] initWithObjects:@"library1",@"library2",@"library3",@"library4",nil];
    
    self.title = @"Libraries List";
    [self retrieveData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.myLibrariesList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell== nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Library *libraryObject = (Library*)[self.myLibrariesList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = libraryObject.name;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    // Configure the cell...
    
    return cell;
}
/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}*/


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell*)sender];
    [LibrarySystem instanceFromDictionary].libraryIndex =indexPath.row;
    ShelfTableViewController *shelfView = (ShelfTableViewController*)segue.destinationViewController;
    Library * libraryObject = [self.myLibrariesList objectAtIndex:indexPath.row];
    NSArray * shelves = libraryObject.shelf;
    shelfView.myShelvesList = shelves;
}



-(void) retrieveData
{
    /*NSString *filePath = [[NSBundle mainBundle]pathForResource:@"Librarysystem" ofType:@"json"];
    
    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
    
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];*/
    
    LibrarySystem *libraries = [LibrarySystem instanceFromDictionary];
    
    self.myLibrariesList = libraries.libraries;

    [self.tableView reloadData];
    
}

@end
