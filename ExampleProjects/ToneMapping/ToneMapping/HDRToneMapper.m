//
//  HDRToneMapper.m
//  ToneMapping
//
//  Created by Kevin Harrington on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HDRToneMapper.h"

#define OFFSET_R        0
#define OFFSET_G        1
#define OFFSET_B        2
#define OFFSET_A        3

@interface HDRToneMapper (internal)
-(void)imageDump:(CGImageRef)cgimage;
-(UIImage *) invert: (CGImageRef)_CGImage;
-(UIImage *) tonemap:(float)gammaMedian;
@end

@interface HDRToneMapper()
@property (nonatomic) CGImageRef _originalImage1;
@property (nonatomic) CGImageRef _originalImage2;
@property (nonatomic) CGImageRef _originalImage3;
@end

@implementation HDRToneMapper

@synthesize _originalImage1, _originalImage2, _originalImage3;

- (id) initWithImages:(CGImageRef)img1 second:(CGImageRef)img2 third:(CGImageRef)img3 {
    self._originalImage1 = img1;
    self._originalImage2 = img2;
    self._originalImage3 = img3;
    return self;
}

+ (HDRToneMapper *)operationWithImages:(UIImage *)img1 second:(UIImage *)img2 third:(UIImage *)img3 {
    return [[[self class] alloc] initWithImages:[img1 CGImage] second:[img2 CGImage] third:[img3 CGImage]];
}

- (UIImage *) proccessImage:(float)middle {
    NSLog(@"Proccess image"); 
    
    return [self tonemap:middle];
}

