/*
 *  $Id$
 *
 *  Copyright (C) 2006 Stephen F. Booth <me@sbooth.org>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#import "AudioMetadataReader.h"
#import "FLACMetadataReader.h"
#import "OggVorbisMetadataReader.h"
#import "MusepackMetadataReader.h"
#import "MP3MetadataReader.h"

NSString *const AudioMetadataReaderErrorDomain = @"org.sbooth.Play.ErrorDomain.AudioMetadataReader";

@implementation AudioMetadataReader

+ (AudioMetadataReader *) metadataReaderForURL:(NSURL *)url error:(NSError **)error
{
	NSParameterAssert(nil != url);
	NSParameterAssert([url isFileURL]);
	
	AudioMetadataReader				*result;
	NSString						*path;
	NSString						*pathExtension;
	
	path							= [url path];
	pathExtension					= [[path pathExtension] lowercaseString];
	
	if([pathExtension isEqualToString:@"flac"]) {
		result						= [[FLACMetadataReader alloc] init];
		
		[result setValue:url forKey:@"url"];
	}
	else if([pathExtension isEqualToString:@"ogg"]) {
		result						= [[OggVorbisMetadataReader alloc] init];
		
		[result setValue:url forKey:@"url"];
	}
	else if([pathExtension isEqualToString:@"mpc"]) {
		result						= [[MusepackMetadataReader alloc] init];
		
		[result setValue:url forKey:@"url"];
	}
	else if([pathExtension isEqualToString:@"mp3"]) {
		result						= [[MP3MetadataReader alloc] init];
		
		[result setValue:url forKey:@"url"];
	}
	else {
		result						= [[AudioMetadataReader alloc] init];
		
		[result setValue:url forKey:@"url"];
	}
	
	return [result autorelease];
}

- (BOOL)			readMetadata:(NSError **)error			{ return YES; }

@end