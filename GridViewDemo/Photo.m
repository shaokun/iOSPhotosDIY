#import "Photo.h"

@implementation Photo

@synthesize image, thumbImage;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc {
    [image release];
    [thumbImage release];
    [super dealloc];
}

@end
