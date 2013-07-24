--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
with
  System,
  Neo.Data_Types,
  Ada.Wide_Text_IO,
  Ada.Characters.Handling;
use
  System,
  Neo.Data_Types,
  Ada.Wide_Text_IO,
  Ada.Characters.Handling;
package body Neo.Command.System.Processor.Geometry.Graphics.OpenGL
  is pragma Source_File_Name("neo-graphics-opengl.adb");
/*
====================
GL_SelectTexture
====================
*/
void GL_SelectTexture( int unit ) {
    if ( backEnd.glState.currenttmu == unit ) {
        return;
    }

    if ( unit < 0 || unit >= glConfig.maxTextureImageUnits ) {
        common->Warning( "GL_SelectTexture: unit = %i", unit );
        return;
    }

    RENDERLOG_PRINTF( "GL_SelectTexture( %i );\n", unit );

    backEnd.glState.currenttmu = unit;
}

/*
====================
GL_Cull

This handles the flipping needed when the view being
rendered is a mirored view.
====================
*/
void GL_Cull( int cullType ) {
    if ( backEnd.glState.faceCulling == cullType ) {
        return;
    }

    if ( cullType == CT_TWO_SIDED ) {
        qglDisable( GL_CULL_FACE );
    } else  {
        if ( backEnd.glState.faceCulling == CT_TWO_SIDED ) {
            qglEnable( GL_CULL_FACE );
        }

        if ( cullType == CT_BACK_SIDED ) {
            if ( backEnd.viewDef->isMirror ) {
                qglCullFace( GL_FRONT );
            } else {
                qglCullFace( GL_BACK );
            }
        } else {
            if ( backEnd.viewDef->isMirror ) {
                qglCullFace( GL_BACK );
            } else {
                qglCullFace( GL_FRONT );
            }
        }
    }

    backEnd.glState.faceCulling = cullType;
}

/*
====================
GL_Scissor
====================
*/
void GL_Scissor( int x /* left*/, int y /* bottom */, int w, int h ) {
    qglScissor( x, y, w, h );
}

/*
====================
GL_Viewport
====================
*/
void GL_Viewport( int x /* left */, int y /* bottom */, int w, int h ) {
    qglViewport( x, y, w, h );
}

/*
====================
GL_PolygonOffset
====================
*/
void GL_PolygonOffset( float scale, float bias ) {
    backEnd.glState.polyOfsScale = scale;
    backEnd.glState.polyOfsBias = bias;
    if ( backEnd.glState.glStateBits & GLS_POLYGON_OFFSET ) {
        qglPolygonOffset( scale, bias );
    }
}

/*
========================
GL_DepthBoundsTest
========================
*/
void GL_DepthBoundsTest( const float zmin, const float zmax ) {
    if ( !glConfig.depthBoundsTestAvailable || zmin > zmax ) {
        return;
    }

    if ( zmin == 0.0f && zmax == 0.0f ) {
        qglDisable( GL_DEPTH_BOUNDS_TEST_EXT );
    } else {
        qglEnable( GL_DEPTH_BOUNDS_TEST_EXT );
        qglDepthBoundsEXT( zmin, zmax );
    }
}

/*
========================
GL_StartDepthPass
========================
*/
void GL_StartDepthPass( const idScreenRect & rect ) {
}

/*
========================
GL_FinishDepthPass
========================
*/
void GL_FinishDepthPass() {
}

/*
========================
GL_GetDepthPassRect
========================
*/
void GL_GetDepthPassRect( idScreenRect & rect ) {
    rect.Clear();
}

/*
====================
GL_Color
====================
*/
void GL_Color( float * color ) {
    if ( color == NULL ) {
        return;
    }
    GL_Color( color[0], color[1], color[2], color[3] );
}

/*
====================
GL_Color
====================
*/
void GL_Color( float r, float g, float b ) {
    GL_Color( r, g, b, 1.0f );
}

/*
====================
GL_Color
====================
*/
void GL_Color( float r, float g, float b, float a ) {
    float parm[4];
    parm[0] = idMath::ClampFloat( 0.0f, 1.0f, r );
    parm[1] = idMath::ClampFloat( 0.0f, 1.0f, g );
    parm[2] = idMath::ClampFloat( 0.0f, 1.0f, b );
    parm[3] = idMath::ClampFloat( 0.0f, 1.0f, a );
    renderProgManager.SetRenderParm( RENDERPARM_COLOR, parm );
}

/*
========================
GL_Clear
========================
*/
void GL_Clear( bool color, bool depth, bool stencil, byte stencilValue, float r, float g, float b, float a ) {
    int clearFlags = 0;
    if ( color ) {
        qglClearColor( r, g, b, a );
        clearFlags |= GL_COLOR_BUFFER_BIT;
    }
    if ( depth ) {
        clearFlags |= GL_DEPTH_BUFFER_BIT;
    }
    if ( stencil ) {
        qglClearStencil( stencilValue );
        clearFlags |= GL_STENCIL_BUFFER_BIT;
    }
    qglClear( clearFlags );
}

