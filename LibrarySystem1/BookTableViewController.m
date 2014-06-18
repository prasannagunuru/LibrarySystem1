//
//  BookTableViewController.m
//  LibrarySystem1
//
//  Created by prasanna gunuru on 6/5/14.
//  Copyright (c) 2014 PrasannaProjects. All rights reserved.
//

#import "BookTableViewController.h"
#import "Book.h"
#import "BookDetailsViewController.h"
#import "LibrarySystem.h"



@interface BookTableViewController ()



@end

@implementation BookTableViewController

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
    
    self.title = @"Books List";
    
}
- (IBAction)deleteAction:(id)sender
{
    UIButton* senderBtn = (UIButton*)sender;
    
    CGPoint buttonRect = [self.view convertPoint:CGPointZero fromView:senderBtn];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonRect];
    [LibrarySystem instanceFromDictionary].bookIndex = indexPath.row;
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"/LibrarySystemData.json"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSMutableDictionary*jsonData = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
        NSMutableArray *libraryArray = [NSMutableArray arrayWithArray:[jsonData objectForKey:@"librarySystem"]];
        NSDictionary *libraryDictionary =[NSMutableDictionary dictionaryWithDictionary:libraryArray[[LibrarySystem instanceFromDictionary].libraryIndex]];
        NSMutableArray *shelfArray = [NSMutableArray arrayWithArray:[libraryDictionary objectForKey:@"shelf"]];
        NSDictionary *shelfDictionary = [NSMutableDictionary dictionaryWithDictionary:shelfArray[[LibrarySystem instanceFromDictionary].shelfIndex]];
        NSMutableArray *bookArray = [NSMutableArray arrayWithArray:[shelfDictionary objectForKey:@"books"]];
        
        [bookArray removeObject:bookArray[[LibrarySystem instanceFromDictionary].bookIndex]];

        [shelfDictionary setValue:bookArray forKey:@"books"];
        shelfArray[[LibrarySystem instanceFromDictionary].shelfIndex] = shelfDictionary;
        [libraryDictionary setValue:shelfArray forKey:@"shelf"];
        libraryArray[[LibrarySystem instanceFromDictionary].libraryIndex] = libraryDictionary;
        [jsonData setValue:libraryArray forKey:@"librarySystem"];
        data = [NSJSONSerialization dataWithJSONObject:jsonData options:NSJSONWritingPrettyPrinted error:NULL];
        [data writeToFile:path atomically:YES];

    }
    
    [self viewWillAppear:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    NSDictionary* result = [[LibrarySystem instanceFromDictionary] retriveDataFromJson];
    
    LibrarySystem* newSysytem =  [LibrarySystem new];
    [newSysytem setAttributesFromDictionary:result];
    
    Library* library = newSysytem.libraries[[LibrarySystem instanceFromDictionary].libraryIndex];
    Shelf* shelfObject = library.shelf[[LibrarySystem instanceFromDictionary].shelfIndex];

    self.myBooksList = shelfObject.books;
    [self.tableView reloadData];
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
    return [self.myBooksList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell== nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
        Book * bookobject = [self.myBooksList objectAtIndex:indexPath.row];
    
    cell.textLabel.text =bookobject.name;
    
    return cell;
}

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


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    BookDetailsViewController * bookDetailObject = (BookDetailsViewController *)segue.destinationViewController;
    UIButton* senderBtn = (UIButton*)sender;
    
    CGPoint buttonRect = [self.view convertPoint:CGPointZero fromView:senderBtn];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonRect];
    [LibrarySystem instanceFromDictionary].bookIndex = indexPath.row;
    bookDetailObject.bookDetails = [self.myBooksList objectAtIndex:indexPath.row];
    if([segue.identifier isEqualToString:@"createIdentifire"])
        bookDetailObject.mode = create;
    
    else if ([segue.identifier isEqualToString:@"readIdentifire"])
        bookDetailObject.mode = readBook;
    
    else if ([segue.identifier isEqualToString:@"updateIdentifire"])
        bookDetailObject.mode = update;  
}



/*- (IBAction)createBook:(id)sender {
    
    //if([book isKindOfClass:[Book class]])
    //{
        BookDetailsViewController *bookDetailObject = [BookDetailsViewController new];
    
        [self.navigationController pushViewController:bookDetailObject animated:YES];
        
    //}
    
}*/
@end
