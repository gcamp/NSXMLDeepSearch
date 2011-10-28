//
//  NSXMLNode+DeepSearch.h
//  NSXMLDeepSearchExample
//
//  Created by Guillaume Campagna on 11-10-27.
//  Copyright (c) 2011 LittleKiwi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSXMLNode (DeepSearch)

- (NSXMLNode *)attributeForName:(NSString *)name;

//Search on children
- (NSXMLNode *)childWithName:(NSString *)name;
- (NSXMLNode *)childWithClass:(NSString *)className;
- (NSXMLNode *)childWithValue:(NSString *)value ofAttribute:(NSString*)attribute;

- (NSArray *)childrenWithName:(NSString *)name;
- (NSArray *)childrenWithClass:(NSString *)className;
- (NSArray *)childrenWithValue:(NSString *)value ofAttribute:(NSString*)attribute;

//Search on all nodes
- (NSXMLNode *)deepNodeWithName:(NSString *)name;
- (NSXMLNode *)deepNodeWithClass:(NSString *)className;
- (NSXMLNode *)deepNodeWithValue:(NSString *)value ofAttribute:(NSString*)attribute;

- (NSArray *)deepNodesWithName:(NSString *)name;
- (NSArray *)deepNodesWithClass:(NSString *)className;
- (NSArray *)deepNodesWithValue:(NSString *)value ofAttribute:(NSString*)attribute;

@end
