#import "LibrarySystem.h"

#import "Library.h"



static LibrarySystem * instance= nil;


@implementation LibrarySystem


+ (LibrarySystem *)instanceFromDictionary
{
    
    if( instance == nil)
    {
            instance = [[LibrarySystem alloc] init];
            [instance setAttributesFromDictionary:[instance retriveDataFromJson]];

        
    }
    
    return instance;
    
}

-(NSDictionary *)retriveDataFromJson
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"/LibrarySystemData.json"];
    //if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    //{
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
       
    //}
     return jsonData;
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];
}

- (void)setValue:(id)value forKey:(NSString *)key {

    if ([key isEqualToString:@"librarySystem"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value)
            {
                Library *populatedMember = [Library instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }

            self.libraries = myMembers;

        }

    } else {
        [super setValue:value forKey:key];
    }

}


@end
