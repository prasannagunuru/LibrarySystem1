//
//  Shelf.h
//  LibrarySystem
//
//  Created by prasanna gunuru on 6/3/14.
//  Copyright (c) 2014 PrasannaProjects. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Book.h"

@interface Shelf : NSObject

@property (nonatomic,strong) NSArray * books;

-(void) addBook:(id)object;
-(void) removeBook:(id)object;

@end