#import <Foundation/Foundation.h>
#import "Library.h"




@interface LibrarySystem : NSObject

@property (nonatomic, copy) NSArray *libraries;
@property (nonatomic) NSInteger libraryIndex;
@property (nonatomic) NSInteger shelfIndex;
@property (nonatomic) NSInteger bookIndex;


+ (LibrarySystem *)instanceFromDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;
-(NSDictionary *)retriveDataFromJson;

@end