/*
========================
GL_SetDefaultState

This should initialize all GL state that any part of the entire program
may touch, including the editor.
========================
*/
void GL_SetDefaultState() {
    RENDERLOG_PRINTF( "--- GL_SetDefaultState ---\n" );

    qglClearDepth( 1.0f );

    -- make sure our GL state vector is set correctly
    memset( &backEnd.glState, 0, sizeof( backEnd.glState ) );
    GL_State( 0, true );

    -- These are changed by GL_Cull
    qglCullFace( GL_FRONT_AND_BACK );
    qglEnable( GL_CULL_FACE );

    -- These are changed by GL_State
    qglColorMask( GL_TRUE, GL_TRUE, GL_TRUE, GL_TRUE );
    qglBlendFunc( GL_ONE, GL_ZERO );
    qglDepthMask( GL_TRUE );
    qglDepthFunc( GL_LESS );
    qglDisable( GL_STENCIL_TEST );
    qglDisable( GL_POLYGON_OFFSET_FILL );
    qglDisable( GL_POLYGON_OFFSET_LINE );
    qglPolygonMode( GL_FRONT_AND_BACK, GL_FILL );

    -- These should never be changed
    qglShadeModel( GL_SMOOTH );
    qglEnable( GL_DEPTH_TEST );
    qglEnable( GL_BLEND );
    qglEnable( GL_SCISSOR_TEST );
    qglDrawBuffer( GL_BACK );
    qglReadBuffer( GL_BACK );

    if ( r_useScissor.GetBool() ) {
        qglScissor( 0, 0, renderSystem->GetWidth(), renderSystem->GetHeight() );
    }
}

