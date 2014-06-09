//
//  Shader.fsh
//  iOSShaders
//
//  Created by Teste on 03/06/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
