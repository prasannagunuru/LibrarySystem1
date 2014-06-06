//
//  Book.m
//  LibrarySystem
//
//  Created by prasanna gunuru on 6/3/14.
//  Copyright (c) 2014 PrasannaProjects. All rights reserved.
//

#import "Book.h"

@interface Book ()

@property (nonatomic,strong) Shelf * currentShelf;

@end

@implementation Book

-(void) enshelf:(id)toShelf
{
    if([toShelf isKindOfClass:[Shelf class]])
    {
        if(self.currentShelf != (Shelf *)toShelf)
        {
            [self unshelf];
            
            [(Shelf *)toShelf addBook:self];
            
            self.currentShelf = (Shelf *)toShelf;
        }
    }

}


-(void) unshelf
{
    if(self.currentShelf != NULL)
    {
        [self.currentShelf removeBook:self];
        
        self.currentShelf = NULL;
        
    }
    
}



@end