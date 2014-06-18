#import <Foundation/Foundation.h>

#import "Shelf.h"

@interface Book : NSObject 

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSNumber *bookId;
@property (nonatomic, copy) NSString *name;

+ (Book *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;
-(void) enshelf : (id) toShelf ;
-(void) unshelf;

@end
