//
//  Book.h
//  LibrarySystem
//
//  Created by prasanna gunuru on 6/3/14.
//  Copyright (c) 2014 PrasannaProjects. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Shelf.h"

@interface Book : NSObject

-(void) enshelf : (id) toShelf;
-(void) unshelf;

@end
