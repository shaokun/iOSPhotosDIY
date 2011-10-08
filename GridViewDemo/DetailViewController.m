#import "DetailViewController.h"
#import "TouchPhotoView.h"
#import "Photo.h"

@implementation DetailViewController

@synthesize photos;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int width = self.view.frame.size.width;
    int height = self.view.frame.size.height;
    
    CGRect frame = CGRectMake(0, 0, width, height);
    imageScroller = [[UIScrollView alloc] initWithFrame:frame];
    
    for (NSInteger index = 0; index < photos.count; ++index) {
        Photo *photo = [photos objectAtIndex:index];
        TouchPhotoView *touchPhotoView = [[TouchPhotoView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        touchPhotoView.delegate = self;
        touchPhotoView.image = photo.image;
        
        [imageScroller addSubview:touchPhotoView];
        
        int x = frame.size.width * index;
        touchPhotoView.frame = CGRectMake(x, 0, width, height);
    }
    
    imageScroller.pagingEnabled = YES;
    imageScroller.contentSize = CGSizeMake(width * photos.count, height);
    imageScroller.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:imageScroller];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [imageScroller release];
    [super dealloc];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	TouchPhotoView *touchPhotoView = (TouchPhotoView *)scrollView;
	return touchPhotoView.imageView;
}

@end
