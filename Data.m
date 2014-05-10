//
//  Data.m
//  Notes
//
//  Created by Caleb Alebiosu on 5/9/14.
//  Copyright (c) 2014 Caleb Alebiosu. All rights reserved.
//

#import "Data.h"

@implementation Data

static NSMutableDictionary *allNotes = nil;
static NSString *currentKey = nil;

+(NSMutableDictionary *)getAllNotes{
    if(allNotes == nil){
        //allNotes = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:kAllNotes]];
        allNotes = [[NSMutableDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:[self filePath]]];
    }
    return allNotes;
}

+(void)setCurrentKey:(NSString *)key{
    currentKey = key;
}

+(NSString *)getCurrentKey{
    return currentKey;
}

+(void)setNoteForCurrentKey:(NSString *)note{
    [self setNote:note forKey:currentKey ];
}

+(void)setNote:(NSString *)note forKey:(NSString *)key{
    [allNotes setObject:note forKey:(NSString *)key];
}

+(void)removeNoteForKey:(NSString *)key{
    [allNotes removeObjectForKey:key];
}

+(void)saveNotes{
    //[[NSUserDefaults standardUserDefaults] setObject:allNotes forKey:kAllNotes];
    [allNotes writeToFile:[self filePath] atomically:YES];
}

+(NSString *)filePath{
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [directories objectAtIndex:0];
    return [documents stringByAppendingString:kAllNotes];
}

@end