-(UIImage *) tonemap:(float)middle {
    CFDataRef dataref = CGDataProviderCopyData(CGImageGetDataProvider(_originalImage1));
    
    size_t width=CGImageGetWidth(_originalImage1);
    size_t height=CGImageGetHeight(_originalImage1);
    size_t bitsPerComponent=CGImageGetBitsPerComponent(_originalImage1);
    size_t bitsPerPixel=CGImageGetBitsPerPixel(_originalImage1);
    size_t bytesPerRow=CGImageGetBytesPerRow(_originalImage1);
    CGColorSpaceRef colorspace=CGImageGetColorSpace(_originalImage1);
    CGBitmapInfo bitmapInfo=CGImageGetBitmapInfo(_originalImage1);
    int length = height * width * 4;
    
    unsigned char *dataReturn = malloc(length);
    CGContextRef contextDataReturn = CGBitmapContextCreate(dataReturn, width, height,
                                                  bitsPerComponent, bytesPerRow, colorspace,
                                                  kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(contextDataReturn, CGRectMake(0, 0, width, height), _originalImage1);
    
    CGContextRelease(contextDataReturn);
    //CGImageRelease(_originalImage1);
    
    // img 1
    unsigned char *data1 = malloc(length);
    CGContextRef context1 = CGBitmapContextCreate(data1, width, height,
                                                 bitsPerComponent, bytesPerRow, colorspace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context1, CGRectMake(0, 0, width, height), _originalImage1);
    
    CGContextRelease(context1);
    //CGImageRelease(_originalImage1);
    
    // img 2
    unsigned char *data2 = malloc(length);
    CGContextRef context2 = CGBitmapContextCreate(data2, width, height,
                                                 bitsPerComponent, bytesPerRow, colorspace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context2, CGRectMake(0, 0, width, height), _originalImage2);
    
    CGContextRelease(context2);
    //CGImageRelease(_originalImage2);
    
    // img 3
    unsigned char *data3 = malloc(length);
    CGContextRef context3 = CGBitmapContextCreate(data3, width, height,
                                                 bitsPerComponent, bytesPerRow, colorspace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context3, CGRectMake(0, 0, width, height), _originalImage3);
    
    CGContextRelease(context3);
    //CGImageRelease(_originalImage3);
    
    //UInt8 *data = (UInt8 *)CFDataGetBytePtr(dataref);
    //int length = CFDataGetLength(dataref);
    
    /*
    // selective color HDR tonemapping, gives a crappy image IF in color
     
    for(int index=0;index<length;index+=4) {
        
        // red
        int r1 = abs(middle-data1[index+OFFSET_R]);
        int r2 = abs(middle-data2[index+OFFSET_R]);
        int r3 = abs(middle-data3[index+OFFSET_R]);
        int rmin = MIN(r1, MIN(r2, r3));
        if(r1 == rmin) {
            // do nothing because data1 is also the cache
        }
        else if(r2 == rmin) {
            data1[index+OFFSET_R] = data2[index+OFFSET_R];
        }
        else if(r3 == rmin) {
            data1[index+OFFSET_R] = data3[index+OFFSET_R];

        }
        
        // green
        int g1 = abs(middle-data1[index+OFFSET_G]);
        int g2 = abs(middle-data2[index+OFFSET_G]);
        int g3 = abs(middle-data3[index+OFFSET_G]);
        int gmin = MIN(g1, MIN(g2, g3));
        if(g1 == gmin) {
            // do nothing because data1 is also the cache
        }
        else if(g2 == gmin) {
            data1[index+OFFSET_G] = data2[index+OFFSET_G];
        }
        else if(g3 == gmin) {
            data1[index+OFFSET_G] = data3[index+OFFSET_G];
            
        }

        // blue
        int b1 = abs(middle-data1[index+OFFSET_B]);
        int b2 = abs(middle-data2[index+OFFSET_B]);
        int b3 = abs(middle-data3[index+OFFSET_B]);
        int bmin = MIN(b1, MIN(b2, b3));
        if(b1 == bmin) {
            // do nothing because data1 is also the cache
        }
        else if(b2 == bmin) {
            data1[index+OFFSET_B] = data2[index+OFFSET_B];
        }
        else if(b3 == bmin) {
            data1[index+OFFSET_B] = data3[index+OFFSET_B];
            
        }
    } */
    
    for(int index=0;index<length;index+=4) {
        int a1 = abs(middle-data1[index+OFFSET_R]) + abs(middle-data1[index+OFFSET_R]) + abs(middle-data1[index+OFFSET_R]);
        int a2 = abs(middle-data2[index+OFFSET_G]) + abs(middle-data2[index+OFFSET_G]) + abs(middle-data2[index+OFFSET_G]);
        int a3 = abs(middle-data3[index+OFFSET_B]) + abs(middle-data3[index+OFFSET_B]) + abs(middle-data3[index+OFFSET_B]);
        int amin = MIN(a1, MIN(a2, a3));
        if(a1 == amin) {
            // do nothing because data1 is also the cache
            dataReturn[index+OFFSET_R] = data1[index+OFFSET_R];
            dataReturn[index+OFFSET_G] = data1[index+OFFSET_G];
            dataReturn[index+OFFSET_B] = data1[index+OFFSET_B];
        }
        else if(a2 == amin) {
            dataReturn[index+OFFSET_R] = data2[index+OFFSET_R];
            dataReturn[index+OFFSET_G] = data2[index+OFFSET_G];
            dataReturn[index+OFFSET_B] = data2[index+OFFSET_B];
        }
        else if(a3 == amin) {
            dataReturn[index+OFFSET_R] = data3[index+OFFSET_R];
            dataReturn[index+OFFSET_G] = data3[index+OFFSET_G];
            dataReturn[index+OFFSET_B] = data3[index+OFFSET_B];            
        }
    }

    
    CFDataRef newData = CFDataCreate(NULL,dataReturn,length);
    //		NSData *newDataObject = [NSData dataWithBytesNoCopy:data length:length freeWhenDone:NO];
    //		CFDataRef newData = (CFDataRef)newDataObject;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(newData);
    //		CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, &data, length, NULL);
    
    CGImageRef newImage = CGImageCreate(width,height,bitsPerComponent,bitsPerPixel,bytesPerRow,colorspace,bitmapInfo,provider,nil,YES,kCGRenderingIntentPerceptual);
    
    UIImage * invertedImage = [[UIImage alloc] initWithCGImage:newImage];
    
    CGDataProviderRelease(provider);
    CFRelease(newData);
    free(data1);
    data1 = nil;
    CFRelease(dataref);
    return invertedImage;
}


-(UIImage *) invert: (CGImageRef)_CGImage {
    CFDataRef dataref = CGDataProviderCopyData(CGImageGetDataProvider(_CGImage));
    
    size_t width=CGImageGetWidth(_CGImage);
    size_t height=CGImageGetHeight(_CGImage);
    size_t bitsPerComponent=CGImageGetBitsPerComponent(_CGImage);
    size_t bitsPerPixel=CGImageGetBitsPerPixel(_CGImage);
    size_t bytesPerRow=CGImageGetBytesPerRow(_CGImage);
    CGColorSpaceRef colorspace=CGImageGetColorSpace(_CGImage);
    CGBitmapInfo bitmapInfo=CGImageGetBitmapInfo(_CGImage);
    
    int length = height * width * 4;
    unsigned char *data = malloc(length);
    CGContextRef context = CGBitmapContextCreate(data, width, height,
                                                 bitsPerComponent, bytesPerRow, colorspace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), _CGImage);
    
    CGContextRelease(context);
    CGImageRelease(_CGImage);
    
    //UInt8 *data = (UInt8 *)CFDataGetBytePtr(dataref);
    //int length = CFDataGetLength(dataref);
    
    
    //Apply the array
    for(int index=0;index<length;index+=4){
        data[index+OFFSET_R] = 255 - data[index+OFFSET_R];
        data[index+OFFSET_G] = 255 - data[index+OFFSET_G];
        data[index+OFFSET_B] = 255 - data[index+OFFSET_B];
    }
    
    CFDataRef newData = CFDataCreate(NULL,data,length);
    //		NSData *newDataObject = [NSData dataWithBytesNoCopy:data length:length freeWhenDone:NO];
    //		CFDataRef newData = (CFDataRef)newDataObject;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(newData);
    //		CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, &data, length, NULL);
    
    _CGImage = CGImageCreate(width,height,bitsPerComponent,bitsPerPixel,bytesPerRow,colorspace,bitmapInfo,provider,nil,YES,kCGRenderingIntentPerceptual);
    
    UIImage * invertedImage = [[UIImage alloc] initWithCGImage:_CGImage];
    
    CGDataProviderRelease(provider);
    CFRelease(newData);
    free(data);
    data = nil;
    CFRelease(dataref);
    return invertedImage;
}