/*
====================
GL_State

This routine is responsible for setting the most commonly changed state
====================
*/
void GL_State( uint64 stateBits, bool forceGlState ) {
    uint64 diff = stateBits ^ backEnd.glState.glStateBits;

    if ( !r_useStateCaching.GetBool() || forceGlState ) {
        -- make sure everything is set all the time, so we
        -- can see if our delta checking is screwing up
        diff = 0xFFFFFFFFFFFFFFFF;
    } else if ( diff == 0 ) {
        return;
    }

    --
    -- check depthFunc bits
    --
    if ( diff & GLS_DEPTHFUNC_BITS ) {
        switch ( stateBits & GLS_DEPTHFUNC_BITS ) {
            case GLS_DEPTHFUNC_EQUAL:   qglDepthFunc( GL_EQUAL ); break;
            case GLS_DEPTHFUNC_ALWAYS:  qglDepthFunc( GL_ALWAYS ); break;
            case GLS_DEPTHFUNC_LESS:    qglDepthFunc( GL_LEQUAL ); break;
            case GLS_DEPTHFUNC_GREATER: qglDepthFunc( GL_GEQUAL ); break;
        }
    }

    --
    -- check blend bits
    --
    if ( diff & ( GLS_SRCBLEND_BITS | GLS_DSTBLEND_BITS ) ) {
        GLenum srcFactor = GL_ONE;
        GLenum dstFactor = GL_ZERO;

        switch ( stateBits & GLS_SRCBLEND_BITS ) {
            case GLS_SRCBLEND_ZERO:                 srcFactor = GL_ZERO; break;
            case GLS_SRCBLEND_ONE:                  srcFactor = GL_ONE; break;
            case GLS_SRCBLEND_DST_COLOR:            srcFactor = GL_DST_COLOR; break;
            case GLS_SRCBLEND_ONE_MINUS_DST_COLOR:  srcFactor = GL_ONE_MINUS_DST_COLOR; break;
            case GLS_SRCBLEND_SRC_ALPHA:            srcFactor = GL_SRC_ALPHA; break;
            case GLS_SRCBLEND_ONE_MINUS_SRC_ALPHA:  srcFactor = GL_ONE_MINUS_SRC_ALPHA; break;
            case GLS_SRCBLEND_DST_ALPHA:            srcFactor = GL_DST_ALPHA; break;
            case GLS_SRCBLEND_ONE_MINUS_DST_ALPHA:  srcFactor = GL_ONE_MINUS_DST_ALPHA; break;
            default:
                assert( !"GL_State: invalid src blend state bits\n" );
                break;
        }

        switch ( stateBits & GLS_DSTBLEND_BITS ) {
            case GLS_DSTBLEND_ZERO:                 dstFactor = GL_ZERO; break;
            case GLS_DSTBLEND_ONE:                  dstFactor = GL_ONE; break;
            case GLS_DSTBLEND_SRC_COLOR:            dstFactor = GL_SRC_COLOR; break;
            case GLS_DSTBLEND_ONE_MINUS_SRC_COLOR:  dstFactor = GL_ONE_MINUS_SRC_COLOR; break;
            case GLS_DSTBLEND_SRC_ALPHA:            dstFactor = GL_SRC_ALPHA; break;
            case GLS_DSTBLEND_ONE_MINUS_SRC_ALPHA:  dstFactor = GL_ONE_MINUS_SRC_ALPHA; break;
            case GLS_DSTBLEND_DST_ALPHA:            dstFactor = GL_DST_ALPHA; break;
            case GLS_DSTBLEND_ONE_MINUS_DST_ALPHA:  dstFactor = GL_ONE_MINUS_DST_ALPHA; break;
            default:
                assert( !"GL_State: invalid dst blend state bits\n" );
                break;
        }

        -- Only actually update GL's blend func if blending is enabled.
        if ( srcFactor == GL_ONE && dstFactor == GL_ZERO ) {
            qglDisable( GL_BLEND );
        } else {
            qglEnable( GL_BLEND );
            qglBlendFunc( srcFactor, dstFactor );
        }
    }

    --
    -- check depthmask
    --
    if ( diff & GLS_DEPTHMASK ) {
        if ( stateBits & GLS_DEPTHMASK ) {
            qglDepthMask( GL_FALSE );
        } else {
            qglDepthMask( GL_TRUE );
        }
    }

    --
    -- check colormask
    --
    if ( diff & (GLS_REDMASK|GLS_GREENMASK|GLS_BLUEMASK|GLS_ALPHAMASK) ) {
        GLboolean r = ( stateBits & GLS_REDMASK ) ? GL_FALSE : GL_TRUE;
        GLboolean g = ( stateBits & GLS_GREENMASK ) ? GL_FALSE : GL_TRUE;
        GLboolean b = ( stateBits & GLS_BLUEMASK ) ? GL_FALSE : GL_TRUE;
        GLboolean a = ( stateBits & GLS_ALPHAMASK ) ? GL_FALSE : GL_TRUE;
        qglColorMask( r, g, b, a );
    }

    --
    -- fill/line mode
    --
    if ( diff & GLS_POLYMODE_LINE ) {
        if ( stateBits & GLS_POLYMODE_LINE ) {
            qglPolygonMode( GL_FRONT_AND_BACK, GL_LINE );
        } else {
            qglPolygonMode( GL_FRONT_AND_BACK, GL_FILL );
        }
    }

    --
    -- polygon offset
    --
    if ( diff & GLS_POLYGON_OFFSET ) {
        if ( stateBits & GLS_POLYGON_OFFSET ) {
            qglPolygonOffset( backEnd.glState.polyOfsScale, backEnd.glState.polyOfsBias );
            qglEnable( GL_POLYGON_OFFSET_FILL );
            qglEnable( GL_POLYGON_OFFSET_LINE );
        } else {
            qglDisable( GL_POLYGON_OFFSET_FILL );
            qglDisable( GL_POLYGON_OFFSET_LINE );
        }
    }

#if !defined( USE_CORE_PROFILE )
    --
    -- alpha test
    --
    if ( diff & ( GLS_ALPHATEST_FUNC_BITS | GLS_ALPHATEST_FUNC_REF_BITS ) ) {
        if ( ( stateBits & GLS_ALPHATEST_FUNC_BITS ) != 0 ) {
            qglEnable( GL_ALPHA_TEST );

            GLenum func = GL_ALWAYS;
            switch ( stateBits & GLS_ALPHATEST_FUNC_BITS ) {
                case GLS_ALPHATEST_FUNC_LESS:       func = GL_LESS; break;
                case GLS_ALPHATEST_FUNC_EQUAL:      func = GL_EQUAL; break;
                case GLS_ALPHATEST_FUNC_GREATER:    func = GL_GEQUAL; break;
                default: assert( false );
            }
            GLclampf ref = ( ( stateBits & GLS_ALPHATEST_FUNC_REF_BITS ) >> GLS_ALPHATEST_FUNC_REF_SHIFT ) / (float)0xFF;
            qglAlphaFunc( func, ref );
        } else {
            qglDisable( GL_ALPHA_TEST );
        }
    }
#endif

    --
    -- stencil
    --
    if ( diff & ( GLS_STENCIL_FUNC_BITS | GLS_STENCIL_OP_BITS ) ) {
        if ( ( stateBits & ( GLS_STENCIL_FUNC_BITS | GLS_STENCIL_OP_BITS ) ) != 0 ) {
            qglEnable( GL_STENCIL_TEST );
        } else {
            qglDisable( GL_STENCIL_TEST );
        }
    }
    if ( diff & ( GLS_STENCIL_FUNC_BITS | GLS_STENCIL_FUNC_REF_BITS | GLS_STENCIL_FUNC_MASK_BITS ) ) {
        GLuint ref = GLuint( ( stateBits & GLS_STENCIL_FUNC_REF_BITS ) >> GLS_STENCIL_FUNC_REF_SHIFT );
        GLuint mask = GLuint( ( stateBits & GLS_STENCIL_FUNC_MASK_BITS ) >> GLS_STENCIL_FUNC_MASK_SHIFT );
        GLenum func = 0;

        switch ( stateBits & GLS_STENCIL_FUNC_BITS ) {
            case GLS_STENCIL_FUNC_NEVER:        func = GL_NEVER; break;
            case GLS_STENCIL_FUNC_LESS:         func = GL_LESS; break;
            case GLS_STENCIL_FUNC_EQUAL:        func = GL_EQUAL; break;
            case GLS_STENCIL_FUNC_LEQUAL:       func = GL_LEQUAL; break;
            case GLS_STENCIL_FUNC_GREATER:      func = GL_GREATER; break;
            case GLS_STENCIL_FUNC_NOTEQUAL:     func = GL_NOTEQUAL; break;
            case GLS_STENCIL_FUNC_GEQUAL:       func = GL_GEQUAL; break;
            case GLS_STENCIL_FUNC_ALWAYS:       func = GL_ALWAYS; break;
        }
        qglStencilFunc( func, ref, mask );
    }
    if ( diff & ( GLS_STENCIL_OP_FAIL_BITS | GLS_STENCIL_OP_ZFAIL_BITS | GLS_STENCIL_OP_PASS_BITS ) ) {
        GLenum sFail = 0;
        GLenum zFail = 0;
        GLenum pass = 0;

        switch ( stateBits & GLS_STENCIL_OP_FAIL_BITS ) {
            case GLS_STENCIL_OP_FAIL_KEEP:      sFail = GL_KEEP; break;
            case GLS_STENCIL_OP_FAIL_ZERO:      sFail = GL_ZERO; break;
            case GLS_STENCIL_OP_FAIL_REPLACE:   sFail = GL_REPLACE; break;
            case GLS_STENCIL_OP_FAIL_INCR:      sFail = GL_INCR; break;
            case GLS_STENCIL_OP_FAIL_DECR:      sFail = GL_DECR; break;
            case GLS_STENCIL_OP_FAIL_INVERT:    sFail = GL_INVERT; break;
            case GLS_STENCIL_OP_FAIL_INCR_WRAP: sFail = GL_INCR_WRAP; break;
            case GLS_STENCIL_OP_FAIL_DECR_WRAP: sFail = GL_DECR_WRAP; break;
        }
        switch ( stateBits & GLS_STENCIL_OP_ZFAIL_BITS ) {
            case GLS_STENCIL_OP_ZFAIL_KEEP:     zFail = GL_KEEP; break;
            case GLS_STENCIL_OP_ZFAIL_ZERO:     zFail = GL_ZERO; break;
            case GLS_STENCIL_OP_ZFAIL_REPLACE:  zFail = GL_REPLACE; break;
            case GLS_STENCIL_OP_ZFAIL_INCR:     zFail = GL_INCR; break;
            case GLS_STENCIL_OP_ZFAIL_DECR:     zFail = GL_DECR; break;
            case GLS_STENCIL_OP_ZFAIL_INVERT:   zFail = GL_INVERT; break;
            case GLS_STENCIL_OP_ZFAIL_INCR_WRAP:zFail = GL_INCR_WRAP; break;
            case GLS_STENCIL_OP_ZFAIL_DECR_WRAP:zFail = GL_DECR_WRAP; break;
        }
        switch ( stateBits & GLS_STENCIL_OP_PASS_BITS ) {
            case GLS_STENCIL_OP_PASS_KEEP:      pass = GL_KEEP; break;
            case GLS_STENCIL_OP_PASS_ZERO:      pass = GL_ZERO; break;
            case GLS_STENCIL_OP_PASS_REPLACE:   pass = GL_REPLACE; break;
            case GLS_STENCIL_OP_PASS_INCR:      pass = GL_INCR; break;
            case GLS_STENCIL_OP_PASS_DECR:      pass = GL_DECR; break;
            case GLS_STENCIL_OP_PASS_INVERT:    pass = GL_INVERT; break;
            case GLS_STENCIL_OP_PASS_INCR_WRAP: pass = GL_INCR_WRAP; break;
            case GLS_STENCIL_OP_PASS_DECR_WRAP: pass = GL_DECR_WRAP; break;
        }
        qglStencilOp( sFail, zFail, pass );
    }

    backEnd.glState.glStateBits = stateBits;
}

