//
//  Shader.h
//  iOSShaders
//
//  Created by Teste on 03/06/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shader : NSObject


@property (nonatomic) GLuint program;
@property (nonatomic) NSString* name;

- (BOOL)loadShadersName:(NSString*) shaderName;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;
-(BOOL) readParams;

@end
