//
//  OpenALSynthesizer.m
//  OpenALSynthesizer
//
//  Created by Kevin Harrington on 10/12/12.
//  Copyright (c) 2012 Kevin Harrington. All rights reserved.
//

#import "OpenALSynthesizer.h"

#import <AudioToolbox/AudioToolbox.h>
#import <CoreAudio/CoreAudioTypes.h>

@implementation OpenALSynthesizer
@synthesize bufferStorageArray, soundDictionary;
// start up openAL
-(id)init
{
    self = [super init];
	NSLog(@"initOpenAl");
	// Initialization
	mDevice = alcOpenDevice(NULL); // select the "preferred device"
	if (mDevice)
	{
		// use the device to make a context
		mContext=alcCreateContext(mDevice,NULL);
		// set my context to the currently active one
		alcMakeContextCurrent(mContext);
	}
	soundDictionary = [[NSMutableDictionary alloc] init];
	NSLog( @"Sound dict has %i sounds", [soundDictionary count]);
    
    return self;
}

// open the audio file
// returns a big audio ID struct
-(AudioFileID)openAudioFile:(NSString*)filePath
{
	AudioFileID outAFID;
	// use the NSURl instead of a cfurlref cuz it is easier
	NSURL * afUrl = [NSURL fileURLWithPath:filePath];
    
	// do some platform specific stuff..
#if TARGET_OS_IPHONE
	OSStatus result = AudioFileOpenURL((__bridge CFURLRef)afUrl, kAudioFileReadPermission, 0, &outAFID);
#else
	OSStatus result = AudioFileOpenURL((CFURLRef)afUrl, fsRdPerm, 0, &outAFID);
#endif
	if (result != 0) NSLog(@"cannot open file: %@",filePath);
	return outAFID;
}

// find the audio portion of the file
// return the size in bytes
-(UInt32)audioFileSize:(AudioFileID)fileDescriptor
{
	UInt64 outDataSize = 0;
	UInt32 thePropSize = sizeof(UInt64);
	OSStatus result = AudioFileGetProperty(fileDescriptor, kAudioFilePropertyAudioDataByteCount, &thePropSize, &outDataSize);
	if(result != 0) NSLog(@"cannot find file size");
	return (UInt32)outDataSize;
}

-(void)loadFile:(NSString *)soundName doesLoop:(BOOL)loops
{
	[self loadFile:soundName withKey:soundName doesLoop:loops];
}

-(void)loadFile:(NSString *)soundName withKey:(NSString*)key doesLoop:(BOOL)loops
{
	// get the full path of the file
	NSString* fileName = [[NSBundle mainBundle] pathForResource:soundName ofType:@"caf"];
    NSLog(@"Sound nam:%@", soundName);
    NSLog(@"\nFile path:%@", fileName);
    
	// first, open the file
	AudioFileID fileID = [self openAudioFile:fileName];
    
	// find out how big the actual audio data is
	UInt32 fileSize = [self audioFileSize:fileID];
    
	// this is where the audio data will live for the moment
	void * outData = malloc(fileSize);
    
	// this where we actually get the bytes from the file and put them
	// into the data buffer
	OSStatus result = noErr;
	result = AudioFileReadBytes(fileID, false, 0, &fileSize, outData);
	AudioFileClose(fileID); //close the file
    
	if (result != 0) NSLog(@"cannot load effect: %@",fileName);
    
	NSUInteger bufferID;
	// grab a buffer ID from openAL
	alGenBuffers(1, &bufferID);
    
	// jam the audio data into the new buffer
	alBufferData(bufferID,AL_FORMAT_STEREO16,outData,fileSize,44100);
    
	// save the buffer so I can release it later
	[bufferStorageArray addObject:[NSNumber numberWithUnsignedInteger:bufferID]];
    
	NSUInteger sourceID;
    
	// grab a source ID from openAL
	alGenSources(1, &sourceID);
    
	NSLog(@"the id is %i", sourceID);
    
	// attach the buffer to the source
	alSourcei(sourceID, AL_BUFFER, bufferID);
	// set some basic source prefs
	alSourcef(sourceID, AL_PITCH, 1.0f);
	alSourcef(sourceID, AL_GAIN, 1.0f);
	if (loops) alSourcei(sourceID, AL_LOOPING, AL_TRUE);
    
	// store this for future use
	[soundDictionary setObject:[NSNumber numberWithUnsignedInt:sourceID] forKey:key];
    
	// clean up the buffer
	if (outData)
	{
		free(outData);
		outData = NULL;
	}
}

