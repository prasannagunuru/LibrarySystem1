//
//  Shelf.m
//  LibrarySystem
//
//  Created by prasanna gunuru on 6/3/14.
//  Copyright (c) 2014 PrasannaProjects. All rights reserved.
//

#import "Shelf.h"

@implementation Shelf

-(void) addBook:(id)object
{
    if([object isKindOfClass:[Book class]])
    {
        NSMutableArray * myBooks = [NSMutableArray arrayWithArray:self.books];
        
        [myBooks addObject:(Book *)object];
        
        self.books=myBooks;
        
    }
    
}

-(void) removeBook:(id)object
{
    if([object isKindOfClass:[Book class]])
    {
        NSMutableArray * myBooks = [NSMutableArray arrayWithArray:self.books];
        
        [myBooks removeObject:(Book *)object];
        
        self.books = myBooks;
    
    }
}

@end

