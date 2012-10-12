//
//  OpenALSynthesizer.h
//  OpenALSynthesizer
//
//  Created by Kevin Harrington on 10/12/12.
//  Copyright (c) 2012 Kevin Harrington. All rights reserved.
//

#import <OpenAL/al.h>
#import <OpenAL/alc.h>

@interface OpenALSynthesizer : NSObject {
	ALCcontext* mContext;
	ALCdevice* mDevice;
	NSMutableDictionary *soundDictionary;
	NSMutableArray *bufferStorageArray;
}

-(id) init;
-(void) loadFile:(NSString *)soundName doesLoop:(BOOL)loops;
-(void) playSound:(NSString*)soundKey doesLoop:(BOOL)loops;
-(void) pauseAllSounds;
-(void) resumeAllSounds;
-(void) pauseSound:(NSString*)soundKey;

-(void) stopAllSounds;
-(void) loadFile:(NSString *)soundName withKey:(NSString*)key doesLoop:(BOOL)loops;


@property(nonatomic, copy) NSMutableDictionary	*soundDictionary;
@property(nonatomic, copy) NSMutableArray		*bufferStorageArray;

@end