// the main method: grab the sound ID from the library
// and start the source playing
-(void) playSound:(NSString*)soundKey doesLoop:(BOOL)loops {
	NSNumber * numVal = [soundDictionary objectForKey:soundKey];
	if (numVal == nil)
	{
		NSLog(@"sound doesnt exist!");
		return;
	}
	NSLog(@"%@ is being played!", soundKey);
	NSUInteger sourceID = [numVal unsignedIntValue];
    if(loops)
        alSourcei(sourceID, AL_LOOPING, AL_TRUE);
    else
        alSourcei(sourceID, AL_LOOPING, AL_FALSE);
	alSourcePlay(sourceID);
}

// stops a sound by a certain soundKey
- (void)stopSound:(NSString*)soundKey
{
	NSNumber * numVal = [soundDictionary objectForKey:soundKey];
	if (numVal == nil) return;
	NSUInteger sourceID = [numVal unsignedIntValue];
	alSourceStop(sourceID);
}

// pauses a sound by a certain soundKey
- (void)pauseSound:(NSString*)soundKey
{
	NSLog(@"pauseSound");
	NSNumber * numVal = [soundDictionary objectForKey:soundKey];
	if (numVal == nil) return;
	NSUInteger sourceID = [numVal unsignedIntValue];
	alSourcePause(sourceID);
}

// checks the states of all the sounds, if its playing it pauses it
-(void) pauseAllSounds
{
	NSLog(@"pauseAllSounds");
	for (NSNumber * sourceNumber in [soundDictionary allValues])
	{
		NSUInteger sourceID = [sourceNumber unsignedIntegerValue];
		ALint state;
		alGetSourcei(sourceID, AL_SOURCE_STATE, &state);
        
		if( state == AL_PLAYING)
		{
			alSourcePause(sourceID);
		}
	}
}

// checks the states of all the sounds, if its paused it plays it
-(void) resumeAllSounds
{
	for (NSNumber * sourceNumber in [soundDictionary allValues])
	{
		NSUInteger sourceID = [sourceNumber unsignedIntegerValue];
		ALint state;
		alGetSourcei(sourceID, AL_SOURCE_STATE, &state);
        
		if( state == AL_PAUSED)
		{
			alSourcePlay(sourceID);
		}
	}
}

// checks the states of all the sounds, if its playing it stops it
-(void) stopAllSounds
{
	NSLog(@"pauseAllSounds");
	for (NSNumber * sourceNumber in [soundDictionary allValues])
	{
		NSUInteger sourceID = [sourceNumber unsignedIntegerValue];
		ALint state;
		alGetSourcei(sourceID, AL_SOURCE_STATE, &state);
        
		if( state == AL_PLAYING)
		{
			alSourceStop(sourceID);
		}
	}
}

-(void)cleanUpOpenAL
{
	// delete the sources
	for (NSNumber * sourceNumber in [soundDictionary allValues])
	{
		NSUInteger sourceID = [sourceNumber unsignedIntegerValue];
		alDeleteSources(1, &sourceID);
	}
	[soundDictionary removeAllObjects];
    
	// delete the buffers
	for (NSNumber * bufferNumber in bufferStorageArray)
	{
		NSUInteger bufferID = [bufferNumber unsignedIntegerValue];
		alDeleteBuffers(1, &bufferID);
	}
	[bufferStorageArray removeAllObjects];
    
	// destroy the context
	alcDestroyContext(mContext);
	// close the device
	alcCloseDevice(mDevice);
}

- (void) dealloc
{
	[self stopAllSounds];
	//[soundDictionary dealloc];
	//[bufferStorageArray dealloc];
	//[super dealloc];
}
@end
