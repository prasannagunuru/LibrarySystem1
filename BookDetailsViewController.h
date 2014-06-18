//
//  BookDetailsViewController.h
//  LibrarySystem1
//
//  Created by prasanna gunuru on 6/13/14.
//  Copyright (c) 2014 PrasannaProjects. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"



typedef NS_ENUM(NSInteger, UpdateActionMode) {
    create ,
    readBook,
    update 
    
};

@interface BookDetailsViewController : UIViewController {
   
}
@property (nonatomic,strong) Book * bookDetails;
@property (nonatomic) UpdateActionMode mode;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UITextField *bookNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *bookAuthorTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;


@end
