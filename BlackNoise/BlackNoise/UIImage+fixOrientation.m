//
//  UIImage+fixOrientation.m
//  iLuxury
//
//  Created by Sadaharu on 8/26/13.
//  Copyright (c) 2013 PolluxChen. All rights reserved.
//

#import "UIImage+fixOrientation.h"

@implementation UIImage (fixOrientation)

+ (UIImage*)scaleImage:(UIImage*)image scale:(float)scale
{
    return [self scaleImage:image toSize:CGSizeMake(image.size.width*scale, image.size.width*scale)];
}

+ (UIImage*)scaleImage:(UIImage*)image toSize:(CGSize)newSize
{
    if (CGSizeEqualToSize(image.size, newSize)) {
        return image;
    }
    
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

+ (UIImage*)scaleImageToScreenSize:(UIImage*)image
{
    int width = MIN(640, image.size.width);
    int height = image.size.height * width/image.size.width;
    return [self scaleImage:image toSize:CGSizeMake(width, height)];
}

- (UIImage *)fixOrientation
{
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
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
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage *)getImageFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)getHDImageFromView:(UIView *)view
{
    return [UIImage getHDImageFromView:view expectFrame:view.bounds];
}

+ (UIImage *)getHDImageFromView:(UIView *)view expectFrame:(CGRect)expectFrame
{
    CGRect drawingRect = CGRectMake(0, 0, expectFrame.size.width, expectFrame.size.height);
    UIGraphicsBeginImageContextWithOptions(drawingRect.size, view.opaque, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, RGB(41, 42, 48).CGColor);
    CGContextFillRect(context, drawingRect);
    CGRect viewRect = CGRectOffset(view.bounds, -expectFrame.origin.x, -expectFrame.origin.y);
    [view drawViewHierarchyInRect:viewRect afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)appendImageFromImageArray:(NSArray *)imgArray
{
    if (imgArray.count <= 0) {
        return nil;
    }
    
    CGFloat ratio = SizeOfIphone6P654(3.0f, 2.0f, 2.0f, 2.0f);
    
    float width = [(UIImage *)imgArray[0] size].width * ratio;
    float totalHeight = 0.0;
    for (UIImage *img in imgArray) {
        totalHeight += img.size.height;
    }
    totalHeight = totalHeight * ratio;
    
    CGSize desSize = CGSizeMake(width, totalHeight);
    
    UIGraphicsBeginImageContext(desSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, totalHeight);
    CGContextScaleCTM(context, 1.0, -1.0);
    
//    由后往前draw
    float offsetY = 0.0;
    for (int i = (int)imgArray.count - 1; i >= 0; i--) {
        UIImage *img = imgArray[i];
        CGSize drawSize = CGSizeMake(img.size.width * ratio, img.size.height * ratio);
        
        CGContextDrawImage(context, CGRectMake(0, offsetY, drawSize.width, drawSize.height), img.CGImage);
        offsetY += drawSize.height;
    }
    
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImg;

}

- (UIImage *)circleImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(2.5, 2.5, self.size.width -5, self.size.height - 5);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
