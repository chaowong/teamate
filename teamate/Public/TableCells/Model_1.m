#import "Model_1.h"

@implementation Model_1

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(id)initDataWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}
@end
