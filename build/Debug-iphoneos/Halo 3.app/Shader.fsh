//
//  Shader.fsh
//  Halo 3
//
//  Created by spencer whyte on 09-10-15.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
	gl_FragColor = colorVarying;
}
