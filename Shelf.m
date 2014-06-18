#import "Shelf.h"


@implementation Shelf


+ (Shelf *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Shelf *instance = [[Shelf alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forKey:(NSString *)key {

    if ([key isEqualToString:@"books"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                Book *populatedMember = [Book instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }

            self.books = myMembers;

        }

    } else {
        [super setValue:value forKey:key];
    }

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"shelfId"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}

-(void)addBooksObject:(id)object {
    
    if([object isKindOfClass:[Book class]])
    {
        NSMutableArray * myBooks = [NSMutableArray arrayWithArray:self.books];
        
        [myBooks addObject:object];
        
        self.books=myBooks;
    }
}

-(void)removeBooksObject:(id)object {
    
    if([object isKindOfClass:[Book class]])
    {
        NSMutableArray * myBooks = [NSMutableArray arrayWithArray:self.books];
        
        [myBooks removeObject:object];
        
        self.books = myBooks;
        
    } 
}



@end
