#import <Foundation/Foundation.h>
#import "Book.h"

@interface Shelf : NSObject 

@property (nonatomic, copy) NSArray *books;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *shelfId;

+ (Shelf *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;
- (void)addBooksObject:(id )book;
- (void)removeBooksObject:(id)object;

@end
