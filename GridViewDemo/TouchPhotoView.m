#import "TouchPhotoView.h"
#import "Photo.h"

CGRect CGRectCenteredInRect(CGRect inner, CGRect outer) {	
	inner.origin.x = fmaxf(0, (outer.size.width - inner.size.width) / 2);
	inner.origin.y = fmaxf(0, (outer.size.height - inner.size.height) / 2);
	
	return inner;
}

@implementation TouchPhotoView

@synthesize photo;

- (void)toggleZoomIntoLocation:(CGPoint)location {
	CGFloat scale;
	CGRect zoomRect = CGRectZero;
		
	if (self.zoomScale > initialZoom) {
		scale = initialZoom;
		
		zoomRect.origin.x = 0;
		zoomRect.origin.y = 0;
	} else {
		scale = 1.5;
		
		zoomRect.origin.x = location.x - (zoomRect.size.width / scale);
		zoomRect.origin.y = location.y - (zoomRect.size.height / scale);
	}

	zoomRect.size.width  = self.frame.size.width  / scale;	
	zoomRect.size.height = self.frame.size.height / scale;

	[self zoomToRect:zoomRect animated:YES];
}

- (UIImageView *)imageView {
	return imageView;
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.contentSize = frame.size;
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = NO;
		self.alwaysBounceVertical = NO;
		self.alwaysBounceHorizontal = NO;
		self.bounces = NO;
		self.bouncesZoom = NO;
		
		imageView = [UIImageView new];
		[self addSubview:imageView];
		
		activityIndicator = [[UIActivityIndicatorView alloc]
			initWithActivityIndicatorStyle:
				UIActivityIndicatorViewStyleWhiteLarge];
		activityIndicator.hidesWhenStopped = YES;
		[activityIndicator startAnimating];
		[self addSubview:activityIndicator];
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];

	CGSize size = self.frame.size;
	activityIndicator.center = CGPointMake(size.width / 2, size.height / 2);
	
	imageView.frame = CGRectCenteredInRect(imageView.frame, self.frame);
}

- (UIImage *)image {
	return imageView.image;
}

- (void)setImage:(UIImage *)image {
	[activityIndicator stopAnimating];
	
	CGSize viewSize = self.bounds.size;
	
    CGSize imageSize = image.size;

    // Configure zooming.
    CGFloat widthRatio = viewSize.width / imageSize.width;
    CGFloat heightRatio = viewSize.height / imageSize.height;

    if (ABS(widthRatio - heightRatio) < 0.1) {
        initialZoom = (widthRatio > heightRatio) ? widthRatio : heightRatio;

        imageView.frame = CGRectMake(0, 0, viewSize.width / initialZoom, 
            viewSize.height / initialZoom);
    } else {
        initialZoom = (widthRatio > heightRatio) ? heightRatio : widthRatio;
        imageView.frame = CGRectMake(0, 0, imageSize.width,
            imageSize.height);
    }
    
    self.contentSize = imageView.frame.size;
    self.maximumZoomScale = 3;
    self.minimumZoomScale = initialZoom;
    self.zoomScale = initialZoom;
    
    imageView.image = image;
    imageView.contentMode = UIViewContentModeCenter;

    //[self setNeedsLayout];
}

#pragma mark - Memory Managment

- (void)dealloc {
	[photo release];
	[imageView release];
	[activityIndicator release];
	[super dealloc];
}

@end