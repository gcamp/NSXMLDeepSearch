//
//  NSXMLNode+DeepSearch.m
//  NSXMLDeepSearchExample
//
//  Created by Guillaume Campagna on 11-10-27.
//  Copyright (c) 2011 LittleKiwi. All rights reserved.
//

#import "NSXMLNode+DeepSearch.h"

@interface NSXMLNode (DeepSearchPrivate)

- (id)nodesWithName:(NSString*)name onAllElement:(BOOL) allElement firstElementOnly:(BOOL) first;
- (id)nodesWithValue:(NSString*)value ofAttribute:(NSString*)attribute onAllElement:(BOOL) allElement firstElementOnly:(BOOL) first;

@end

@implementation NSXMLNode (DeepSearch)

#pragma mark - Find attribute

- (NSXMLNode *)attributeForName:(NSString *)name {
    NSXMLElement* element = (NSXMLElement*) self;
    if (![element isKindOfClass:[NSXMLElement class]]) element = [[[NSXMLElement alloc] initWithXMLString:element.XMLString error:nil] autorelease];
    
    return [element attributeForName:name];
}

#pragma mark - Single Child

- (NSXMLNode *)childWithName:(NSString *)name {
    return [self nodesWithName:name onAllElement:NO firstElementOnly:YES];
}

- (NSXMLNode *)childWithClass:(NSString *)className {
    return [self childWithValue:className ofAttribute:@"class"];
}

- (NSXMLNode *)childWithValue:(NSString *)value ofAttribute:(NSString *)attribute {
    return [self nodesWithValue:value ofAttribute:attribute onAllElement:NO firstElementOnly:YES];
}

#pragma mark - Multiple Children

- (NSArray *)childrenWithName:(NSString *)name {
    return [self nodesWithName:name onAllElement:NO firstElementOnly:NO];
}

- (NSArray *)childrenWithClass:(NSString *)className {
    return [self childrenWithValue:className ofAttribute:@"class"];
}

- (NSArray *)childrenWithValue:(NSString *)value ofAttribute:(NSString *)attribute {
    return [self nodesWithValue:value ofAttribute:attribute onAllElement:NO firstElementOnly:NO];
}

#pragma mark - Single Node

- (NSXMLNode *)deepNodeWithName:(NSString *)name {
    return [self nodesWithName:name onAllElement:YES firstElementOnly:YES];
}

- (NSXMLNode *)deepNodeWithClass:(NSString *)className {
    return [self deepNodeWithValue:className ofAttribute:@"class"];
}

- (NSXMLNode *)deepNodeWithValue:(NSString *)value ofAttribute:(NSString *)attribute {
    return [self nodesWithValue:value ofAttribute:attribute onAllElement:YES firstElementOnly:YES];
}

#pragma mark - Multiple Nodes

- (NSArray *)deepNodesWithName:(NSString *)name {
    return [self nodesWithName:name onAllElement:YES firstElementOnly:NO];
}

- (NSArray *)deepNodesWithClass:(NSString *)className {
    return [self deepNodesWithValue:className ofAttribute:@"class"];
}

- (NSArray *)deepNodesWithValue:(NSString *)value ofAttribute:(NSString *)attribute {
    return [self nodesWithValue:value ofAttribute:attribute onAllElement:YES firstElementOnly:NO];
}

#pragma mark - Private search node methods

- (id)nodesWithName:(NSString *)name onAllElement:(BOOL) allElement  firstElementOnly:(BOOL)first {
    NSMutableArray* nodes = first ? nil : [NSMutableArray array];
    
    for (NSXMLNode* child in self.children) {
        if ([child.name isEqualToString:name]) {
            if (first) return child;
            else [nodes addObject:child];
        }
        
        if (allElement) {
            if (first) {
                NSXMLNode* foundNode = [child deepNodeWithName:name];
                if (foundNode != nil) return foundNode;
            }
            else [nodes addObjectsFromArray:[child deepNodesWithName:name]];  
        }
    }
    
    return nodes;
}

- (id)nodesWithValue:(NSString *)value ofAttribute:(NSString *)attribute onAllElement:(BOOL) allElement firstElementOnly:(BOOL)first {
    NSMutableArray* nodes = first ? nil : [NSMutableArray array];

    for (NSXMLNode* child in self.children) {        
        if ([[[child attributeForName:attribute] stringValue] isEqualToString:value]) {
            if (first) return child;
            else [nodes addObject:child];
        }
        
        if (allElement) {
            if (first) {
                NSXMLNode* foundNode = [child deepNodeWithValue:value ofAttribute:attribute];
                if (foundNode != nil) return foundNode;
            }
            else [nodes addObjectsFromArray:[child deepNodesWithValue:value ofAttribute:attribute]];  
        }
    }
    
    return nodes;
}

@end