/*
=================
GL_GetCurrentState
=================
*/
uint64 GL_GetCurrentState() {
    return backEnd.glState.glStateBits;
}

/*
========================
GL_GetCurrentStateMinusStencil
========================
*/
uint64 GL_GetCurrentStateMinusStencil() {
    return GL_GetCurrentState() & ~(GLS_STENCIL_OP_BITS|GLS_STENCIL_FUNC_BITS|GLS_STENCIL_FUNC_REF_BITS|GLS_STENCIL_FUNC_MASK_BITS);
}

#include "../tr_local.h"
#include "../../framework/Common_local.h"

idCVar r_drawFlickerBox( "r_drawFlickerBox", "0", CVAR_RENDERER | CVAR_BOOL, "visual test for dropping frames" );
idCVar stereoRender_warp( "stereoRender_warp", "0", CVAR_RENDERER | CVAR_ARCHIVE | CVAR_BOOL, "use the optical warping renderprog instead of stereoDeGhost" );
idCVar stereoRender_warpStrength( "stereoRender_warpStrength", "1.45", CVAR_RENDERER | CVAR_ARCHIVE | CVAR_FLOAT, "amount of pre-distortion" );

idCVar stereoRender_warpCenterX( "stereoRender_warpCenterX", "0.5", CVAR_RENDERER | CVAR_FLOAT | CVAR_ARCHIVE, "center for left eye, right eye will be 1.0 - this" );
idCVar stereoRender_warpCenterY( "stereoRender_warpCenterY", "0.5", CVAR_RENDERER | CVAR_FLOAT | CVAR_ARCHIVE, "center for both eyes" );
idCVar stereoRender_warpParmZ( "stereoRender_warpParmZ", "0", CVAR_RENDERER | CVAR_FLOAT | CVAR_ARCHIVE, "development parm" );
idCVar stereoRender_warpParmW( "stereoRender_warpParmW", "0", CVAR_RENDERER | CVAR_FLOAT | CVAR_ARCHIVE, "development parm" );
idCVar stereoRender_warpTargetFraction( "stereoRender_warpTargetFraction", "1.0", CVAR_RENDERER | CVAR_FLOAT | CVAR_ARCHIVE, "fraction of half-width the through-lens view covers" );

idCVar r_showSwapBuffers( "r_showSwapBuffers", "0", CVAR_BOOL, "Show timings from GL_BlockingSwapBuffers" );
idCVar r_syncEveryFrame( "r_syncEveryFrame", "1", CVAR_BOOL, "Don't let the GPU buffer execution past swapbuffers" );

static int      swapIndex;      -- 0 or 1 into renderSync
static GLsync   renderSync[2];

