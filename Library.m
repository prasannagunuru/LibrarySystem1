#import "Library.h"

@implementation Library


+ (Library *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Library *instance = [[Library alloc] init];
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

    if ([key isEqualToString:@"shelf"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                Shelf *populatedMember = [Shelf instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }

            self.shelf = myMembers;

        }

    } else {
        [super setValue:value forKey:key];
    }

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"libraryId"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}

/*-(void) addShelfObject:(id)object{
    
    if([object isKindOfClass:[Shelf class]])
    {
    
        NSMutableArray * myShelves = [NSMutableArray arrayWithArray:self.shelf];
    
        [myShelves addObject:object];
    
        self.shelf=myShelves;
    }
}*/



@end
