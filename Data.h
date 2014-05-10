//
//  Data.h
//  Notes
//
//  Created by Caleb Alebiosu on 5/9/14.
//  Copyright (c) 2014 Caleb Alebiosu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kDeafultText @"New Note"
#define kAllNotes @"notes"
#define kDetailView @"showDetail"

@interface Data : NSObject

+(NSMutableDictionary *)getAllNotes;
+(void)setCurrentKey:(NSString *)key;
+(NSString *)getCurrentKey;
+(void)setNoteForCurrentKey:(NSString *)note;
+(void)setNote:(NSString *)note forKey:(NSString *)key;
+(void)removeNoteForKey:(NSString *)key;
+(void)saveNotes;


@end