void GLimp_SwapBuffers();
void RB_SetMVP( const idRenderMatrix & mvp );

/*
============================================================================

RENDER BACK END THREAD FUNCTIONS

============================================================================
*/

/*
=============
RB_DrawFlickerBox
=============
*/
static void RB_DrawFlickerBox() {
    if ( !r_drawFlickerBox.GetBool() ) {
        return;
    }
    if ( tr.frameCount & 1 ) {
        qglClearColor( 1, 0, 0, 1 );
    } else {
        qglClearColor( 0, 1, 0, 1 );
    }
    qglScissor( 0, 0, 256, 256 );
    qglClear( GL_COLOR_BUFFER_BIT );
}

/*
=============
RB_SetBuffer
=============
*/
static void RB_SetBuffer( const void *data ) {
    -- see which draw buffer we want to render the frame to

    const setBufferCommand_t * cmd = (const setBufferCommand_t *)data;

    RENDERLOG_PRINTF( "---------- RB_SetBuffer ---------- to buffer # %d\n", cmd->buffer );

    GL_Scissor( 0, 0, tr.GetWidth(), tr.GetHeight() );

    -- clear screen for debugging
    -- automatically enable this with several other debug tools
    -- that might leave unrendered portions of the screen
    if ( r_clear.GetFloat() || idStr::Length( r_clear.GetString() ) != 1 || r_singleArea.GetBool() || r_showOverDraw.GetBool() ) {
        float c[3];
        if ( sscanf( r_clear.GetString(), "%f %f %f", &c[0], &c[1], &c[2] ) == 3 ) {
            GL_Clear( true, false, false, 0, c[0], c[1], c[2], 1.0f );
        } else if ( r_clear.GetInteger() == 2 ) {
            GL_Clear( true, false, false, 0, 0.0f, 0.0f,  0.0f, 1.0f );
        } else if ( r_showOverDraw.GetBool() ) {
            GL_Clear( true, false, false, 0, 1.0f, 1.0f, 1.0f, 1.0f );
        } else {
            GL_Clear( true, false, false, 0, 0.4f, 0.0f, 0.25f, 1.0f );
        }
    }
}

/*
=============
GL_BlockingSwapBuffers

We want to exit this with the GPU idle, right at vsync
=============
*/
const void GL_BlockingSwapBuffers() {
    RENDERLOG_PRINTF( "***************** GL_BlockingSwapBuffers *****************\n\n\n" );

    const int beforeFinish = Sys_Milliseconds();

    if ( !glConfig.syncAvailable ) {
        glFinish();
    }

    const int beforeSwap = Sys_Milliseconds();
    if ( r_showSwapBuffers.GetBool() && beforeSwap - beforeFinish > 1 ) {
        common->Printf( "%i msec to glFinish\n", beforeSwap - beforeFinish );
    }

    GLimp_SwapBuffers();

    const int beforeFence = Sys_Milliseconds();
    if ( r_showSwapBuffers.GetBool() && beforeFence - beforeSwap > 1 ) {
        common->Printf( "%i msec to swapBuffers\n", beforeFence - beforeSwap );
    }

    if ( glConfig.syncAvailable ) {
        swapIndex ^= 1;

        if ( qglIsSync( renderSync[swapIndex] ) ) {
            qglDeleteSync( renderSync[swapIndex] );
        }
        -- draw something tiny to ensure the sync is after the swap
        const int start = Sys_Milliseconds();
        qglScissor( 0, 0, 1, 1 );
        qglEnable( GL_SCISSOR_TEST );
        qglClear( GL_COLOR_BUFFER_BIT );
        renderSync[swapIndex] = qglFenceSync( GL_SYNC_GPU_COMMANDS_COMPLETE, 0 );
        const int end = Sys_Milliseconds();
        if ( r_showSwapBuffers.GetBool() && end - start > 1 ) {
            common->Printf( "%i msec to start fence\n", end - start );
        }

        GLsync  syncToWaitOn;
        if ( r_syncEveryFrame.GetBool() ) {
            syncToWaitOn = renderSync[swapIndex];
        } else {
            syncToWaitOn = renderSync[!swapIndex];
        }

        if ( qglIsSync( syncToWaitOn ) ) {
            for ( GLenum r = GL_TIMEOUT_EXPIRED; r == GL_TIMEOUT_EXPIRED; ) {
                r = qglClientWaitSync( syncToWaitOn, GL_SYNC_FLUSH_COMMANDS_BIT, 1000 * 1000 );
            }
        }
    }

    const int afterFence = Sys_Milliseconds();
    if ( r_showSwapBuffers.GetBool() && afterFence - beforeFence > 1 ) {
        common->Printf( "%i msec to wait on fence\n", afterFence - beforeFence );
    }

    const int64 exitBlockTime = Sys_Microseconds();

    static int64 prevBlockTime;
    if ( r_showSwapBuffers.GetBool() && prevBlockTime ) {
        const int delta = (int) ( exitBlockTime - prevBlockTime );
        common->Printf( "blockToBlock: %i\n", delta );
    }
    prevBlockTime = exitBlockTime;
}

/*
====================
R_MakeStereoRenderImage
====================
*/
static void R_MakeStereoRenderImage( idImage *image ) {
    idImageOpts opts;
    opts.width = renderSystem->GetWidth();
    opts.height = renderSystem->GetHeight();
    opts.numLevels = 1;
    opts.format = FMT_RGBA8;
    image->AllocImage( opts, TF_LINEAR, TR_CLAMP );
}

