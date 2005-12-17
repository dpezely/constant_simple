/******************************************************************************
* Module:  constant_simple.h
* Version: 1
* Created: 14 January 2003
* Author:  Daniel Joseph Pezely <Pez@play.org>
******************************************************************************/

#ifndef _constant_simple_H_
#define _constant_simple_H_

#include <stdio.h>
#include <shader.h>

typedef struct
{
	miColor color; /* Color to use for the interior */
} constant_simple_params;
extern "C" {
DLLEXPORT int constant_simple_version(void);
DLLEXPORT miBoolean constant_simple(
	miColor *out_pResult,
	miState *state,
	constant_simple_params *in_pParams
);
}
#endif
