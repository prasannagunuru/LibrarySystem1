#import "Book.h"

@interface Book ()

@property (nonatomic,strong) Shelf * currentShelf;

@end

@implementation Book

+ (Book *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Book *instance = [[Book alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"bookId"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}

-(void) enshelf:(id)toShelf {
    
    if([toShelf isKindOfClass:[Shelf class]])
    {
        if(self.currentShelf != (Shelf *)toShelf)
        {
            [self unshelf];
            
            [toShelf addBooksObject:self];
            
            self.currentShelf = toShelf;
        }
    }
    
    

}

-(void) unshelf {
    
    if(self.currentShelf != NULL)
    {
        [self.currentShelf removeBooksObject:self];
        
        self.currentShelf = NULL;
        
    }
    
}



@end
