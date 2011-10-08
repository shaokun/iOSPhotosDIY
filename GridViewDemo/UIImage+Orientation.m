#import "UIImage+Orientation.h"

@implementation UIImage (Orientation)

// Source: http://stackoverflow.com/questions/5427656/ios-uiimagepickercontroller-result-image-orientation-after-upload
- (UIImage *)imageOrientedUpMirrored {
	
	CGAffineTransform transform = CGAffineTransformIdentity;
	switch (self.imageOrientation) {
	case UIImageOrientationUp:
	break;
	
	case UIImageOrientationUpMirrored:
		return self;
	break;
	
	case UIImageOrientationDown:
	case UIImageOrientationDownMirrored:
		transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
		transform = CGAffineTransformRotate(transform, M_PI);
	break;
	
	case UIImageOrientationLeft:
	case UIImageOrientationLeftMirrored:
		transform = CGAffineTransformTranslate(transform, self.size.width, 0);
		transform = CGAffineTransformRotate(transform, M_PI_2);
	break;
	
	case UIImageOrientationRight:
	case UIImageOrientationRightMirrored:
		transform = CGAffineTransformTranslate(transform, 0, self.size.height);
		transform = CGAffineTransformRotate(transform, -M_PI_2);
	break;
	}
	
	switch (self.imageOrientation) {
	case UIImageOrientationUp:
	case UIImageOrientationDown:
		transform = CGAffineTransformTranslate(transform, 0, self.size.height);
		transform = CGAffineTransformScale(transform, 1, -1);
	break;
	
	case UIImageOrientationLeft:
	case UIImageOrientationRight:
		transform = CGAffineTransformTranslate(transform, 0, self.size.width);
		transform = CGAffineTransformScale(transform, 1, -1);
	break;
	
	default:
	break;
	}
	
	CGContextRef context = CGBitmapContextCreate(NULL, self.size.width, self.size.height, CGImageGetBitsPerComponent(self.CGImage), 0, CGImageGetColorSpace(self.CGImage), CGImageGetBitmapInfo(self.CGImage));
	CGContextConcatCTM(context, transform);
	
	CGFloat width;
	CGFloat height;
	switch (self.imageOrientation) {
	case UIImageOrientationLeft:
	case UIImageOrientationLeftMirrored:
	case UIImageOrientationRight:
	case UIImageOrientationRightMirrored:
		width = self.size.height;
		height = self.size.width;
	break;
	
	default:
		width = self.size.width;
		height = self.size.height;
	break;
	}
	CGRect frame = CGRectMake(0, 0, width, height);
	CGContextDrawImage(context, frame, self.CGImage);
	
	CGImageRef cgImage = CGBitmapContextCreateImage(context);
	UIImage *image = [UIImage imageWithCGImage:cgImage];
	CGContextRelease(context);
	CGImageRelease(cgImage);
	return image;	
}

@end