-(void)imageDump:(CGImageRef)cgimage {
    
    size_t width  = CGImageGetWidth(cgimage);
    size_t height = CGImageGetHeight(cgimage);
    
    size_t bpr = CGImageGetBytesPerRow(cgimage);
    size_t bpp = CGImageGetBitsPerPixel(cgimage);
    size_t bpc = CGImageGetBitsPerComponent(cgimage);
    size_t bytes_per_pixel = bpp / bpc;
    
    CGBitmapInfo info = CGImageGetBitmapInfo(cgimage);
    
    NSLog(
          @"\n"
          "CGImageGetHeight: %d\n"
          "CGImageGetWidth:  %d\n"
          "CGImageGetColorSpace: %@\n"
          "CGImageGetBitsPerPixel:     %d\n"
          "CGImageGetBitsPerComponent: %d\n"
          "CGImageGetBytesPerRow:      %d\n"
          "CGImageGetBitmapInfo: 0x%.8X\n"
          "  kCGBitmapAlphaInfoMask     = %s\n"
          "  kCGBitmapFloatComponents   = %s\n"
          "  kCGBitmapByteOrderMask     = %s\n"
          "  kCGBitmapByteOrderDefault  = %s\n"
          "  kCGBitmapByteOrder16Little = %s\n"
          "  kCGBitmapByteOrder32Little = %s\n"
          "  kCGBitmapByteOrder16Big    = %s\n"
          "  kCGBitmapByteOrder32Big    = %s\n",
          (int)width,
          (int)height,
          CGImageGetColorSpace(cgimage),
          (int)bpp,
          (int)bpc,
          (int)bpr,
          (unsigned)info,
          (info & kCGBitmapAlphaInfoMask)     ? "YES" : "NO",
          (info & kCGBitmapFloatComponents)   ? "YES" : "NO",
          (info & kCGBitmapByteOrderMask)     ? "YES" : "NO",
          (info & kCGBitmapByteOrderDefault)  ? "YES" : "NO",
          (info & kCGBitmapByteOrder16Little) ? "YES" : "NO",
          (info & kCGBitmapByteOrder32Little) ? "YES" : "NO",
          (info & kCGBitmapByteOrder16Big)    ? "YES" : "NO",
          (info & kCGBitmapByteOrder32Big)    ? "YES" : "NO"
          );
    
    CGDataProviderRef provider = CGImageGetDataProvider(cgimage);
    NSData* data = (__bridge id)CGDataProviderCopyData(provider);
    const uint8_t* bytes = [data bytes];
    
    printf("Pixel Data:\n");
    for(size_t row = 0; row < height; row++)
    {
        for(size_t col = 0; col < width; col++)
        {
            const uint8_t* pixel =
            &bytes[row * bpr + col * bytes_per_pixel];
            
            printf("(");
            for(size_t x = 0; x < bytes_per_pixel; x++)
            {
                printf("%d", pixel[x]);
                if( x < bytes_per_pixel - 1 ) {
                    printf(",");
                }
            }
            
            printf(")");
            if( col < width - 1 )
                printf(", ");
        }
        
        printf("\n");
    }
}


@end