/*
====================
RB_StereoRenderExecuteBackEndCommands

Renders the draw list twice, with slight modifications for left eye / right eye
====================
*/
void RB_StereoRenderExecuteBackEndCommands( const emptyCommand_t * const allCmds ) {
    uint64 backEndStartTime = Sys_Microseconds();

    -- If we are in a monoscopic context, this draws to the only buffer, and is
    -- the same as GL_BACK.  In a quad-buffer stereo context, this is necessary
    -- to prevent GL from forcing the rendering to go to both BACK_LEFT and
    -- BACK_RIGHT at a performance penalty.
    -- To allow stereo deghost processing, the views have to be copied to separate
    -- textures anyway, so there isn't any benefit to rendering to BACK_RIGHT for
    -- that eye.
    qglDrawBuffer( GL_BACK_LEFT );

    -- create the stereoRenderImage if we haven't already
    static idImage * stereoRenderImages[2];
    for ( int i = 0; i < 2; i++ ) {
        if ( stereoRenderImages[i] == NULL ) {
            stereoRenderImages[i] = globalImages->ImageFromFunction( va("_stereoRender%i",i), R_MakeStereoRenderImage );
        }

        -- resize the stereo render image if the main window has changed size
        if ( stereoRenderImages[i]->GetUploadWidth() != renderSystem->GetWidth() ||
             stereoRenderImages[i]->GetUploadHeight() != renderSystem->GetHeight() ) {
            stereoRenderImages[i]->Resize( renderSystem->GetWidth(), renderSystem->GetHeight() );
        }
    }

    -- In stereoRender mode, the front end has generated two RC_DRAW_VIEW commands
    -- with slightly different origins for each eye.

    -- TODO: only do the copy after the final view has been rendered, not mirror subviews?

    -- Render the 3D draw views from the screen origin so all the screen relative
    -- texture mapping works properly, then copy the portion we are going to use
    -- off to a texture.
    bool foundEye[2] = { false, false };

    for ( int stereoEye = 1; stereoEye >= -1; stereoEye -= 2 ) {
        -- set up the target texture we will draw to
        const int targetEye = ( stereoEye == 1 ) ? 1 : 0;

        -- Set the back end into a known default state to fix any stale render state issues
        GL_SetDefaultState();
        renderProgManager.Unbind();
        renderProgManager.ZeroUniforms();

        for ( const emptyCommand_t * cmds = allCmds; cmds != NULL; cmds = (const emptyCommand_t *)cmds->next ) {
            switch ( cmds->commandId ) {
            case RC_NOP:
                break;
            case RC_DRAW_VIEW_GUI:
            case RC_DRAW_VIEW_3D:
                {
                    const drawSurfsCommand_t * const dsc = (const drawSurfsCommand_t *)cmds;
                    const viewDef_t     &   eyeViewDef = *dsc->viewDef;

                    if ( eyeViewDef.renderView.viewEyeBuffer && eyeViewDef.renderView.viewEyeBuffer != stereoEye ) {
                        -- this is the render view for the other eye
                        continue;
                    }

                    foundEye[ targetEye ] = true;
                    RB_DrawView( dsc, stereoEye );
                    if ( cmds->commandId == RC_DRAW_VIEW_GUI ) {
                    }
                }
                break;
            case RC_SET_BUFFER:
                RB_SetBuffer( cmds );
                break;
            case RC_COPY_RENDER:
                RB_CopyRender( cmds );
                break;
            case RC_POST_PROCESS:
                {
                    postProcessCommand_t * cmd = (postProcessCommand_t *)cmds;
                    if ( cmd->viewDef->renderView.viewEyeBuffer != stereoEye ) {
                        break;
                    }
                    RB_PostProcess( cmds );
                }
                break;
            default:
                common->Error( "RB_ExecuteBackEndCommands: bad commandId" );
                break;
            }
        }

        -- copy to the target
        stereoRenderImages[ targetEye ]->CopyFramebuffer( 0, 0, renderSystem->GetWidth(), renderSystem->GetHeight() );
    }

    -- perform the final compositing / warping / deghosting to the actual framebuffer(s)
    assert( foundEye[0] && foundEye[1] );

    GL_SetDefaultState();

    RB_SetMVP( renderMatrix_identity );

    -- If we are in quad-buffer pixel format but testing another 3D mode,
    -- make sure we draw to both eyes.  This is likely to be sub-optimal
    -- performance on most cards and drivers, but it is better than getting
    -- a confusing, half-ghosted view.
    if ( renderSystem->GetStereo3DMode() != STEREO3D_QUAD_BUFFER ) {
        glDrawBuffer( GL_BACK );
    }

    GL_State( GLS_DEPTHFUNC_ALWAYS );
    GL_Cull( CT_TWO_SIDED );

    -- We just want to do a quad pass - so make sure we disable any texgen and
    -- set the texture matrix to the identity so we don't get anomalies from
    -- any stale uniform data being present from a previous draw call
    const float texS[4] = { 1.0f, 0.0f, 0.0f, 0.0f };
    const float texT[4] = { 0.0f, 1.0f, 0.0f, 0.0f };
    renderProgManager.SetRenderParm( RENDERPARM_TEXTUREMATRIX_S, texS );
    renderProgManager.SetRenderParm( RENDERPARM_TEXTUREMATRIX_T, texT );

    -- disable any texgen
    const float texGenEnabled[4] = { 0.0f, 0.0f, 0.0f, 0.0f };
    renderProgManager.SetRenderParm( RENDERPARM_TEXGEN_0_ENABLED, texGenEnabled );

    renderProgManager.BindShader_Texture();
    GL_Color( 1, 1, 1, 1 );

    switch( renderSystem->GetStereo3DMode() ) {
    case STEREO3D_QUAD_BUFFER:
        glDrawBuffer( GL_BACK_RIGHT );
        GL_SelectTexture( 0 );
        stereoRenderImages[1]->Bind();
        GL_SelectTexture( 1 );
        stereoRenderImages[0]->Bind();
        RB_DrawElementsWithCounters( &backEnd.unitSquareSurface );

        glDrawBuffer( GL_BACK_LEFT );
        GL_SelectTexture( 1 );
        stereoRenderImages[1]->Bind();
        GL_SelectTexture( 0 );
        stereoRenderImages[0]->Bind();
        RB_DrawElementsWithCounters( &backEnd.unitSquareSurface );

        break;
    case STEREO3D_HDMI_720:
        -- HDMI 720P 3D
        GL_SelectTexture( 0 );
        stereoRenderImages[1]->Bind();
        GL_SelectTexture( 1 );
        stereoRenderImages[0]->Bind();
        GL_ViewportAndScissor( 0, 0, 1280, 720 );
        RB_DrawElementsWithCounters( &backEnd.unitSquareSurface );

        GL_SelectTexture( 0 );
        stereoRenderImages[0]->Bind();
        GL_SelectTexture( 1 );
        stereoRenderImages[1]->Bind();
        GL_ViewportAndScissor( 0, 750, 1280, 720 );
        RB_DrawElementsWithCounters( &backEnd.unitSquareSurface );

        -- force the HDMI 720P 3D guard band to a constant color
        glScissor( 0, 720, 1280, 30 );
        glClear( GL_COLOR_BUFFER_BIT );
        break;
    default:
    case STEREO3D_SIDE_BY_SIDE:
        if ( stereoRender_warp.GetBool() ) {
            -- this is the Rift warp
            -- renderSystem->GetWidth() / GetHeight() have returned equal values (640 for initial Rift)
            -- and we are going to warp them onto a symetric square region of each half of the screen

            renderProgManager.BindShader_StereoWarp();

            -- clear the entire screen to black
            -- we could be smart and only clear the areas we aren't going to draw on, but
            -- clears are fast...
            glScissor ( 0, 0, glConfig.nativeScreenWidth, glConfig.nativeScreenHeight );
            glClearColor( 0, 0, 0, 0 );
            glClear( GL_COLOR_BUFFER_BIT );

            -- the size of the box that will get the warped pixels
            -- With the 7" displays, this will be less than half the screen width
            const int pixelDimensions = ( glConfig.nativeScreenWidth >> 1 ) * stereoRender_warpTargetFraction.GetFloat();

            -- Always scissor to the half-screen boundary, but the viewports
            -- might cross that boundary if the lenses can be adjusted closer
            -- together.
            glViewport( ( glConfig.nativeScreenWidth >> 1 ) - pixelDimensions,
                ( glConfig.nativeScreenHeight >> 1 ) - ( pixelDimensions >> 1 ),
                pixelDimensions, pixelDimensions );
            glScissor ( 0, 0, glConfig.nativeScreenWidth >> 1, glConfig.nativeScreenHeight );

            idVec4  color( stereoRender_warpCenterX.GetFloat(), stereoRender_warpCenterY.GetFloat(), stereoRender_warpParmZ.GetFloat(), stereoRender_warpParmW.GetFloat() );
            -- don't use GL_Color(), because we don't want to clamp
            renderProgManager.SetRenderParm( RENDERPARM_COLOR, color.ToFloatPtr() );

            GL_SelectTexture( 0 );
            stereoRenderImages[0]->Bind();
            qglTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_BORDER );
            qglTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_BORDER );
            RB_DrawElementsWithCounters( &backEnd.unitSquareSurface );

            idVec4  color2( stereoRender_warpCenterX.GetFloat(), stereoRender_warpCenterY.GetFloat(), stereoRender_warpParmZ.GetFloat(), stereoRender_warpParmW.GetFloat() );
            -- don't use GL_Color(), because we don't want to clamp
            renderProgManager.SetRenderParm( RENDERPARM_COLOR, color2.ToFloatPtr() );

            glViewport( ( glConfig.nativeScreenWidth >> 1 ),
                ( glConfig.nativeScreenHeight >> 1 ) - ( pixelDimensions >> 1 ),
                pixelDimensions, pixelDimensions );
            glScissor ( glConfig.nativeScreenWidth >> 1, 0, glConfig.nativeScreenWidth >> 1, glConfig.nativeScreenHeight );

            GL_SelectTexture( 0 );
            stereoRenderImages[1]->Bind();
            qglTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_BORDER );
            qglTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_BORDER );
            RB_DrawElementsWithCounters( &backEnd.unitSquareSurface );
            break;
        }
        -- a non-warped side-by-side-uncompressed (dual input cable) is rendered
        -- just like STEREO3D_SIDE_BY_SIDE_COMPRESSED, so fall through.
    case STEREO3D_SIDE_BY_SIDE_COMPRESSED:
        GL_SelectTexture( 0 );
        stereoRenderImages[0]->Bind();
        GL_SelectTexture( 1 );
        stereoRenderImages[1]->Bind();
        GL_ViewportAndScissor( 0, 0, renderSystem->GetWidth(), renderSystem->GetHeight() );
        RB_DrawElementsWithCounters( &backEnd.unitSquareSurface );

        GL_SelectTexture( 0 );
        stereoRenderImages[1]->Bind();
        GL_SelectTexture( 1 );
        stereoRenderImages[0]->Bind();
        GL_ViewportAndScissor( renderSystem->GetWidth(), 0, renderSystem->GetWidth(), renderSystem->GetHeight() );
        RB_DrawElementsWithCounters( &backEnd.unitSquareSurface );
        break;

    case STEREO3D_TOP_AND_BOTTOM_COMPRESSED:
        GL_SelectTexture( 1 );
        stereoRenderImages[0]->Bind();
        GL_SelectTexture( 0 );
        stereoRenderImages[1]->Bind();
        GL_ViewportAndScissor( 0, 0, renderSystem->GetWidth(), renderSystem->GetHeight() );
        RB_DrawElementsWithCounters( &backEnd.unitSquareSurface );

        GL_SelectTexture( 1 );
        stereoRenderImages[1]->Bind();
        GL_SelectTexture( 0 );
        stereoRenderImages[0]->Bind();
        GL_ViewportAndScissor( 0, renderSystem->GetHeight(), renderSystem->GetWidth(), renderSystem->GetHeight() );
        RB_DrawElementsWithCounters( &backEnd.unitSquareSurface );
        break;

    case STEREO3D_INTERLACED:
        -- every other scanline
        GL_SelectTexture( 0 );
        stereoRenderImages[0]->Bind();
        qglTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST );
        qglTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST );

        GL_SelectTexture( 1 );
        stereoRenderImages[1]->Bind();
        qglTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST );
        qglTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST );

        GL_ViewportAndScissor( 0, 0, renderSystem->GetWidth(), renderSystem->GetHeight()*2 );
        renderProgManager.BindShader_StereoInterlace();
        RB_DrawElementsWithCounters( &backEnd.unitSquareSurface );

        GL_SelectTexture( 0 );
        qglTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
        qglTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );

        GL_SelectTexture( 1 );
        qglTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
        qglTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );

        break;
    }

    -- debug tool
    RB_DrawFlickerBox();

    -- make sure the drawing is actually started
    qglFlush();

    -- we may choose to sync to the swapbuffers before the next frame

    -- stop rendering on this thread
    uint64 backEndFinishTime = Sys_Microseconds();
    backEnd.pc.totalMicroSec = backEndFinishTime - backEndStartTime;
}

