/******************************************************************************
* Module:  constant_simple.cpp
* Created: 14 January 2003
* Author:  Daniel Joseph Pezely <Pez@play.org>
******************************************************************************/

#include "constant_simple.h"

/*------------------------------------------------------------------*/
/* Version number function for the constant_simple shader           */
DLLEXPORT int constant_simple_version(void) { return 1; }

/*------------------------------------------------------------------*/
/* Main entry point for the show edges shader.                      */
DLLEXPORT miBoolean constant_simple( miColor *out_pResult,
   				     miState *state,
				     constant_simple_params *in_pParams)
{
  miVector vector;

  mi_point_to_object(state, &vector, &state->point);
  // we do nothing with vector.x,y,z

  *out_pResult = *mi_eval_color( &(in_pParams->color) );

  return(miTRUE);
}
