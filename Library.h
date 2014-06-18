#import <Foundation/Foundation.h>
#import "Shelf.h"

@interface Library : NSObject 
@property (nonatomic, copy) NSNumber *libraryId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *shelf;

+ (Library *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;
//-(void) addShelfObject:(id)object;

@end
