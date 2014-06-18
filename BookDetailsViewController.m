//
//  BookDetailsViewController.m
//  LibrarySystem1
//
//  Created by prasanna gunuru on 6/13/14.
//  Copyright (c) 2014 PrasannaProjects. All rights reserved.
//

#import "BookDetailsViewController.h"
#import "BookTableViewController.h"
#import "LibrarySystem.h"


@interface BookDetailsViewController ()

@property (nonatomic,strong) NSMutableDictionary *bookDictionary;
@end

@implementation BookDetailsViewController
@synthesize bookDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard:)];
    [self.view addGestureRecognizer:tap];
    
    self.bookDictionary = [NSMutableDictionary dictionary];
    
    self.title = @"Book Details";
    
    

    switch (self.mode) {
        case create:
        {
            self.title = @"Create Book Details";
            [self.bookName setHidden:TRUE];
            [self.bookAuthor setHidden:TRUE];
            NSLog(@"Create action");
            break;
        }
            
        case readBook:
        {
        
            self.title = @"Read Book Details";
            self.bookName.text = self.bookDetails.name;
            self.bookAuthor.text = self.bookDetails.author;
            [self.bookNameTextField setHidden:TRUE];
            [self.bookAuthorTextField setHidden:TRUE];
            [self.saveButton setHidden:TRUE];
            
            NSLog(@"read action");
        
            break;
        }
        
        case update:
        {
            self.title = @"Update Book Details";
            self.bookNameTextField.text=  self.bookDetails.name;
            self.bookAuthorTextField.text=  self.bookDetails.author;
            [self.bookName setHidden:TRUE];
            [self.bookAuthor setHidden:TRUE];
            NSLog(@"update action");

            break;
        }
        default:
            break;
    }
    
}
- (IBAction)saveActions:(id)sender
{
    //Book *bookObject;
    
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
        
        
    
        if(self.mode == create)
        {
            
            //bookObject.name = self.bookNameTextField.text;
            //bookObject.author = self.bookAuthorTextField.text;
            //bookDictionary = (NSMutableDictionary *)bookObject;
            [bookDictionary  setObject:self.bookNameTextField.text forKey:@"name"];
            [bookDictionary setObject:self.bookAuthorTextField.text forKey:@"author"];
            [bookArray addObject:bookDictionary];
            
        }
        else
        {
            
            bookDictionary = bookArray[[LibrarySystem instanceFromDictionary].bookIndex];
            [bookDictionary setObject:self.bookNameTextField.text forKey:@"name"];
            [bookDictionary setObject:self.bookAuthorTextField.text forKey:@"author"];
            bookArray[[LibrarySystem instanceFromDictionary].bookIndex]=bookDictionary;

        }
        
        [shelfDictionary setValue:bookArray forKey:@"books"];
        shelfArray[[LibrarySystem instanceFromDictionary].shelfIndex] = shelfDictionary;
        [libraryDictionary setValue:shelfArray forKey:@"shelf"];
        libraryArray[[LibrarySystem instanceFromDictionary].libraryIndex] = libraryDictionary;
        [jsonData setValue:libraryArray forKey:@"librarySystem"];
        data = [NSJSONSerialization dataWithJSONObject:jsonData options:NSJSONWritingPrettyPrinted error:NULL];
        [data writeToFile:path atomically:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)dismissKeyBoard:(id)sender {
 
    [self.bookAuthorTextField resignFirstResponder];
    [self.bookNameTextField resignFirstResponder];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