/*
====================
RB_ExecuteBackEndCommands

This function will be called syncronously if running without
smp extensions, or asyncronously by another thread.
====================
*/
void RB_ExecuteBackEndCommands( const emptyCommand_t *cmds ) {
    -- r_debugRenderToTexture
    int c_draw3d = 0;
    int c_draw2d = 0;
    int c_setBuffers = 0;
    int c_copyRenders = 0;

    resolutionScale.SetCurrentGPUFrameTime( commonLocal.GetRendererGPUMicroseconds() );

    renderLog.StartFrame();

    if ( cmds->commandId == RC_NOP && !cmds->next ) {
        return;
    }

    if ( renderSystem->GetStereo3DMode() != STEREO3D_OFF ) {
        RB_StereoRenderExecuteBackEndCommands( cmds );
        renderLog.EndFrame();
        return;
    }

    uint64 backEndStartTime = Sys_Microseconds();

    -- needed for editor rendering
    GL_SetDefaultState();

    -- If we have a stereo pixel format, this will draw to both
    -- the back left and back right buffers, which will have a
    -- performance penalty.
    qglDrawBuffer( GL_BACK );

    for ( ; cmds != NULL; cmds = (const emptyCommand_t *)cmds->next ) {
        switch ( cmds->commandId ) {
        case RC_NOP:
            break;
        case RC_DRAW_VIEW_3D:
        case RC_DRAW_VIEW_GUI:
            RB_DrawView( cmds, 0 );
            if ( ((const drawSurfsCommand_t *)cmds)->viewDef->viewEntitys ) {
                c_draw3d++;
            } else {
                c_draw2d++;
            }
            break;
        case RC_SET_BUFFER:
            c_setBuffers++;
            break;
        case RC_COPY_RENDER:
            RB_CopyRender( cmds );
            c_copyRenders++;
            break;
        case RC_POST_PROCESS:
            RB_PostProcess( cmds );
            break;
        default:
            common->Error( "RB_ExecuteBackEndCommands: bad commandId" );
            break;
        }
    }

    RB_DrawFlickerBox();

    -- Fix for the steam overlay not showing up while in game without Shell/Debug/Console/Menu also rendering
    qglColorMask( 1, 1, 1, 1 );

    qglFlush();

    -- stop rendering on this thread
    uint64 backEndFinishTime = Sys_Microseconds();
    backEnd.pc.totalMicroSec = backEndFinishTime - backEndStartTime;

    if ( r_debugRenderToTexture.GetInteger() == 1 ) {
        common->Printf( "3d: %i, 2d: %i, SetBuf: %i, CpyRenders: %i, CpyFrameBuf: %i\n", c_draw3d, c_draw2d, c_setBuffers, c_copyRenders, backEnd.pc.c_copyFrameBuffer );
        backEnd.pc.c_copyFrameBuffer = 0;
    }
    renderLog.EndFrame();
}
