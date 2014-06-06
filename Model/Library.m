//
//  Library.m
//  LibrarySystem
//
//  Created by prasanna gunuru on 6/3/14.
//  Copyright (c) 2014 PrasannaProjects. All rights reserved.
//

#import "Library.h"

@implementation Library

-(void) addShelf:(id)object
{
    if([object isKindOfClass:[Shelf class]])
    {
        
        NSMutableArray * myShelves = [NSMutableArray arrayWithArray:self.shelves];
        
        [myShelves addObject:(Shelf *)object];
        
        self.shelves=myShelves;
    }
   
}

@end
