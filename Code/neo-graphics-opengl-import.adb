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
package body Neo.Command.System.Processor.Geometry.Graphics.OpenGL.Import
  is pragma Source_File_Name("neo-graphics-opengl-import.adb");



  ---------------
  -- Constants --
  ---------------
    GL_TRUE                            : constant Integer_4_Signed   := Integer_4_Signed(C_TRUE);
    GL_FALSE                           : constant Integer_4_Signed   := Integer_4_Signed(C_FALSE);
    GL_VERSION_1_1                     : constant Integer_4_Unsigned := 16#0000_0001#;
    GL_ACCUM                           : constant Integer_4_Unsigned := 16#0000_0100#;
    GL_LOAD                            : constant Integer_4_Unsigned := 16#0000_0101#;
    GL_RETURN                          : constant Integer_4_Unsigned := 16#0000_0102#;
    GL_MULT                            : constant Integer_4_Unsigned := 16#0000_0103#;
    GL_ADD                             : constant Integer_4_Unsigned := 16#0000_0104#;
    GL_NEVER                           : constant Integer_4_Unsigned := 16#0000_0200#;
    GL_LESS                            : constant Integer_4_Unsigned := 16#0000_0201#;
    GL_EQUAL                           : constant Integer_4_Unsigned := 16#0000_0202#;
    GL_LEQUAL                          : constant Integer_4_Unsigned := 16#0000_0203#;
    GL_GREATER                         : constant Integer_4_Unsigned := 16#0000_0204#;
    GL_NOTEQUAL                        : constant Integer_4_Unsigned := 16#0000_0205#;
    GL_GEQUAL                          : constant Integer_4_Unsigned := 16#0000_0206#;
    GL_ALWAYS                          : constant Integer_4_Unsigned := 16#0000_0207#;
    GL_CURRENT_BIT                     : constant Integer_4_Unsigned := 16#0000_0001#;
    GL_POINT_BIT                       : constant Integer_4_Unsigned := 16#0000_0002#;
    GL_LINE_BIT                        : constant Integer_4_Unsigned := 16#0000_0004#;
    GL_POLYGON_BIT                     : constant Integer_4_Unsigned := 16#0000_0008#;
    GL_POLYGON_STIPPLE_BIT             : constant Integer_4_Unsigned := 16#0000_0010#;
    GL_PIXEL_MODE_BIT                  : constant Integer_4_Unsigned := 16#0000_0020#;
    GL_LIGHTING_BIT                    : constant Integer_4_Unsigned := 16#0000_0040#;
    GL_FOG_BIT                         : constant Integer_4_Unsigned := 16#0000_0080#;
    GL_DEPTH_BUFFER_BIT                : constant Integer_4_Unsigned := 16#0000_0100#;
    GL_ACCUM_BUFFER_BIT                : constant Integer_4_Unsigned := 16#0000_0200#;
    GL_STENCIL_BUFFER_BIT              : constant Integer_4_Unsigned := 16#0000_0400#;
    GL_VIEWPORT_BIT                    : constant Integer_4_Unsigned := 16#0000_0800#;
    GL_TRANSFORM_BIT                   : constant Integer_4_Unsigned := 16#0000_1000#;
    GL_ENABLE_BIT                      : constant Integer_4_Unsigned := 16#0000_2000#;
    GL_COLOR_BUFFER_BIT                : constant Integer_4_Unsigned := 16#0000_4000#;
    GL_HINT_BIT                        : constant Integer_4_Unsigned := 16#0000_8000#;
    GL_EVAL_BIT                        : constant Integer_4_Unsigned := 16#0001_0000#;
    GL_LIST_BIT                        : constant Integer_4_Unsigned := 16#0002_0000#;
    GL_TEXTURE_BIT                     : constant Integer_4_Unsigned := 16#0004_0000#;
    GL_SCISSOR_BIT                     : constant Integer_4_Unsigned := 16#0008_0000#;
    GL_ALL_ATTRIB_BITS                 : constant Integer_4_Unsigned := 16#000F_FFFF#;
    GL_POINTS                          : constant Integer_4_Unsigned := 16#0000_0000#;
    GL_LINES                           : constant Integer_4_Unsigned := 16#0000_0001#;
    GL_LINE_LOOP                       : constant Integer_4_Unsigned := 16#0000_0002#;
    GL_LINE_STRIP                      : constant Integer_4_Unsigned := 16#0000_0003#;
    GL_TRIANGLES                       : constant Integer_4_Unsigned := 16#0000_0004#;
    GL_TRIANGLE_STRIP                  : constant Integer_4_Unsigned := 16#0000_0005#;
    GL_TRIANGLE_FAN                    : constant Integer_4_Unsigned := 16#0000_0006#;
    GL_QUADS                           : constant Integer_4_Unsigned := 16#0000_0007#;
    GL_QUAD_STRIP                      : constant Integer_4_Unsigned := 16#0000_0008#;
    GL_POLYGON                         : constant Integer_4_Unsigned := 16#0000_0009#;
    GL_ZERO                            : constant Integer_4_Unsigned := 16#0000_0000#;
    GL_ONE                             : constant Integer_4_Unsigned := 16#0000_0001#;
    GL_SRC_COLOR                       : constant Integer_4_Unsigned := 16#0000_0300#;
    GL_ONE_MINUS_SRC_COLOR             : constant Integer_4_Unsigned := 16#0000_0301#;
    GL_SRC_ALPHA                       : constant Integer_4_Unsigned := 16#0000_0302#;
    GL_ONE_MINUS_SRC_ALPHA             : constant Integer_4_Unsigned := 16#0000_0303#;
    GL_DST_ALPHA                       : constant Integer_4_Unsigned := 16#0000_0304#;
    GL_ONE_MINUS_DST_ALPHA             : constant Integer_4_Unsigned := 16#0000_0305#;
    GL_DST_COLOR                       : constant Integer_4_Unsigned := 16#0000_0306#;
    GL_ONE_MINUS_DST_COLOR             : constant Integer_4_Unsigned := 16#0000_0307#;
    GL_SRC_ALPHA_SATURATE              : constant Integer_4_Unsigned := 16#0000_0308#;
    GL_CLIP_PLANE0                     : constant Integer_4_Unsigned := 16#0000_3000#;
    GL_CLIP_PLANE1                     : constant Integer_4_Unsigned := 16#0000_3001#;
    GL_CLIP_PLANE2                     : constant Integer_4_Unsigned := 16#0000_3002#;
    GL_CLIP_PLANE3                     : constant Integer_4_Unsigned := 16#0000_3003#;
    GL_CLIP_PLANE4                     : constant Integer_4_Unsigned := 16#0000_3004#;
    GL_CLIP_PLANE5                     : constant Integer_4_Unsigned := 16#0000_3005#;
    GL_BYTE                            : constant Integer_4_Unsigned := 16#0000_1400#;
    GL_UNSIGNED_BYTE                   : constant Integer_4_Unsigned := 16#0000_1401#;
    GL_SHORT                           : constant Integer_4_Unsigned := 16#0000_1402#;
    GL_UNSIGNED_SHORT                  : constant Integer_4_Unsigned := 16#0000_1403#;
    GL_INT                             : constant Integer_4_Unsigned := 16#0000_1404#;
    GL_UNSIGNED_INT                    : constant Integer_4_Unsigned := 16#0000_1405#;
    GL_FLOAT                           : constant Integer_4_Unsigned := 16#0000_1406#;
    GL_2_BYTES                         : constant Integer_4_Unsigned := 16#0000_1407#;
    GL_3_BYTES                         : constant Integer_4_Unsigned := 16#0000_1408#;
    GL_4_BYTES                         : constant Integer_4_Unsigned := 16#0000_1409#;
    GL_DOUBLE                          : constant Integer_4_Unsigned := 16#0000_140A#;
    GL_NONE                            : constant Integer_4_Unsigned := 16#0000_0000#;
    GL_FRONT_LEFT                      : constant Integer_4_Unsigned := 16#0000_0400#;
    GL_FRONT_RIGHT                     : constant Integer_4_Unsigned := 16#0000_0401#;
    GL_BACK_LEFT                       : constant Integer_4_Unsigned := 16#0000_0402#;
    GL_BACK_RIGHT                      : constant Integer_4_Unsigned := 16#0000_0403#;
    GL_FRONT                           : constant Integer_4_Unsigned := 16#0000_0404#;
    GL_BACK                            : constant Integer_4_Unsigned := 16#0000_0405#;
    GL_LEFT                            : constant Integer_4_Unsigned := 16#0000_0406#;
    GL_RIGHT                           : constant Integer_4_Unsigned := 16#0000_0407#;
    GL_FRONT_AND_BACK                  : constant Integer_4_Unsigned := 16#0000_0408#;
    GL_AUX0                            : constant Integer_4_Unsigned := 16#0000_0409#;
    GL_AUX1                            : constant Integer_4_Unsigned := 16#0000_040A#;
    GL_AUX2                            : constant Integer_4_Unsigned := 16#0000_040B#;
    GL_AUX3                            : constant Integer_4_Unsigned := 16#0000_040C#;
    GL_NO_ERROR                        : constant Integer_4_Unsigned := 16#0000_0000#;
    GL_INVALID_ENUM                    : constant Integer_4_Unsigned := 16#0000_0500#;
    GL_INVALID_VALUE                   : constant Integer_4_Unsigned := 16#0000_0501#;
    GL_INVALID_OPERATION               : constant Integer_4_Unsigned := 16#0000_0502#;
    GL_STACK_OVERFLOW                  : constant Integer_4_Unsigned := 16#0000_0503#;
    GL_STACK_UNDERFLOW                 : constant Integer_4_Unsigned := 16#0000_0504#;
    GL_OUT_OF_MEMORY                   : constant Integer_4_Unsigned := 16#0000_0505#;
    GL_2D                              : constant Integer_4_Unsigned := 16#0000_0600#;
    GL_3D                              : constant Integer_4_Unsigned := 16#0000_0601#;
    GL_3D_COLOR                        : constant Integer_4_Unsigned := 16#0000_0602#;
    GL_3D_COLOR_TEXTURE                : constant Integer_4_Unsigned := 16#0000_0603#;
    GL_4D_COLOR_TEXTURE                : constant Integer_4_Unsigned := 16#0000_0604#;
    GL_PASS_THROUGH_TOKEN              : constant Integer_4_Unsigned := 16#0000_0700#;
    GL_POINT_TOKEN                     : constant Integer_4_Unsigned := 16#0000_0701#;
    GL_LINE_TOKEN                      : constant Integer_4_Unsigned := 16#0000_0702#;
    GL_POLYGON_TOKEN                   : constant Integer_4_Unsigned := 16#0000_0703#;
    GL_BITMAP_TOKEN                    : constant Integer_4_Unsigned := 16#0000_0704#;
    GL_DRAW_PIXEL_TOKEN                : constant Integer_4_Unsigned := 16#0000_0705#;
    GL_COPY_PIXEL_TOKEN                : constant Integer_4_Unsigned := 16#0000_0706#;
    GL_LINE_RESET_TOKEN                : constant Integer_4_Unsigned := 16#0000_0707#;
    GL_EXP                             : constant Integer_4_Unsigned := 16#0000_0800#;
    GL_EXP2                            : constant Integer_4_Unsigned := 16#0000_0801#;
    GL_CW                              : constant Integer_4_Unsigned := 16#0000_0900#;
    GL_CCW                             : constant Integer_4_Unsigned := 16#0000_0901#;
    GL_COEFF                           : constant Integer_4_Unsigned := 16#0000_0A00#;
    GL_ORDER                           : constant Integer_4_Unsigned := 16#0000_0A01#;
    GL_DOMAIN                          : constant Integer_4_Unsigned := 16#0000_0A02#;
    GL_CURRENT_COLOR                   : constant Integer_4_Unsigned := 16#0000_0B00#;
    GL_CURRENT_INDEX                   : constant Integer_4_Unsigned := 16#0000_0B01#;
    GL_CURRENT_NORMAL                  : constant Integer_4_Unsigned := 16#0000_0B02#;
    GL_CURRENT_TEXTURE_COORDS          : constant Integer_4_Unsigned := 16#0000_0B03#;
    GL_CURRENT_RASTER_COLOR            : constant Integer_4_Unsigned := 16#0000_0B04#;
    GL_CURRENT_RASTER_INDEX            : constant Integer_4_Unsigned := 16#0000_0B05#;
    GL_CURRENT_RASTER_TEXTURE_COORDS   : constant Integer_4_Unsigned := 16#0000_0B06#;
    GL_CURRENT_RASTER_POSITION         : constant Integer_4_Unsigned := 16#0000_0B07#;
    GL_CURRENT_RASTER_POSITION_VALID   : constant Integer_4_Unsigned := 16#0000_0B08#;
    GL_CURRENT_RASTER_DISTANCE         : constant Integer_4_Unsigned := 16#0000_0B09#;
    GL_POINT_SMOOTH                    : constant Integer_4_Unsigned := 16#0000_0B10#;
    GL_POINT_SIZE                      : constant Integer_4_Unsigned := 16#0000_0B11#;
    GL_POINT_SIZE_RANGE                : constant Integer_4_Unsigned := 16#0000_0B12#;
    GL_POINT_SIZE_GRANULARITY          : constant Integer_4_Unsigned := 16#0000_0B13#;
    GL_LINE_SMOOTH                     : constant Integer_4_Unsigned := 16#0000_0B20#;
    GL_LINE_WIDTH                      : constant Integer_4_Unsigned := 16#0000_0B21#;
    GL_LINE_WIDTH_RANGE                : constant Integer_4_Unsigned := 16#0000_0B22#;
    GL_LINE_WIDTH_GRANULARITY          : constant Integer_4_Unsigned := 16#0000_0B23#;
    GL_LINE_STIPPLE                    : constant Integer_4_Unsigned := 16#0000_0B24#;
    GL_LINE_STIPPLE_PATTERN            : constant Integer_4_Unsigned := 16#0000_0B25#;
    GL_LINE_STIPPLE_REPEAT             : constant Integer_4_Unsigned := 16#0000_0B26#;
    GL_LIST_MODE                       : constant Integer_4_Unsigned := 16#0000_0B30#;
    GL_MAX_LIST_NESTING                : constant Integer_4_Unsigned := 16#0000_0B31#;
    GL_LIST_BASE                       : constant Integer_4_Unsigned := 16#0000_0B32#;
    GL_LIST_INDEX                      : constant Integer_4_Unsigned := 16#0000_0B33#;
    GL_POLYGON_MODE                    : constant Integer_4_Unsigned := 16#0000_0B40#;
    GL_POLYGON_SMOOTH                  : constant Integer_4_Unsigned := 16#0000_0B41#;
    GL_POLYGON_STIPPLE                 : constant Integer_4_Unsigned := 16#0000_0B42#;
    GL_EDGE_FLAG                       : constant Integer_4_Unsigned := 16#0000_0B43#;
    GL_CULL_FACE                       : constant Integer_4_Unsigned := 16#0000_0B44#;
    GL_CULL_FACE_MODE                  : constant Integer_4_Unsigned := 16#0000_0B45#;
    GL_FRONT_FACE                      : constant Integer_4_Unsigned := 16#0000_0B46#;
    GL_LIGHTING                        : constant Integer_4_Unsigned := 16#0000_0B50#;
    GL_LIGHT_MODEL_LOCAL_VIEWER        : constant Integer_4_Unsigned := 16#0000_0B51#;
    GL_LIGHT_MODEL_TWO_SIDE            : constant Integer_4_Unsigned := 16#0000_0B52#;
    GL_LIGHT_MODEL_AMBIENT             : constant Integer_4_Unsigned := 16#0000_0B53#;
    GL_SHADE_MODEL                     : constant Integer_4_Unsigned := 16#0000_0B54#;
    GL_COLOR_MATERIAL_FACE             : constant Integer_4_Unsigned := 16#0000_0B55#;
    GL_COLOR_MATERIAL_PARAMETER        : constant Integer_4_Unsigned := 16#0000_0B56#;
    GL_COLOR_MATERIAL                  : constant Integer_4_Unsigned := 16#0000_0B57#;
    GL_FOG                             : constant Integer_4_Unsigned := 16#0000_0B60#;
    GL_FOG_INDEX                       : constant Integer_4_Unsigned := 16#0000_0B61#;
    GL_FOG_DENSITY                     : constant Integer_4_Unsigned := 16#0000_0B62#;
    GL_FOG_START                       : constant Integer_4_Unsigned := 16#0000_0B63#;
    GL_FOG_END                         : constant Integer_4_Unsigned := 16#0000_0B64#;
    GL_FOG_MODE                        : constant Integer_4_Unsigned := 16#0000_0B65#;
    GL_FOG_COLOR                       : constant Integer_4_Unsigned := 16#0000_0B66#;
    GL_DEPTH_RANGE                     : constant Integer_4_Unsigned := 16#0000_0B70#;
    GL_DEPTH_TEST                      : constant Integer_4_Unsigned := 16#0000_0B71#;
    GL_DEPTH_WRITEMASK                 : constant Integer_4_Unsigned := 16#0000_0B72#;
    GL_DEPTH_CLEAR_VALUE               : constant Integer_4_Unsigned := 16#0000_0B73#;
    GL_DEPTH_FUNC                      : constant Integer_4_Unsigned := 16#0000_0B74#;
    GL_ACCUM_CLEAR_VALUE               : constant Integer_4_Unsigned := 16#0000_0B80#;
    GL_STENCIL_TEST                    : constant Integer_4_Unsigned := 16#0000_0B90#;
    GL_STENCIL_CLEAR_VALUE             : constant Integer_4_Unsigned := 16#0000_0B91#;
    GL_STENCIL_FUNC                    : constant Integer_4_Unsigned := 16#0000_0B92#;
    GL_STENCIL_VALUE_MASK              : constant Integer_4_Unsigned := 16#0000_0B93#;
    GL_STENCIL_FAIL                    : constant Integer_4_Unsigned := 16#0000_0B94#;
    GL_STENCIL_PASS_DEPTH_FAIL         : constant Integer_4_Unsigned := 16#0000_0B95#;
    GL_STENCIL_PASS_DEPTH_PASS         : constant Integer_4_Unsigned := 16#0000_0B96#;
    GL_STENCIL_REF                     : constant Integer_4_Unsigned := 16#0000_0B97#;
    GL_STENCIL_WRITEMASK               : constant Integer_4_Unsigned := 16#0000_0B98#;
    GL_MATRIX_MODE                     : constant Integer_4_Unsigned := 16#0000_0BA0#;
    GL_NORMALIZE                       : constant Integer_4_Unsigned := 16#0000_0BA1#;
    GL_VIEWPORT                        : constant Integer_4_Unsigned := 16#0000_0BA2#;
    GL_MODELVIEW_STACK_DEPTH           : constant Integer_4_Unsigned := 16#0000_0BA3#;
    GL_PROJECTION_STACK_DEPTH          : constant Integer_4_Unsigned := 16#0000_0BA4#;
    GL_TEXTURE_STACK_DEPTH             : constant Integer_4_Unsigned := 16#0000_0BA5#;
    GL_MODELVIEW_MATRIX                : constant Integer_4_Unsigned := 16#0000_0BA6#;
    GL_PROJECTION_MATRIX               : constant Integer_4_Unsigned := 16#0000_0BA7#;
    GL_TEXTURE_MATRIX                  : constant Integer_4_Unsigned := 16#0000_0BA8#;
    GL_ATTRIB_STACK_DEPTH              : constant Integer_4_Unsigned := 16#0000_0BB0#;
    GL_CLIENT_ATTRIB_STACK_DEPTH       : constant Integer_4_Unsigned := 16#0000_0BB1#;
    GL_ALPHA_TEST                      : constant Integer_4_Unsigned := 16#0000_0BC0#;
    GL_ALPHA_TEST_FUNC                 : constant Integer_4_Unsigned := 16#0000_0BC1#;
    GL_ALPHA_TEST_REF                  : constant Integer_4_Unsigned := 16#0000_0BC2#;
    GL_DITHER                          : constant Integer_4_Unsigned := 16#0000_0BD0#;
    GL_BLEND_DST                       : constant Integer_4_Unsigned := 16#0000_0BE0#;
    GL_BLEND_SRC                       : constant Integer_4_Unsigned := 16#0000_0BE1#;
    GL_BLEND                           : constant Integer_4_Unsigned := 16#0000_0BE2#;
    GL_LOGIC_OP_MODE                   : constant Integer_4_Unsigned := 16#0000_0BF0#;
    GL_INDEX_LOGIC_OP                  : constant Integer_4_Unsigned := 16#0000_0BF1#;
    GL_COLOR_LOGIC_OP                  : constant Integer_4_Unsigned := 16#0000_0BF2#;
    GL_AUX_BUFFERS                     : constant Integer_4_Unsigned := 16#0000_0C00#;
    GL_DRAW_BUFFER                     : constant Integer_4_Unsigned := 16#0000_0C01#;
    GL_READ_BUFFER                     : constant Integer_4_Unsigned := 16#0000_0C02#;
    GL_SCISSOR_BOX                     : constant Integer_4_Unsigned := 16#0000_0C10#;
    GL_SCISSOR_TEST                    : constant Integer_4_Unsigned := 16#0000_0C11#;
    GL_INDEX_CLEAR_VALUE               : constant Integer_4_Unsigned := 16#0000_0C20#;
    GL_INDEX_WRITEMASK                 : constant Integer_4_Unsigned := 16#0000_0C21#;
    GL_COLOR_CLEAR_VALUE               : constant Integer_4_Unsigned := 16#0000_0C22#;
    GL_COLOR_WRITEMASK                 : constant Integer_4_Unsigned := 16#0000_0C23#;
    GL_INDEX_MODE                      : constant Integer_4_Unsigned := 16#0000_0C30#;
    GL_RGBA_MODE                       : constant Integer_4_Unsigned := 16#0000_0C31#;
    GL_DOUBLEBUFFER                    : constant Integer_4_Unsigned := 16#0000_0C32#;
    GL_STEREO                          : constant Integer_4_Unsigned := 16#0000_0C33#;
    GL_RENDER_MODE                     : constant Integer_4_Unsigned := 16#0000_0C40#;
    GL_PERSPECTIVE_CORRECTION_HINT     : constant Integer_4_Unsigned := 16#0000_0C50#;
    GL_POINT_SMOOTH_HINT               : constant Integer_4_Unsigned := 16#0000_0C51#;
    GL_LINE_SMOOTH_HINT                : constant Integer_4_Unsigned := 16#0000_0C52#;
    GL_POLYGON_SMOOTH_HINT             : constant Integer_4_Unsigned := 16#0000_0C53#;
    GL_FOG_HINT                        : constant Integer_4_Unsigned := 16#0000_0C54#;
    GL_TEXTURE_GEN_S                   : constant Integer_4_Unsigned := 16#0000_0C60#;
    GL_TEXTURE_GEN_T                   : constant Integer_4_Unsigned := 16#0000_0C61#;
    GL_TEXTURE_GEN_R                   : constant Integer_4_Unsigned := 16#0C62#;
    GL_TEXTURE_GEN_Q                   : constant Integer_4_Unsigned := 16#0C63#;
    GL_PIXEL_MAP_I_TO_I                : constant Integer_4_Unsigned := 16#0C70#;
    GL_PIXEL_MAP_S_TO_S                : constant Integer_4_Unsigned := 16#0C71#;
    GL_PIXEL_MAP_I_TO_R                : constant Integer_4_Unsigned := 16#0C72#;
    GL_PIXEL_MAP_I_TO_G                : constant Integer_4_Unsigned := 16#0C73#;
    GL_PIXEL_MAP_I_TO_B                : constant Integer_4_Unsigned := 16#0C74#;
    GL_PIXEL_MAP_I_TO_A                : constant Integer_4_Unsigned := 16#0C75#;
    GL_PIXEL_MAP_R_TO_R                : constant Integer_4_Unsigned := 16#0C76#;
    GL_PIXEL_MAP_G_TO_G                : constant Integer_4_Unsigned := 16#0C77#;
    GL_PIXEL_MAP_B_TO_B                : constant Integer_4_Unsigned := 16#0C78#;
    GL_PIXEL_MAP_A_TO_A                : constant Integer_4_Unsigned := 16#0C79#;
    GL_PIXEL_MAP_I_TO_I_SIZE           : constant Integer_4_Unsigned := 16#0CB0#;
    GL_PIXEL_MAP_S_TO_S_SIZE           : constant Integer_4_Unsigned := 16#0CB1#;
    GL_PIXEL_MAP_I_TO_R_SIZE           : constant Integer_4_Unsigned := 16#0CB2#;
    GL_PIXEL_MAP_I_TO_G_SIZE           : constant Integer_4_Unsigned := 16#0CB3#;
    GL_PIXEL_MAP_I_TO_B_SIZE           : constant Integer_4_Unsigned := 16#0CB4#;
    GL_PIXEL_MAP_I_TO_A_SIZE           : constant Integer_4_Unsigned := 16#0CB5#;
    GL_PIXEL_MAP_R_TO_R_SIZE           : constant Integer_4_Unsigned := 16#0CB6#;
    GL_PIXEL_MAP_G_TO_G_SIZE           : constant Integer_4_Unsigned := 16#0CB7#;
    GL_PIXEL_MAP_B_TO_B_SIZE           : constant Integer_4_Unsigned := 16#0CB8#;
    GL_PIXEL_MAP_A_TO_A_SIZE           : constant Integer_4_Unsigned := 16#0CB9#;
    GL_UNPACK_SWAP_BYTES               : constant Integer_4_Unsigned := 16#0CF0#;
    GL_UNPACK_LSB_FIRST                : constant Integer_4_Unsigned := 16#0CF1#;
    GL_UNPACK_ROW_LENGTH               : constant Integer_4_Unsigned := 16#0CF2#;
    GL_UNPACK_SKIP_ROWS                : constant Integer_4_Unsigned := 16#0CF3#;
    GL_UNPACK_SKIP_PIXELS              : constant Integer_4_Unsigned := 16#0CF4#;
    GL_UNPACK_ALIGNMENT                : constant Integer_4_Unsigned := 16#0CF5#;
    GL_PACK_SWAP_BYTES                 : constant Integer_4_Unsigned := 16#0D00#;
    GL_PACK_LSB_FIRST                  : constant Integer_4_Unsigned := 16#0D01#;
    GL_PACK_ROW_LENGTH                 : constant Integer_4_Unsigned := 16#0D02#;
    GL_PACK_SKIP_ROWS                  : constant Integer_4_Unsigned := 16#0D03#;
    GL_PACK_SKIP_PIXELS                : constant Integer_4_Unsigned := 16#0D04#;
    GL_PACK_ALIGNMENT                  : constant Integer_4_Unsigned := 16#0D05#;
    GL_MAP_COLOR                       : constant Integer_4_Unsigned := 16#0D10#;
    GL_MAP_STENCIL                     : constant Integer_4_Unsigned := 16#0D11#;
    GL_INDEX_SHIFT                     : constant Integer_4_Unsigned := 16#0D12#;
    GL_INDEX_OFFSET                    : constant Integer_4_Unsigned := 16#0D13#;
    GL_RED_SCALE                       : constant Integer_4_Unsigned := 16#0D14#;
    GL_RED_BIAS                        : constant Integer_4_Unsigned := 16#0D15#;
    GL_ZOOM_X                          : constant Integer_4_Unsigned := 16#0D16#;
    GL_ZOOM_Y                          : constant Integer_4_Unsigned := 16#0D17#;
    GL_GREEN_SCALE                     : constant Integer_4_Unsigned := 16#0D18#;
    GL_GREEN_BIAS                      : constant Integer_4_Unsigned := 16#0D19#;
    GL_BLUE_SCALE                      : constant Integer_4_Unsigned := 16#0D1A#;
    GL_BLUE_BIAS                       : constant Integer_4_Unsigned := 16#0D1B#;
    GL_ALPHA_SCALE                     : constant Integer_4_Unsigned := 16#0D1C#;
    GL_ALPHA_BIAS                      : constant Integer_4_Unsigned := 16#0D1D#;
    GL_DEPTH_SCALE                     : constant Integer_4_Unsigned := 16#0D1E#;
    GL_DEPTH_BIAS                      : constant Integer_4_Unsigned := 16#0D1F#;
    GL_MAX_EVAL_ORDER                  : constant Integer_4_Unsigned := 16#0D30#;
    GL_MAX_LIGHTS                      : constant Integer_4_Unsigned := 16#0D31#;
    GL_MAX_CLIP_PLANES                 : constant Integer_4_Unsigned := 16#0D32#;
    GL_MAX_TEXTURE_SIZE                : constant Integer_4_Unsigned := 16#0D33#;
    GL_MAX_PIXEL_MAP_TABLE             : constant Integer_4_Unsigned := 16#0D34#;
    GL_MAX_ATTRIB_STACK_DEPTH          : constant Integer_4_Unsigned := 16#0D35#;
    GL_MAX_MODELVIEW_STACK_DEPTH       : constant Integer_4_Unsigned := 16#0D36#;
    GL_MAX_NAME_STACK_DEPTH            : constant Integer_4_Unsigned := 16#0D37#;
    GL_MAX_PROJECTION_STACK_DEPTH      : constant Integer_4_Unsigned := 16#0D38#;
    GL_MAX_TEXTURE_STACK_DEPTH         : constant Integer_4_Unsigned := 16#0D39#;
    GL_MAX_VIEWPORT_DIMS               : constant Integer_4_Unsigned := 16#0D3A#;
    GL_MAX_CLIENT_ATTRIB_STACK_DEPTH   : constant Integer_4_Unsigned := 16#0D3B#;
    GL_SUBPIXEL_BITS                   : constant Integer_4_Unsigned := 16#0D50#;
    GL_INDEX_BITS                      : constant Integer_4_Unsigned := 16#0D51#;
    GL_RED_BITS                        : constant Integer_4_Unsigned := 16#0D52#;
    GL_GREEN_BITS                      : constant Integer_4_Unsigned := 16#0D53#;
    GL_BLUE_BITS                       : constant Integer_4_Unsigned := 16#0D54#;
    GL_ALPHA_BITS                      : constant Integer_4_Unsigned := 16#0D55#;
    GL_DEPTH_BITS                      : constant Integer_4_Unsigned := 16#0D56#;
    GL_STENCIL_BITS                    : constant Integer_4_Unsigned := 16#0D57#;
    GL_ACCUM_RED_BITS                  : constant Integer_4_Unsigned := 16#0D58#;
    GL_ACCUM_GREEN_BITS                : constant Integer_4_Unsigned := 16#0D59#;
    GL_ACCUM_BLUE_BITS                 : constant Integer_4_Unsigned := 16#0D5A#;
    GL_ACCUM_ALPHA_BITS                : constant Integer_4_Unsigned := 16#0D5B#;
    GL_NAME_STACK_DEPTH                : constant Integer_4_Unsigned := 16#0D70#;
    GL_AUTO_NORMAL                     : constant Integer_4_Unsigned := 16#0D80#;
    GL_MAP1_COLOR_4                    : constant Integer_4_Unsigned := 16#0D90#;
    GL_MAP1_INDEX                      : constant Integer_4_Unsigned := 16#0D91#;
    GL_MAP1_NORMAL                     : constant Integer_4_Unsigned := 16#0D92#;
    GL_MAP1_TEXTURE_COORD_1            : constant Integer_4_Unsigned := 16#0D93#;
    GL_MAP1_TEXTURE_COORD_2            : constant Integer_4_Unsigned := 16#0D94#;
    GL_MAP1_TEXTURE_COORD_3            : constant Integer_4_Unsigned := 16#0D95#;
    GL_MAP1_TEXTURE_COORD_4            : constant Integer_4_Unsigned := 16#0D96#;
    GL_MAP1_VERTEX_3                   : constant Integer_4_Unsigned := 16#0D97#;
    GL_MAP1_VERTEX_4                   : constant Integer_4_Unsigned := 16#0D98#;
    GL_MAP2_COLOR_4                    : constant Integer_4_Unsigned := 16#0DB0#;
    GL_MAP2_INDEX                      : constant Integer_4_Unsigned := 16#0DB1#;
    GL_MAP2_NORMAL                     : constant Integer_4_Unsigned := 16#0DB2#;
    GL_MAP2_TEXTURE_COORD_1            : constant Integer_4_Unsigned := 16#0DB3#;
    GL_MAP2_TEXTURE_COORD_2            : constant Integer_4_Unsigned := 16#0DB4#;
    GL_MAP2_TEXTURE_COORD_3            : constant Integer_4_Unsigned := 16#0DB5#;
    GL_MAP2_TEXTURE_COORD_4            : constant Integer_4_Unsigned := 16#0DB6#;
    GL_MAP2_VERTEX_3                   : constant Integer_4_Unsigned := 16#0DB7#;
    GL_MAP2_VERTEX_4                   : constant Integer_4_Unsigned := 16#0DB8#;
    GL_MAP1_GRID_DOMAIN                : constant Integer_4_Unsigned := 16#0DD0#;
    GL_MAP1_GRID_SEGMENTS              : constant Integer_4_Unsigned := 16#0DD1#;
    GL_MAP2_GRID_DOMAIN                : constant Integer_4_Unsigned := 16#0DD2#;
    GL_MAP2_GRID_SEGMENTS              : constant Integer_4_Unsigned := 16#0DD3#;
    GL_TEXTURE_1D                      : constant Integer_4_Unsigned := 16#0DE0#;
    GL_TEXTURE_2D                      : constant Integer_4_Unsigned := 16#0DE1#;
    GL_FEEDBACK_BUFFER_POINTER         : constant Integer_4_Unsigned := 16#0DF0#;
    GL_FEEDBACK_BUFFER_SIZE            : constant Integer_4_Unsigned := 16#0DF1#;
    GL_FEEDBACK_BUFFER_TYPE            : constant Integer_4_Unsigned := 16#0DF2#;
    GL_SELECTION_BUFFER_POINTER        : constant Integer_4_Unsigned := 16#0DF3#;
    GL_SELECTION_BUFFER_SIZE           : constant Integer_4_Unsigned := 16#0DF4#;
    GL_TEXTURE_WIDTH                   : constant Integer_4_Unsigned := 16#1000#;
    GL_TEXTURE_HEIGHT                  : constant Integer_4_Unsigned := 16#1001#;
    GL_TEXTURE_INTERNAL_FORMAT         : constant Integer_4_Unsigned := 16#1003#;
    GL_TEXTURE_BORDER_COLOR            : constant Integer_4_Unsigned := 16#1004#;
    GL_TEXTURE_BORDER                  : constant Integer_4_Unsigned := 16#1005#;
    GL_DONT_CARE                       : constant Integer_4_Unsigned := 16#1100#;
    GL_FASTEST                         : constant Integer_4_Unsigned := 16#1101#;
    GL_NICEST                          : constant Integer_4_Unsigned := 16#1102#;
    GL_LIGHT0                          : constant Integer_4_Unsigned := 16#4000#;
    GL_LIGHT1                          : constant Integer_4_Unsigned := 16#4001#;
    GL_LIGHT2                          : constant Integer_4_Unsigned := 16#4002#;
    GL_LIGHT3                          : constant Integer_4_Unsigned := 16#4003#;
    GL_LIGHT4                          : constant Integer_4_Unsigned := 16#4004#;
    GL_LIGHT5                          : constant Integer_4_Unsigned := 16#4005#;
    GL_LIGHT6                          : constant Integer_4_Unsigned := 16#4006#;
    GL_LIGHT7                          : constant Integer_4_Unsigned := 16#4007#;
    GL_AMBIENT                         : constant Integer_4_Unsigned := 16#1200#;
    GL_DIFFUSE                         : constant Integer_4_Unsigned := 16#1201#;
    GL_SPECULAR                        : constant Integer_4_Unsigned := 16#1202#;
    GL_POSITION                        : constant Integer_4_Unsigned := 16#1203#;
    GL_SPOT_DIRECTION                  : constant Integer_4_Unsigned := 16#1204#;
    GL_SPOT_EXPONENT                   : constant Integer_4_Unsigned := 16#1205#;
    GL_SPOT_CUTOFF                     : constant Integer_4_Unsigned := 16#1206#;
    GL_CONSTANT_ATTENUATION            : constant Integer_4_Unsigned := 16#1207#;
    GL_LINEAR_ATTENUATION              : constant Integer_4_Unsigned := 16#1208#;
    GL_QUADRATIC_ATTENUATION           : constant Integer_4_Unsigned := 16#1209#;
    GL_COMPILE                         : constant Integer_4_Unsigned := 16#1300#;
    GL_COMPILE_AND_EXECUTE             : constant Integer_4_Unsigned := 16#1301#;
    GL_CLEAR                           : constant Integer_4_Unsigned := 16#1500#;
    GL_AND                             : constant Integer_4_Unsigned := 16#1501#;
    GL_AND_REVERSE                     : constant Integer_4_Unsigned := 16#1502#;
    GL_COPY                            : constant Integer_4_Unsigned := 16#1503#;
    GL_AND_INVERTED                    : constant Integer_4_Unsigned := 16#1504#;
    GL_NOOP                            : constant Integer_4_Unsigned := 16#1505#;
    GL_XOR                             : constant Integer_4_Unsigned := 16#1506#;
    GL_OR                              : constant Integer_4_Unsigned := 16#1507#;
    GL_NOR                             : constant Integer_4_Unsigned := 16#1508#;
    GL_EQUIV                           : constant Integer_4_Unsigned := 16#1509#;
    GL_INVERT                          : constant Integer_4_Unsigned := 16#150A#;
    GL_OR_REVERSE                      : constant Integer_4_Unsigned := 16#150B#;
    GL_COPY_INVERTED                   : constant Integer_4_Unsigned := 16#150C#;
    GL_OR_INVERTED                     : constant Integer_4_Unsigned := 16#150D#;
    GL_NAND                            : constant Integer_4_Unsigned := 16#150E#;
    GL_SET                             : constant Integer_4_Unsigned := 16#150F#;
    GL_EMISSION                        : constant Integer_4_Unsigned := 16#1600#;
    GL_SHININESS                       : constant Integer_4_Unsigned := 16#1601#;
    GL_AMBIENT_AND_DIFFUSE             : constant Integer_4_Unsigned := 16#1602#;
    GL_COLOR_INDEXES                   : constant Integer_4_Unsigned := 16#1603#;
    GL_MODELVIEW                       : constant Integer_4_Unsigned := 16#1700#;
    GL_PROJECTION                      : constant Integer_4_Unsigned := 16#1701#;
    GL_TEXTURE                         : constant Integer_4_Unsigned := 16#1702#;
    GL_COLOR                           : constant Integer_4_Unsigned := 16#1800#;
    GL_DEPTH                           : constant Integer_4_Unsigned := 16#1801#;
    GL_STENCIL                         : constant Integer_4_Unsigned := 16#1802#;
    GL_COLOR_INDEX                     : constant Integer_4_Unsigned := 16#1900#;
    GL_STENCIL_INDEX                   : constant Integer_4_Unsigned := 16#1901#;
    GL_DEPTH_COMPONENT                 : constant Integer_4_Unsigned := 16#1902#;
    GL_RED                             : constant Integer_4_Unsigned := 16#1903#;
    GL_GREEN                           : constant Integer_4_Unsigned := 16#1904#;
    GL_BLUE                            : constant Integer_4_Unsigned := 16#1905#;
    GL_ALPHA                           : constant Integer_4_Unsigned := 16#1906#;
    GL_RGB                             : constant Integer_4_Unsigned := 16#1907#;
    GL_RGBA                            : constant Integer_4_Unsigned := 16#1908#;
    GL_LUMINANCE                       : constant Integer_4_Unsigned := 16#1909#;
    GL_LUMINANCE_ALPHA                 : constant Integer_4_Unsigned := 16#190A#;
    GL_BITMAP                          : constant Integer_4_Unsigned := 16#1A00#;
    GL_POINT                           : constant Integer_4_Unsigned := 16#1B00#;
    GL_LINE                            : constant Integer_4_Unsigned := 16#1B01#;
    GL_FILL                            : constant Integer_4_Unsigned := 16#1B02#;
    GL_RENDER                          : constant Integer_4_Unsigned := 16#1C00#;
    GL_FEEDBACK                        : constant Integer_4_Unsigned := 16#1C01#;
    GL_SELECT                          : constant Integer_4_Unsigned := 16#1C02#;
    GL_FLAT                            : constant Integer_4_Unsigned := 16#1D00#;
    GL_SMOOTH                          : constant Integer_4_Unsigned := 16#1D01#;
    GL_KEEP                            : constant Integer_4_Unsigned := 16#1E00#;
    GL_REPLACE                         : constant Integer_4_Unsigned := 16#1E01#;
    GL_INCR                            : constant Integer_4_Unsigned := 16#1E02#;
    GL_DECR                            : constant Integer_4_Unsigned := 16#1E03#;
    GL_VENDOR                          : constant Integer_4_Unsigned := 16#1F00#;
    GL_RENDERER                        : constant Integer_4_Unsigned := 16#1F01#;
    GL_VERSION                         : constant Integer_4_Unsigned := 16#1F02#;
    GL_EXTENSIONS                      : constant Integer_4_Unsigned := 16#1F03#;
    GL_S                               : constant Integer_4_Unsigned := 16#2000#;
    GL_T                               : constant Integer_4_Unsigned := 16#2001#;
    GL_R                               : constant Integer_4_Unsigned := 16#2002#;
    GL_Q                               : constant Integer_4_Unsigned := 16#2003#;
    GL_MODULATE                        : constant Integer_4_Unsigned := 16#2100#;
    GL_DECAL                           : constant Integer_4_Unsigned := 16#2101#;
    GL_TEXTURE_ENV_MODE                : constant Integer_4_Unsigned := 16#2200#;
    GL_TEXTURE_ENV_COLOR               : constant Integer_4_Unsigned := 16#2201#;
    GL_TEXTURE_ENV                     : constant Integer_4_Unsigned := 16#2300#;
    GL_EYE_LINEAR                      : constant Integer_4_Unsigned := 16#2400#;
    GL_OBJECT_LINEAR                   : constant Integer_4_Unsigned := 16#2401#;
    GL_SPHERE_MAP                      : constant Integer_4_Unsigned := 16#2402#;
    GL_TEXTURE_GEN_MODE                : constant Integer_4_Unsigned := 16#2500#;
    GL_OBJECT_PLANE                    : constant Integer_4_Unsigned := 16#2501#;
    GL_EYE_PLANE                       : constant Integer_4_Unsigned := 16#2502#;
    GL_NEAREST                         : constant Integer_4_Unsigned := 16#2600#;
    GL_LINEAR                          : constant Integer_4_Unsigned := 16#2601#;
    GL_NEAREST_MIPMAP_NEAREST          : constant Integer_4_Unsigned := 16#2700#;
    GL_LINEAR_MIPMAP_NEAREST           : constant Integer_4_Unsigned := 16#2701#;
    GL_NEAREST_MIPMAP_LINEAR           : constant Integer_4_Unsigned := 16#2702#;
    GL_LINEAR_MIPMAP_LINEAR            : constant Integer_4_Unsigned := 16#2703#;
    GL_TEXTURE_MAG_FILTER              : constant Integer_4_Unsigned := 16#2800#;
    GL_TEXTURE_MIN_FILTER              : constant Integer_4_Unsigned := 16#2801#;
    GL_TEXTURE_WRAP_S                  : constant Integer_4_Unsigned := 16#2802#;
    GL_TEXTURE_WRAP_T                  : constant Integer_4_Unsigned := 16#2803#;
    GL_CLAMP                           : constant Integer_4_Unsigned := 16#2900#;
    GL_REPEAT                          : constant Integer_4_Unsigned := 16#2901#;
    GL_CLIENT_PIXEL_STORE_BIT          : constant Integer_4_Unsigned := 16#0000_0001#;
    GL_CLIENT_VERTEX_ARRAY_BIT         : constant Integer_4_Unsigned := 16#0000_0002#;
    GL_CLIENT_ALL_ATTRIB_BITS          : constant Integer_4_Unsigned := 16#FFFF_FFFF#;
    GL_POLYGON_OFFSET_FACTOR           : constant Integer_4_Unsigned := 16#8038#;
    GL_POLYGON_OFFSET_UNITS            : constant Integer_4_Unsigned := 16#2A00#;
    GL_POLYGON_OFFSET_POINT            : constant Integer_4_Unsigned := 16#2A01#;
    GL_POLYGON_OFFSET_LINE             : constant Integer_4_Unsigned := 16#2A02#;
    GL_POLYGON_OFFSET_FILL             : constant Integer_4_Unsigned := 16#8037#;
    GL_ALPHA4                          : constant Integer_4_Unsigned := 16#803B#;
    GL_ALPHA8                          : constant Integer_4_Unsigned := 16#803C#;
    GL_ALPHA12                         : constant Integer_4_Unsigned := 16#803D#;
    GL_ALPHA16                         : constant Integer_4_Unsigned := 16#803E#;
    GL_LUMINANCE4                      : constant Integer_4_Unsigned := 16#803F#;
    GL_LUMINANCE8                      : constant Integer_4_Unsigned := 16#8040#;
    GL_LUMINANCE12                     : constant Integer_4_Unsigned := 16#8041#;
    GL_LUMINANCE16                     : constant Integer_4_Unsigned := 16#8042#;
    GL_LUMINANCE4_ALPHA4               : constant Integer_4_Unsigned := 16#8043#;
    GL_LUMINANCE6_ALPHA2               : constant Integer_4_Unsigned := 16#8044#;
    GL_LUMINANCE8_ALPHA8               : constant Integer_4_Unsigned := 16#8045#;
    GL_LUMINANCE12_ALPHA4              : constant Integer_4_Unsigned := 16#8046#;
    GL_LUMINANCE12_ALPHA12             : constant Integer_4_Unsigned := 16#8047#;
    GL_LUMINANCE16_ALPHA16             : constant Integer_4_Unsigned := 16#8048#;
    GL_INTENSITY                       : constant Integer_4_Unsigned := 16#8049#;
    GL_INTENSITY4                      : constant Integer_4_Unsigned := 16#804A#;
    GL_INTENSITY8                      : constant Integer_4_Unsigned := 16#804B#;
    GL_INTENSITY12                     : constant Integer_4_Unsigned := 16#804C#;
    GL_INTENSITY16                     : constant Integer_4_Unsigned := 16#804D#;
    GL_R3_G3_B2                        : constant Integer_4_Unsigned := 16#2A10#;
    GL_RGB4                            : constant Integer_4_Unsigned := 16#804F#;
    GL_RGB5                            : constant Integer_4_Unsigned := 16#8050#;
    GL_RGB8                            : constant Integer_4_Unsigned := 16#8051#;
    GL_RGB10                           : constant Integer_4_Unsigned := 16#8052#;
    GL_RGB12                           : constant Integer_4_Unsigned := 16#8053#;
    GL_RGB16                           : constant Integer_4_Unsigned := 16#8054#;
    GL_RGBA2                           : constant Integer_4_Unsigned := 16#8055#;
    GL_RGBA4                           : constant Integer_4_Unsigned := 16#8056#;
    GL_RGB5_A1                         : constant Integer_4_Unsigned := 16#8057#;
    GL_RGBA8                           : constant Integer_4_Unsigned := 16#8058#;
    GL_RGB10_A2                        : constant Integer_4_Unsigned := 16#8059#;
    GL_RGBA12                          : constant Integer_4_Unsigned := 16#805A#;
    GL_RGBA16                          : constant Integer_4_Unsigned := 16#805B#;
    GL_TEXTURE_RED_SIZE                : constant Integer_4_Unsigned := 16#805C#;
    GL_TEXTURE_GREEN_SIZE              : constant Integer_4_Unsigned := 16#805D#;
    GL_TEXTURE_BLUE_SIZE               : constant Integer_4_Unsigned := 16#805E#;
    GL_TEXTURE_ALPHA_SIZE              : constant Integer_4_Unsigned := 16#805F#;
    GL_TEXTURE_LUMINANCE_SIZE          : constant Integer_4_Unsigned := 16#8060#;
    GL_TEXTURE_INTENSITY_SIZE          : constant Integer_4_Unsigned := 16#8061#;
    GL_PROXY_TEXTURE_1D                : constant Integer_4_Unsigned := 16#8063#;
    GL_PROXY_TEXTURE_2D                : constant Integer_4_Unsigned := 16#8064#;
    GL_TEXTURE_PRIORITY                : constant Integer_4_Unsigned := 16#8066#;
    GL_TEXTURE_RESIDENT                : constant Integer_4_Unsigned := 16#8067#;
    GL_TEXTURE_BINDING_1D              : constant Integer_4_Unsigned := 16#8068#;
    GL_TEXTURE_BINDING_2D              : constant Integer_4_Unsigned := 16#8069#;
    GL_VERTEX_ARRAY                    : constant Integer_4_Unsigned := 16#8074#;
    GL_NORMAL_ARRAY                    : constant Integer_4_Unsigned := 16#8075#;
    GL_COLOR_ARRAY                     : constant Integer_4_Unsigned := 16#8076#;
    GL_INDEX_ARRAY                     : constant Integer_4_Unsigned := 16#8077#;
    GL_TEXTURE_COORD_ARRAY             : constant Integer_4_Unsigned := 16#8078#;
    GL_EDGE_FLAG_ARRAY                 : constant Integer_4_Unsigned := 16#8079#;
    GL_VERTEX_ARRAY_SIZE               : constant Integer_4_Unsigned := 16#807A#;
    GL_VERTEX_ARRAY_TYPE               : constant Integer_4_Unsigned := 16#807B#;
    GL_VERTEX_ARRAY_STRIDE             : constant Integer_4_Unsigned := 16#807C#;
    GL_NORMAL_ARRAY_TYPE               : constant Integer_4_Unsigned := 16#807E#;
    GL_NORMAL_ARRAY_STRIDE             : constant Integer_4_Unsigned := 16#807F#;
    GL_COLOR_ARRAY_SIZE                : constant Integer_4_Unsigned := 16#8081#;
    GL_COLOR_ARRAY_TYPE                : constant Integer_4_Unsigned := 16#8082#;
    GL_COLOR_ARRAY_STRIDE              : constant Integer_4_Unsigned := 16#8083#;
    GL_INDEX_ARRAY_TYPE                : constant Integer_4_Unsigned := 16#8085#;
    GL_INDEX_ARRAY_STRIDE              : constant Integer_4_Unsigned := 16#8086#;
    GL_TEXTURE_COORD_ARRAY_SIZE        : constant Integer_4_Unsigned := 16#8088#;
    GL_TEXTURE_COORD_ARRAY_TYPE        : constant Integer_4_Unsigned := 16#8089#;
    GL_TEXTURE_COORD_ARRAY_STRIDE      : constant Integer_4_Unsigned := 16#808A#;
    GL_EDGE_FLAG_ARRAY_STRIDE          : constant Integer_4_Unsigned := 16#808C#;
    GL_VERTEX_ARRAY_POINTER            : constant Integer_4_Unsigned := 16#808E#;
    GL_NORMAL_ARRAY_POINTER            : constant Integer_4_Unsigned := 16#808F#;
    GL_COLOR_ARRAY_POINTER             : constant Integer_4_Unsigned := 16#8090#;
    GL_INDEX_ARRAY_POINTER             : constant Integer_4_Unsigned := 16#8091#;
    GL_TEXTURE_COORD_ARRAY_POINTER     : constant Integer_4_Unsigned := 16#8092#;
    GL_EDGE_FLAG_ARRAY_POINTER         : constant Integer_4_Unsigned := 16#8093#;
    GL_V2F                             : constant Integer_4_Unsigned := 16#2A20#;
    GL_V3F                             : constant Integer_4_Unsigned := 16#2A21#;
    GL_C4UB_V2F                        : constant Integer_4_Unsigned := 16#2A22#;
    GL_C4UB_V3F                        : constant Integer_4_Unsigned := 16#2A23#;
    GL_C3F_V3F                         : constant Integer_4_Unsigned := 16#2A24#;
    GL_N3F_V3F                         : constant Integer_4_Unsigned := 16#2A25#;
    GL_C4F_N3F_V3F                     : constant Integer_4_Unsigned := 16#2A26#;
    GL_T2F_V3F                         : constant Integer_4_Unsigned := 16#2A27#;
    GL_T4F_V4F                         : constant Integer_4_Unsigned := 16#2A28#;
    GL_T2F_C4UB_V3F                    : constant Integer_4_Unsigned := 16#2A29#;
    GL_T2F_C3F_V3F                     : constant Integer_4_Unsigned := 16#2A2A#;
    GL_T2F_N3F_V3F                     : constant Integer_4_Unsigned := 16#2A2B#;
    GL_T2F_C4F_N3F_V3F                 : constant Integer_4_Unsigned := 16#2A2C#;
    GL_T4F_C4F_N3F_V4F                 : constant Integer_4_Unsigned := 16#2A2D#;
    GL_EXT_vertex_array                : constant Integer_4_Unsigned := 1;
    GL_EXT_bgra                        : constant Integer_4_Unsigned := 1;
    GL_EXT_paletted_texture            : constant Integer_4_Unsigned := 1;
    GL_WIN_swap_hint                   : constant Integer_4_Unsigned := 1;
    GL_WIN_draw_range_elements         : constant Integer_4_Unsigned := 1;
    GL_VERTEX_ARRAY_EXT                : constant Integer_4_Unsigned := 16#8074#;
    GL_NORMAL_ARRAY_EXT                : constant Integer_4_Unsigned := 16#8075#;
    GL_COLOR_ARRAY_EXT                 : constant Integer_4_Unsigned := 16#8076#;
    GL_INDEX_ARRAY_EXT                 : constant Integer_4_Unsigned := 16#8077#;
    GL_TEXTURE_COORD_ARRAY_EXT         : constant Integer_4_Unsigned := 16#8078#;
    GL_EDGE_FLAG_ARRAY_EXT             : constant Integer_4_Unsigned := 16#8079#;
    GL_VERTEX_ARRAY_SIZE_EXT           : constant Integer_4_Unsigned := 16#807A#;
    GL_VERTEX_ARRAY_TYPE_EXT           : constant Integer_4_Unsigned := 16#807B#;
    GL_VERTEX_ARRAY_STRIDE_EXT         : constant Integer_4_Unsigned := 16#807C#;
    GL_VERTEX_ARRAY_COUNT_EXT          : constant Integer_4_Unsigned := 16#807D#;
    GL_NORMAL_ARRAY_TYPE_EXT           : constant Integer_4_Unsigned := 16#807E#;
    GL_NORMAL_ARRAY_STRIDE_EXT         : constant Integer_4_Unsigned := 16#807F#;
    GL_NORMAL_ARRAY_COUNT_EXT          : constant Integer_4_Unsigned := 16#8080#;
    GL_COLOR_ARRAY_SIZE_EXT            : constant Integer_4_Unsigned := 16#8081#;
    GL_COLOR_ARRAY_TYPE_EXT            : constant Integer_4_Unsigned := 16#8082#;
    GL_COLOR_ARRAY_STRIDE_EXT          : constant Integer_4_Unsigned := 16#8083#;
    GL_COLOR_ARRAY_COUNT_EXT           : constant Integer_4_Unsigned := 16#8084#;
    GL_INDEX_ARRAY_TYPE_EXT            : constant Integer_4_Unsigned := 16#8085#;
    GL_INDEX_ARRAY_STRIDE_EXT          : constant Integer_4_Unsigned := 16#8086#;
    GL_INDEX_ARRAY_COUNT_EXT           : constant Integer_4_Unsigned := 16#8087#;
    GL_TEXTURE_COORD_ARRAY_SIZE_EXT    : constant Integer_4_Unsigned := 16#8088#;
    GL_TEXTURE_COORD_ARRAY_TYPE_EXT    : constant Integer_4_Unsigned := 16#8089#;
    GL_TEXTURE_COORD_ARRAY_STRIDE_EXT  : constant Integer_4_Unsigned := 16#808A#;
    GL_TEXTURE_COORD_ARRAY_COUNT_EXT   : constant Integer_4_Unsigned := 16#808B#;
    GL_EDGE_FLAG_ARRAY_STRIDE_EXT      : constant Integer_4_Unsigned := 16#808C#;
    GL_EDGE_FLAG_ARRAY_COUNT_EXT       : constant Integer_4_Unsigned := 16#808D#;
    GL_VERTEX_ARRAY_POINTER_EXT        : constant Integer_4_Unsigned := 16#808E#;
    GL_NORMAL_ARRAY_POINTER_EXT        : constant Integer_4_Unsigned := 16#808F#;
    GL_COLOR_ARRAY_POINTER_EXT         : constant Integer_4_Unsigned := 16#8090#;
    GL_INDEX_ARRAY_POINTER_EXT         : constant Integer_4_Unsigned := 16#8091#;
    GL_TEXTURE_COORD_ARRAY_POINTER_EXT : constant Integer_4_Unsigned := 16#8092#;
    GL_EDGE_FLAG_ARRAY_POINTER_EXT     : constant Integer_4_Unsigned := 16#8093#;
    GL_DOUBLE_EXT                      : constant Integer_4_Unsigned := GL_DOUBLE;
    GL_BGR_EXT                         : constant Integer_4_Unsigned := 16#80E0#;
    GL_BGRA_EXT                        : constant Integer_4_Unsigned := 16#80E1#;
    GL_COLOR_TABLE_FORMAT_EXT          : constant Integer_4_Unsigned := 16#80D8#;
    GL_COLOR_TABLE_WIDTH_EXT           : constant Integer_4_Unsigned := 16#80D9#;
    GL_COLOR_TABLE_RED_SIZE_EXT        : constant Integer_4_Unsigned := 16#80DA#;
    GL_COLOR_TABLE_GREEN_SIZE_EXT      : constant Integer_4_Unsigned := 16#80DB#;
    GL_COLOR_TABLE_BLUE_SIZE_EXT       : constant Integer_4_Unsigned := 16#80DC#;
    GL_COLOR_TABLE_ALPHA_SIZE_EXT      : constant Integer_4_Unsigned := 16#80DD#;
    GL_COLOR_TABLE_LUMINANCE_SIZE_EXT  : constant Integer_4_Unsigned := 16#80DE#;
    GL_COLOR_TABLE_INTENSITY_SIZE_EXT  : constant Integer_4_Unsigned := 16#80DF#;
    GL_COLOR_INDEX1_EXT                : constant Integer_4_Unsigned := 16#80E2#;
    GL_COLOR_INDEX2_EXT                : constant Integer_4_Unsigned := 16#80E3#;
    GL_COLOR_INDEX4_EXT                : constant Integer_4_Unsigned := 16#80E4#;
    GL_COLOR_INDEX8_EXT                : constant Integer_4_Unsigned := 16#80E5#;
    GL_COLOR_INDEX12_EXT               : constant Integer_4_Unsigned := 16#80E6#;
    GL_COLOR_INDEX16_EXT               : constant Integer_4_Unsigned := 16#80E7#;
    GL_MAX_ELEMENTS_VERTICES_WIN       : constant Integer_4_Unsigned := 16#80E8#;
    GL_MAX_ELEMENTS_INDICES_WIN        : constant Integer_4_Unsigned := 16#80E9#;
    GL_PHONG_WIN                       : constant Integer_4_Unsigned := 16#80EA#;
    GL_PHONG_HINT_WIN                  : constant Integer_4_Unsigned := 16#80EB#;
    GL_FOG_SPECULAR_TEXTURE_WIN        : constant Integer_4_Unsigned := 16#80EC#;
    GL_LOGIC_OP                        : constant Integer_4_Unsigned := GL_INDEX_LOGIC_OP;
    GL_TEXTURE_COMPONENTS              : constant Integer_4_Unsigned := GL_TEXTURE_INTERNAL_FORMAT;
  ---------------
  -- Accessors --
  ---------------
    glAccum                  : Access_Procedure_ := null;
    glAlphaFunc              : Access_Procedure_ := null;
    glAreTexturesResident    : Access_Procedure_ := null;
    glArrayElement           : Access_Procedure_ := null;
    glBegin                  : Access_Procedure_ := null;
    glBindTexture            : Access_Procedure_ := null;
    glBitmap                 : Access_Procedure_ := null;
    glBlendFunc              : Access_Procedure_ := null;
    glCallList               : Access_Procedure_ := null;
    glCallLists              : Access_Procedure_ := null;
    glClear                  : Access_Procedure_ := null;
    glClearAccum             : Access_Procedure_ := null;
    glClearColor             : Access_Procedure_ := null;
    glClearDepth             : Access_Procedure_ := null;
    glClearIndex             : Access_Procedure_ := null;
    glClearStencil           : Access_Procedure_ := null;
    glClipPlane              : Access_Procedure_ := null;
    glColor3b                : Access_Procedure_ := null;
    glColor3bv               : Access_Procedure_ := null;
    glColor3d                : Access_Procedure_ := null;
    glColor3dv               : Access_Procedure_ := null;
    glColor3f                : Access_Procedure_ := null;
    glColor3fv               : Access_Procedure_ := null;
    glColor3i                : Access_Procedure_ := null;
    glColor3iv               : Access_Procedure_ := null;
    glColor3s                : Access_Procedure_ := null;
    glColor3sv               : Access_Procedure_ := null;
    glColor3ub               : Access_Procedure_ := null;
    glColor3ubv              : Access_Procedure_ := null;
    glColor3ui               : Access_Procedure_ := null;
    glColor3uiv              : Access_Procedure_ := null;
    glColor3us               : Access_Procedure_ := null;
    glColor3usv              : Access_Procedure_ := null;
    glColor4b                : Access_Procedure_ := null;
    glColor4bv               : Access_Procedure_ := null;
    glColor4d                : Access_Procedure_ := null;
    glColor4dv               : Access_Procedure_ := null;
    glColor4f                : Access_Procedure_ := null;
    glColor4fv               : Access_Procedure_ := null;
    glColor4i                : Access_Procedure_ := null;
    glColor4iv               : Access_Procedure_ := null;
    glColor4s                : Access_Procedure_ := null;
    glColor4sv               : Access_Procedure_ := null;
    glColor4ub               : Access_Procedure_ := null;
    glColor4ubv              : Access_Procedure_ := null;
    glColor4ui               : Access_Procedure_ := null;
    glColor4uiv              : Access_Procedure_ := null;
    glColor4us               : Access_Procedure_ := null;
    glColor4usv              : Access_Procedure_ := null;
    glColorMask              : Access_Procedure_ := null;
    glColorMaterial          : Access_Procedure_ := null;
    glColorPointer           : Access_Procedure_ := null;
    glCopyPixels             : Access_Procedure_ := null;
    glCopyTexImage1D         : Access_Procedure_ := null;
    glCopyTexImage2D         : Access_Procedure_ := null;
    glCopyTexSubImage1D      : Access_Procedure_ := null;
    glCopyTexSubImage2D      : Access_Procedure_ := null;
    glCullFace               : Access_Procedure_ := null;
    glDeleteLists            : Access_Procedure_ := null;
    glDeleteTextures         : Access_Procedure_ := null;
    glDepthFunc              : Access_Procedure_ := null;
    glDepthMask              : Access_Procedure_ := null;
    glDepthRange             : Access_Procedure_ := null;
    glDisable                : Access_Procedure_ := null;
    glDisableClientState     : Access_Procedure_ := null;
    glDrawArrays             : Access_Procedure_ := null;
    glDrawBuffer             : Access_Procedure_ := null;
    glDrawElements           : Access_Procedure_ := null;
    glDrawPixels             : Access_Procedure_ := null;
    glEdgeFlag               : Access_Procedure_ := null;
    glEdgeFlagPointer        : Access_Procedure_ := null;
    glEdgeFlagv              : Access_Procedure_ := null;
    glEnable                 : Access_Procedure_ := null;
    glEnableClientState      : Access_Procedure_ := null;
    glEnd                    : Access_Procedure_ := null;
    glEndList                : Access_Procedure_ := null;
    glEvalCoord1d            : Access_Procedure_ := null;
    glEvalCoord1dv           : Access_Procedure_ := null;
    glEvalCoord1f            : Access_Procedure_ := null;
    glEvalCoord1fv           : Access_Procedure_ := null;
    glEvalCoord2d            : Access_Procedure_ := null;
    glEvalCoord2dv           : Access_Procedure_ := null;
    glEvalCoord2f            : Access_Procedure_ := null;
    glEvalCoord2fv           : Access_Procedure_ := null;
    glEvalMesh1              : Access_Procedure_ := null;
    glEvalMesh2              : Access_Procedure_ := null;
    glEvalPoint1             : Access_Procedure_ := null;
    glEvalPoint2             : Access_Procedure_ := null;
    glFeedbackBuffer         : Access_Procedure_ := null;
    glFinish                 : Access_Procedure_ := null;
    glFlush                  : Access_Procedure_ := null;
    glFogf                   : Access_Procedure_ := null;
    glFogfv                  : Access_Procedure_ := null;
    glFogi                   : Access_Procedure_ := null;
    glFogiv                  : Access_Procedure_ := null;
    glFrontFace              : Access_Procedure_ := null;
    glFrustum                : Access_Procedure_ := null;
    glGenLists               : Access_Procedure_ := null;
    glGenTextures            : Access_Procedure_ := null;
    glGetBooleanv            : Access_Procedure_ := null;
    glGetClipPlane           : Access_Procedure_ := null;
    glGetDoublev             : Access_Procedure_ := null;
    glGetError               : Access_Procedure_ := null;
    glGetFloatv              : Access_Procedure_ := null;
    glGetIntegerv            : Access_Procedure_ := null;
    glGetLightfv             : Access_Procedure_ := null;
    glGetLightiv             : Access_Procedure_ := null;
    glGetMapdv               : Access_Procedure_ := null;
    glGetMapfv               : Access_Procedure_ := null;
    glGetMapiv               : Access_Procedure_ := null;
    glGetMaterialfv          : Access_Procedure_ := null;
    glGetMaterialiv          : Access_Procedure_ := null;
    glGetPixelMapfv          : Access_Procedure_ := null;
    glGetPixelMapuiv         : Access_Procedure_ := null;
    glGetPixelMapusv         : Access_Procedure_ := null;
    glGetPointerb            : Access_Procedure_ := null;
    glGetPolygonStipple      : Access_Procedure_ := null;
    glGetString              : Access_Procedure_ := null;
    glGetTexEnvfv            : Access_Procedure_ := null;
    glGetTexEnviv            : Access_Procedure_ := null;
    glGetTexGendv            : Access_Procedure_ := null;
    glGetTexGenfv            : Access_Procedure_ := null;
    glGetTexGeniv            : Access_Procedure_ := null;
    glGetTexImage            : Access_Procedure_ := null;
    glGetTexLevelParameterfv : Access_Procedure_ := null;
    glGetTexLevelParameteriv : Access_Procedure_ := null;
    glGetTexParameterfv      : Access_Procedure_ := null;
    glGetTexParameteriv      : Access_Procedure_ := null;
    glHint                   : Access_Procedure_ := null;
    glIndexMask              : Access_Procedure_ := null;
    glIndexPointer           : Access_Procedure_ := null;
    glIndexd                 : Access_Procedure_ := null;
    glIndexdv                : Access_Procedure_ := null;
    glIndexf                 : Access_Procedure_ := null;
    glIndexfv                : Access_Procedure_ := null;
    glIndexi                 : Access_Procedure_ := null;
    glIndexiv                : Access_Procedure_ := null;
    glIndexs                 : Access_Procedure_ := null;
    glIndexsv                : Access_Procedure_ := null;
    glIndexub                : Access_Procedure_ := null;
    glIndexubv               : Access_Procedure_ := null;
    glInitNames              : Access_Procedure_ := null;
    glInterleavedArrays      : Access_Procedure_ := null;
    glIsEnabled              : Access_Procedure_ := null;
    glIsList                 : Access_Procedure_ := null;
    glIsTexture              : Access_Procedure_ := null;
    glLightModelf            : Access_Procedure_ := null;
    glLightModelfv           : Access_Procedure_ := null;
    glLightModeli            : Access_Procedure_ := null;
    glLightModeliv           : Access_Procedure_ := null;
    glLightf                 : Access_Procedure_ := null;
    glLightfv                : Access_Procedure_ := null;
    glLighti                 : Access_Procedure_ := null;
    glLightiv                : Access_Procedure_ := null;
    glLineStipple            : Access_Procedure_ := null;
    glLineWidth              : Access_Procedure_ := null;
    glListBase               : Access_Procedure_ := null;
    glLoadIdentity           : Access_Procedure_ := null;
    glLoadMatrixd            : Access_Procedure_ := null;
    glLoadMatrixf            : Access_Procedure_ := null;
    glLoadName               : Access_Procedure_ := null;
    glLogicOp                : Access_Procedure_ := null;
    glMap1D                  : Access_Procedure_ := null;
    glMap1f                  : Access_Procedure_ := null;
    glMap2D                  : Access_Procedure_ := null;
    glMap2f                  : Access_Procedure_ := null;
    glMapGrid1d              : Access_Procedure_ := null;
    glMapGrid1f              : Access_Procedure_ := null;
    glMapGrid2d              : Access_Procedure_ := null;
    glMapGrid2f              : Access_Procedure_ := null;
    glMaterialf              : Access_Procedure_ := null;
    glMaterialfv             : Access_Procedure_ := null;
    glMateriali              : Access_Procedure_ := null;
    glMaterialiv             : Access_Procedure_ := null;
    glMatrixMode             : Access_Procedure_ := null;
    glMultMatrixd            : Access_Procedure_ := null;
    glMultMatrixf            : Access_Procedure_ := null;
    glNewList                : Access_Procedure_ := null;
    glNormal3b               : Access_Procedure_ := null;
    glNormal3Bv              : Access_Procedure_ := null;
    glNormal3D               : Access_Procedure_ := null;
    glNormal3Dv              : Access_Procedure_ := null;
    glNormal3f               : Access_Procedure_ := null;
    glNormal3fv              : Access_Procedure_ := null;
    glNormal3i               : Access_Procedure_ := null;
    glNormal3iv              : Access_Procedure_ := null;
    glNormal3s               : Access_Procedure_ := null;
    glNormal3sv              : Access_Procedure_ := null;
    glNormalPointer          : Access_Procedure_ := null;
    glOrtho                  : Access_Procedure_ := null;
    glPassThrough            : Access_Procedure_ := null;
    glPixelMapfv             : Access_Procedure_ := null;
    glPixelMapuiv            : Access_Procedure_ := null;
    glPixelMapusv            : Access_Procedure_ := null;
    glPixelStoref            : Access_Procedure_ := null;
    glPixelStorei            : Access_Procedure_ := null;
    glPixelTransferf         : Access_Procedure_ := null;
    glPixelTransferi         : Access_Procedure_ := null;
    glPixelZoom              : Access_Procedure_ := null;
    glPointSize              : Access_Procedure_ := null;
    glPolygonMode            : Access_Procedure_ := null;
    glPolygonOffset          : Access_Procedure_ := null;
    glPolygonStipple         : Access_Procedure_ := null;
    glPopAttrib              : Access_Procedure_ := null;
    glPopClientAttrib        : Access_Procedure_ := null;
    glPopMatrix              : Access_Procedure_ := null;
    glPopName                : Access_Procedure_ := null;
    glPrioritizeTextures     : Access_Procedure_ := null;
    glPushAttrib             : Access_Procedure_ := null;
    glPushClientAttrib       : Access_Procedure_ := null;
    glPushMatrix             : Access_Procedure_ := null;
    glPushName               : Access_Procedure_ := null;
    glRasterPos2D            : Access_Procedure_ := null;
    glRasterPos2Dv           : Access_Procedure_ := null;
    glRasterPos2f            : Access_Procedure_ := null;
    glRasterPos2fv           : Access_Procedure_ := null;
    glRasterPos2i            : Access_Procedure_ := null;
    glRasterPos2iv           : Access_Procedure_ := null;
    glRasterPos2s            : Access_Procedure_ := null;
    glRasterPos2sv           : Access_Procedure_ := null;
    glRasterPos3d            : Access_Procedure_ := null;
    glRasterPos3dv           : Access_Procedure_ := null;
    glRasterPos3f            : Access_Procedure_ := null;
    glRasterPos3fv           : Access_Procedure_ := null;
    glRasterPos3i            : Access_Procedure_ := null;
    glRasterPos3iv           : Access_Procedure_ := null;
    glRasterPos3s            : Access_Procedure_ := null;
    glRasterPos3sv           : Access_Procedure_ := null;
    glRasterPos4d            : Access_Procedure_ := null;
    glRasterPos4dv           : Access_Procedure_ := null;
    glRasterPos4f            : Access_Procedure_ := null;
    glRasterPos4fv           : Access_Procedure_ := null;
    glRasterPos4i            : Access_Procedure_ := null;
    glRasterPos4iv           : Access_Procedure_ := null;
    glRasterPos4s            : Access_Procedure_ := null;
    glRasterPos4sv           : Access_Procedure_ := null;
    glReadBuffer             : Access_Procedure_ := null;
    glReadPixels             : Access_Procedure_ := null;
    glRectd                  : Access_Procedure_ := null;
    glRectdv                 : Access_Procedure_ := null;
    glRectf                  : Access_Procedure_ := null;
    glRectfv                 : Access_Procedure_ := null;
    glRecti                  : Access_Procedure_ := null;
    glRectiv                 : Access_Procedure_ := null;
    glRects                  : Access_Procedure_ := null;
    glRectsv                 : Access_Procedure_ := null;
    glRenderMode             : Access_Procedure_ := null;
    glRotated                : Access_Procedure_ := null;
    glRotatef                : Access_Procedure_ := null;
    glScaled                 : Access_Procedure_ := null;
    glScalef                 : Access_Procedure_ := null;
    glScissor                : Access_Procedure_ := null;
    glSelectBuffer           : Access_Procedure_ := null;
    glShadeModel             : Access_Procedure_ := null;
    glStencilFunc            : Access_Procedure_ := null;
    glStencilMask            : Access_Procedure_ := null;
    glStencilOp              : Access_Procedure_ := null;
    glTexCoord1d             : Access_Procedure_ := null;
    glTexCoord1dv            : Access_Procedure_ := null;
    glTexCoord1f             : Access_Procedure_ := null;
    glTexCoord1fv            : Access_Procedure_ := null;
    glTexCoord1i             : Access_Procedure_ := null;
    glTexCoord1iv            : Access_Procedure_ := null;
    glTexCoord1s             : Access_Procedure_ := null;
    glTexCoord1sv            : Access_Procedure_ := null;
    glTexCoord2d             : Access_Procedure_ := null;
    glTexCoord2dv            : Access_Procedure_ := null;
    glTexCoord2f             : Access_Procedure_ := null;
    glTexCoord2fv            : Access_Procedure_ := null;
    glTexCoord2i             : Access_Procedure_ := null;
    glTexCoord2iv            : Access_Procedure_ := null;
    glTexCoord2s             : Access_Procedure_ := null;
    glTexCoord2sv            : Access_Procedure_ := null;
    glTexCoord3d             : Access_Procedure_ := null;
    glTexCoord3dv            : Access_Procedure_ := null;
    glTexCoord3f             : Access_Procedure_ := null;
    glTexCoord3fv            : Access_Procedure_ := null;
    glTexCoord3i             : Access_Procedure_ := null;
    glTexCoord3iv            : Access_Procedure_ := null;
    glTexCoord3s             : Access_Procedure_ := null;
    glTexCoord3dv            : Access_Procedure_ := null;
    glTexCoord4d             : Access_Procedure_ := null;
    glTexCoord4dv            : Access_Procedure_ := null;
    glTexCoord4f             : Access_Procedure_ := null;
    glTexCoord4fv            : Access_Procedure_ := null;
    glTexCoord4i             : Access_Procedure_ := null;
    glTexCoord4iv            : Access_Procedure_ := null;
    glTexCoord4d             : Access_Procedure_ := null;
    glTexCoord4dv            : Access_Procedure_ := null;
    glTexCoordPointer        : Access_Procedure_ := null;
    glTexEnvf                : Access_Procedure_ := null;
    glTexEnvfv               : Access_Procedure_ := null;
    glTexEnvi                : Access_Procedure_ := null;
    glTexEnviv               : Access_Procedure_ := null;
    glTexGend                : Access_Procedure_ := null;
    glTexGendv               : Access_Procedure_ := null;
    glTexGenf                : Access_Procedure_ := null;
    glTexGenfv               : Access_Procedure_ := null;
    glTexGeni                : Access_Procedure_ := null;
    glTexGeniv               : Access_Procedure_ := null;
    glTexImage1D             : Access_Procedure_ := null;
    glTexImage2D             : Access_Procedure_ := null;
    glTexParameterf          : Access_Procedure_ := null;
    glTexParameterfv         : Access_Procedure_ := null;
    glTexParameteri          : Access_Procedure_ := null;
    glTexParameteriv         : Access_Procedure_ := null;
    glTexSubImage1D          : Access_Procedure_ := null;
    glTexSubImage2D          : Access_Procedure_ := null;
    glTranslated             : Access_Procedure_ := null;
    glTranslatef             : Access_Procedure_ := null;
    glVertex2d               : Access_Procedure_ := null;
    glVertex2dv              : Access_Procedure_ := null;
    glVertex2f               : Access_Procedure_ := null;
    glVertex2fv              : Access_Procedure_ := null;
    glVertex2i               : Access_Procedure_ := null;
    glVertex2iv              : Access_Procedure_ := null;
    glVertex2s               : Access_Procedure_ := null;
    glVertex2sv              : Access_Procedure_ := null;
    glVertex3d               : Access_Procedure_ := null;
    glVertex3dv              : Access_Procedure_ := null;
    glVertex3f               : Access_Procedure_ := null;
    glVertex3fv              : Access_Procedure_ := null;
    glVertex3i               : Access_Procedure_ := null;
    glVertex3iv              : Access_Procedure_ := null;
    glVertex3s               : Access_Procedure_ := null;
    glVertex3sv              : Access_Procedure_ := null;
    glVertex4d               : Access_Procedure_ := null;
    glVertex4dv              : Access_Procedure_ := null;
    glVertex4f               : Access_Procedure_ := null;
    glVertex4fv              : Access_Procedure_ := null;
    glVertex4i               : Access_Procedure_ := null;
    glVertex4iv              : Access_Procedure_ := null;
    glVertex4s               : Access_Procedure_ := null;
    glVertex4sv              : Access_Procedure_ := null;
    glVertexPointer          : Access_Procedure_ := null;
  -----------------
  -- Subprograms --
  -----------------
    procedure Run
    procedure Set_Rendering_Backend
-- 1. Detect all hardware displays
-- 2. Setup for each one
-- 2a. … Create OS window (HWND CreateWindow method)
-- 2b. … Get the HDC device context from the window (GetDC method)
-- 2c. … Create HGLRC opengl context. (wglCreateContext method)
-- 3. Call wglShareLists
-- 4. Set wglMakeCurrent to HDC and HGLRC for context 0 (wglMakeCurrent method)
-- 5. Create textures, VBOs, disp lists, frame buffers, etc.
-- 6. Start main rendering (for each monitor)
-- 6a. … Call wglMakeCurrent for HDC/HGLRC for specific monitor
-- 6b. … Create projection, view matricies for specific monitor
-- 6c. … Clear frame and depth buffer
-- 6d. … Draw scene
-- 6e. … Call wglSwapBuffers to refresh that monitor
-- 6f. End render loop
-- 7. Delete all textures, VBOs, then close contexts.
    procedure Accumulate(
      Operation : in Integer_4_Unsigned;
      Value     : in Float_4_Real);
    procedure Alpha_Function(
      Function  : in Integer_4_Unsigned;
      Reference : in Float_4_Real);
    procedure Begin_Drawing(
      Mode : in Integer_4_Unsigned);
    procedure Bitmap(
      Width    : in Integer_4_Signed;
      Height   : in Integer_4_Signed;
      X_Origin : in Float_4_Real;
      Y_Origin : in Float_4_Real;
      X_Move   : in Float_4_Real;
      Y_Move   : in Float_4_Real;
      Bitmap   : in Access_Integer_1_Unsigned_C);
    procedure Blend_Function(
      S_Factor : in Integer_4_Unsigned;
      D_Factor : in Integer_4_Unsigned);
    procedure Call_List(
      List : in Integer_4_Unsigned);
    procedure Call_Lists(
      Number   : in Integer_4_Signed;
      Grouping : in Integer_4_Unsigned; -- Default: GL_UNSIGNED_BYTE -- Others: GL_2_BYTES, GL_3_BYTES, GL_4_BYTES
      Lists    : in Array_Integer_1_Unsigned);
    procedure Call_Lists(
      Number : in Integer_4_Signed;
      Lists  : in Array_Integer_2_Unsigned);
    procedure Call_Lists(
      Number : in Integer_4_Signed;
      Lists  : in Array_Integer_4_Unsigned);
    procedure Call_Lists(
      Number : in Integer_4_Signed;
      Lists  : in Array_Integer_1_Signed);
    procedure Call_Lists(
      Number : in Integer_4_Signed;
      Lists  : in Array_Integer_2_Signed);
    procedure Call_Lists(
      Number : in Integer_4_Signed;
      Lists  : in Array_Integer_4_Signed);
    procedure Call_Lists(
      Number : in Integer_4_Signed;
      Lists  : in Array_Float_4_Real);
    procedure Clear(
      Mask : in Integer_4_Unsigned);
    procedure Clear_Accumulation(
      Red   : in Float_4_Real;
      Green : in Float_4_Real;
      Blue  : in Float_4_Real;
      Alpha : in Float_4_Real);
    procedure Clear_Color(
      Red   : in Float_4_Real;
      Green : in Float_4_Real;
      Blue  : in Float_4_Real;
      Alpha : in Float_4_Real);
    procedure Clear_Depth(
      Depth : in Float_8_Real);
    procedure Clear_Index(
      C : in Float_4_Real);
    procedure Clear_Stencil(
      S : in Integer_4_Signed);
    procedure Clip_Plane(
      Plane    : in Integer_4_Unsigned;
      Equation : in Access_Constant_Float_8_Real);
    procedure Color(
      Red   : in Integer_1_Unsigned;
      Green : in Integer_1_Unsigned;
      Blue  : in Integer_1_Unsigned);
    procedure Color(
      V : in Win32.PCSTR);
    procedure Color(
      Red   : in Float_8_Real;
      Green : in Float_8_Real;
      Blue  : in Float_8_Real);
    procedure Color(
      V : in Access_Constant_Float_8_Real);
    procedure Color(
      Red   : in Float_4_Real;
      Green : in Float_4_Real;
      Blue  : in Float_4_Real);
    procedure Color(
      V : in Access_Constant_Float_4_Real);
    procedure Color(
      Red   : in Integer_4_Signed;
      Green : in Integer_4_Signed;
      Blue  : in Integer_4_Signed);
    procedure Color(
      V : in Access_Constant_Integer_4_Signed);
    procedure Color(
      Red   : in Integer_2_Signed;
      Green : in Integer_2_Signed;
      Blue  : in Integer_2_Signed);
    procedure Color(
      V : in Access_Constant_Integer_2_Signed);
    procedure Color(
      Red   : in Integer_1_Unsigned;
      Green : in Integer_1_Unsigned;
      Blue  : in Integer_1_Unsigned);
    procedure Color(
      V : in Access_Integer_1_Unsigned_C);
    procedure Color(
      Red   : in Integer_4_Unsigned;
      Green : in Integer_4_Unsigned;
      Blue  : in Integer_4_Unsigned);
    procedure Color(
      V : in Access_Constant_Integer_4_Unsigned);
    procedure Color(
      Red   : in Integer_2_Unsigned;
      Green : in Integer_2_Unsigned;
      Blue  : in Integer_2_Unsigned);
    procedure Color(
      V : in Win32.PCWSTR);
    procedure Color(
      Red   : in Integer_1_Unsigned;
      Green : in Integer_1_Unsigned;
      Blue  : in Integer_1_Unsigned;
      Alpha : in Integer_1_Unsigned);
    procedure Color(
      V : in Win32.PCSTR);
    procedure Color(
      Red   : in Float_8_Real;
      Green : in Float_8_Real;
      Blue  : in Float_8_Real;
      Alpha : in Float_8_Real);
    procedure Color(
      V : in Access_Constant_Float_8_Real);
    procedure Color(
      Red   : in Float_4_Real;
      Green : in Float_4_Real;
      Blue  : in Float_4_Real;
      Alpha : in Float_4_Real);
    procedure Color(
      V : in Access_Constant_Float_4_Real);
    procedure Color(
      Red   : in Integer_4_Signed;
      Green : in Integer_4_Signed;
      Blue  : in Integer_4_Signed;
      Alpha : in Integer_4_Signed);
    procedure Color(
      V : in Access_Constant_Integer_4_Unsigned);
    procedure Color(
      Red   : in Integer_2_Signed;
      Green : in Integer_2_Signed;
      Blue  : in Integer_2_Signed;
      Alpha : in Integer_2_Signed);
    procedure Color(
      V : in Access_Constant_Integer_2_Signed);
    procedure Color(
      Red   : in Integer_1_Unsigned;
      Green : in Integer_1_Unsigned;
      Blue  : in Integer_1_Unsigned;
      Alpha : in Integer_1_Unsigned);
    procedure Color(
      V : in Access_Integer_1_Unsigned_C);
    procedure Color(
      Red   : in Integer_4_Unsigned;
      Green : in Integer_4_Unsigned;
      Blue  : in Integer_4_Unsigned;
      Alpha : in Integer_4_Unsigned);
    procedure Color(
      V : in Access_Constant_Integer_4_Signed);
    procedure Color(
      Red   : in Integer_2_Unsigned;
      Green : in Integer_2_Unsigned;
      Blue  : in Integer_2_Unsigned;
      Alpha : in Integer_2_Unsigned);
    procedure Color(
      V : in Win32.PCWSTR);
    procedure Color_Mask(
      Red   : in Integer_1_Unsigned;
      Green : in Integer_1_Unsigned;
      Blue  : in Integer_1_Unsigned;
      Alpha : in Integer_1_Unsigned);
    procedure Color_Material(
      Race : in Integer_4_Unsigned;
      Mode : in Integer_4_Unsigned);
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Integer_1_Unsigned);
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Integer_2_Unsigned);
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Integer_4_Unsigned);
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Integer_1_Signed);
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Integer_2_Signed);
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Integer_4_Signed);
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Float_4_Real);
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Float_8_Real);
    procedure Copy_Pixels(
      X      : in Integer_4_Signed;
      Y      : in Integer_4_Signed;
      Width  : in Integer_4_Signed;
      Height : in Integer_4_Signed;
      Kind   : in Integer_4_Unsigned);
    procedure Cull_Face(
      Mode : in Integer_4_Unsigned);
    procedure Delete_Lists(
      List   : in Integer_4_Unsigned;
      Bounds : in Integer_4_Signed);
    procedure Depth_Function(
      Function : in Integer_4_Unsigned);
    procedure Depth_Mask(
      Flag : in Integer_1_Unsigned);
    procedure Depth_Range(
      Z_Near : in Float_8_Real;
      Z_Far  : in Float_8_Real);
    procedure Disable(
      Cap : in Integer_4_Unsigned);
    procedure Draw_Buffer(
      Mode : in Integer_4_Unsigned);
    procedure Draw_Elements(
      Mode    : in Integer_4_Unsigned;
      Indices : in Array_Integer_1_Unsigned);
    procedure Draw_Elements(
      Mode    : in Integer_4_Unsigned;
      Indices : in Array_Integer_2_Unsigned);
    procedure Draw_Elements(
      Mode    : in Integer_4_Unsigned;
      Indices : in Array_Integer_4_Unsigned);
    procedure Draw_Pixels(
      Format : in Integer_4_Unsigned;
      Pixels : in Matrix_Integer_1_Unsigned);
    procedure Draw_Pixels(
      Format : in Integer_4_Unsigned;
      Pixels : in Matrix_Integer_1_Signed);
      end Draw_Pixels;
    procedure Draw_Pixels(
      Format : in Integer_4_Unsigned;
      Pixels : in Matrix_Integer_2_Unsigned);
      end Draw_Pixels;
    procedure Draw_Pixels(
      Format : in Integer_4_Unsigned;
      Pixels : in Matrix_Integer_2_Signed);
    procedure Draw_Pixels(
      Format : in Integer_4_Unsigned;
      Pixels : in Matrix_Integer_4_Unsigned);
    procedure Draw_Pixels(
      Format : in Integer_4_Unsigned;
      Pixels : in Matrix_Integer_4_Signed);
    procedure Edge_Flag(
      Flag : in Integer_1_Unsigned);
    -- procedure Edge_Flag(
    --   Offset  : Integer_4_Signed_C,
    --   Pointer : GLvoid *) --UNKNOWN
    procedure Edge_Flag(
      Flag : in Access_Integer_1_Unsigned_C);
    procedure Enable(
      Cap : in Integer_4_Unsigned);
    procedure End_OpenGL;
    procedure End_List;
    procedure Evaluate_Coordinate(
      U : in Float_8_Real);
    procedure Evaluate_Coordinate(
      U : in Access_Constant_Float_8_Real);
    procedure Evaluate_Coordinate(
      U : in Float_4_Real);
    procedure Evaluate_Coordinate(
      U : in Access_Constant_Float_4_Real);
    procedure Evaluate_Coordinate(
      U : in Float_8_Real;
      V : in Float_8_Real);
    procedure Evaluate_Coordinate(
      U : in Access_Constant_Float_8_Real);
    procedure Evaluate_Coordinate(
      U : in Float_4_Real;
      V : in Float_4_Real);
    procedure Evaluate_Coordinate(
      U : in Access_Constant_Float_4_Real);
    procedure Evaluate_Mesh(
      Mode : in Integer_4_Unsigned;
      I_1  : in Integer_4_Signed;
      J_2  : in Integer_4_Signed);
    procedure Evaluate_Mesh(
      Mode : in Integer_4_Unsigned;
      I_1  : in Integer_4_Signed;
      I_2  : in Integer_4_Signed;
      J_1  : in Integer_4_Signed;
      J_2  : in Integer_4_Signed);
    procedure Evaluate_Point(
      I : in Integer_4_Signed);
    procedure Evaluate_Point(
      I : in Integer_4_Signed;
      J : in Integer_4_Signed);
    function Get_Feedback_Buffer(
      Size   : in Integer_4_Signed;
      Kind   : in Integer_4_Unsigned)
      return Array_Float_4_Real;
    procedure Finish;
    procedure Flush;
    procedure Fog(
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real);
    procedure Fog(
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_4_Real);
    procedure Fog(
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed);
    procedure Fog(
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Integer_4_Signed);
    procedure Front_Face(
      Mode : in Integer_4_Unsigned);
    procedure Frustum(
      Left   : in Float_8_Real;
      Right  : in Float_8_Real;
      Bottom : in Float_8_Real;
      Top    : in Float_8_Real;
      Z_Near : in Float_8_Real;
      Z_Far  : in Float_8_Real);
    function Generate_Lists(
      Bounds : in Integer_4_Signed)
      return Integer_4_Unsigned;
    function Generate_Textures(
      Size : in Integer_4_Positive)
      return Array_Integer_4_Unsigned;
    function Get_Bytes(
      Name : in Integer_4_Unsigned)
      return Array_Integer_1_Unsigned;
    procedure Get_Clip_Plane(
      Plane    : in Integer_4_Unsigned;
      Equation : in Access_Float_8_Real);
    procedure Get_Double(
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_8_Real);
    function Get_Error
      return Integer_4_Unsigned;
    procedure Get_Float(
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_4_Real);
    procedure Get_Integer(
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Integer_4_Signed);
    procedure Get_Light(
      Light      : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_4_Real);
    procedure Get_Light(
      Light      : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Integer_4_Signed);
    procedure Get_Map(
      Target : in Integer_4_Unsigned;
      Query  : in Integer_4_Unsigned;
      V      : in Access_Float_8_Real);
    procedure Get_Map(
      Target : in Integer_4_Unsigned;
      Query  : in Integer_4_Unsigned;
      V      : in Access_Float_4_Real);
    procedure Get_Map(
      Target : in Integer_4_Unsigned;
      Query  : in Integer_4_Unsigned;
      V      : in Access_Integer_4_Signed);
    procedure Get_Material(
      Face       : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_4_Real);
    procedure Get_Material(
      Face       : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Integer_4_Signed);
    procedure Get_Pixel_Map(
      Map    : in Integer_4_Unsigned;
      Values : in Access_Float_4_Real);
    procedure Get_Pixel_Map(
      Map    : in Integer_4_Unsigned;
      Values : in Access_Integer_4_Unsigned);
    procedure Get_Pixel_Map(
      Map    : in Integer_4_Unsigned;
      Values : in Win32.PWSTR);
    procedure Get_Polygon_Stipple(
      Mask : in Access_Integer_1_Unsigned);
    function Get_String(
      Name : in Integer_4_Unsigned)
      return String_2;
    procedure Get_Texture_Environment(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_4_Real);
    procedure Get_Texture_Environment(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Integer_4_Signed);
    procedure Get_Texture_Generation(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_8_Real);
    procedure Get_Texture_Generation(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_4_Real);
    procedure Get_Texture_Generation(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Integer_4_Signed);
    procedure Get_Texture_Image(
      Target : in Integer_4_Unsigned;
      Level  : in Integer_4_Signed;
      Format : in Integer_4_Unsigned;
      Kind   : in Integer_4_Unsigned;
      Pixels : in PGLvoid);
    procedure Get_Texture_Level_Parameter(
      Target     : in Integer_4_Unsigned;
      Level      : in Integer_4_Signed;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_4_Real);
    procedure Get_Texture_Level_Parameter(
      Target : in Integer_4_Unsigned;
      Level  : in Integer_4_Signed;
      Name   : in Integer_4_Unsigned;
      Parameters : in Access_Integer_4_Signed);
    procedure Get_Texture_Parameter(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_4_Real);
    procedure Get_Texture_Parameter(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Integer_4_Signed);
    procedure Hint(
      Target : in Integer_4_Unsigned;
      Mode   : in Integer_4_Unsigned);
    procedure Index_Mask(
      Mask : in Integer_4_Unsigned);
    procedure Index(
      C : in Float_8_Real);
    procedure Index(
      C : in Access_Constant_Float_8_Real);
    procedure Index(
      C : in Float_4_Real);
    procedure Index(
      C : in Access_Constant_Float_4_Real);
    procedure Index(
      C : in Integer_4_Signed);
    procedure Index(
      C : in Access_Constant_Integer_4_Unsigned);
    procedure Index(
      C : in Integer_2_Signed);
    procedure Index(
      C : in Access_Constant_Integer_2_Signed);
    procedure Initialize_Names;
    function Is_Enabled(
      Cap : in Integer_4_Unsigned)
      return Integer_1_Unsigned;
    function Is_List(
      List : in Integer_4_Unsigned)
      return Integer_1_Unsigned;
    procedure Light_Model(
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real);
    procedure Light_Model(
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_4_Real);
    procedure Light_Model(
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed);
    procedure Light_Model(
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Integer_4_Unsigned);
    procedure Light(
      Light      : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real);
    procedure Light(
      Light      : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_4_Real);
    procedure Light(
      Light      : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed);
    procedure Light(
      Light      : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Integer_4_Unsigned);
    procedure Line_Stipple(
      Factor  : in Integer_4_Signed;
      Pattern : in Integer_2_Unsigned);
    procedure Line_Width(
      Width : in Float_4_Real);
    procedure List_Base(
      Base : in Integer_4_Unsigned);
    procedure Load_Identity;
    procedure Load_Matrix(
      M : in Access_Constant_Float_8_Real);
    procedure Load_Matrix(
      M : in Access_Constant_Float_4_Real);
    procedure Load_Name(
      Name : in Integer_4_Unsigned);
    procedure Logic_Operation(
      Operation_Code : in Integer_4_Unsigned);
    procedure Map(
      Target : in Integer_4_Unsigned;
      U_1    : in Float_8_Real;
      U_2    : in Float_8_Real;
      Stride : in Integer_4_Signed;
      Order  : in Integer_4_Signed;
      Points : in Access_Constant_Float_8_Real);
    procedure Map(
      Target : in Integer_4_Unsigned;
      U_1     : in Float_4_Real;
      U_2     : in Float_4_Real;
      Stride : in Integer_4_Signed;
      Order  : in Integer_4_Signed;
      Points : in Access_Constant_Float_4_Real);
    procedure Map(
      Target   : in Integer_4_Unsigned;
      U_1      : in Float_8_Real;
      U_2      : in Float_8_Real;
      U_Stride : in Integer_4_Signed;
      U_Order  : in Integer_4_Signed;
      V_1      : in Float_8_Real;
      V_2      : in Float_8_Real;
      V_Stride : in Integer_4_Signed;
      V_Order  : in Integer_4_Signed;
      Points   : in Access_Constant_Float_8_Real);
    procedure Map(
      Target   : in Integer_4_Unsigned;
      U_1      : in Float_4_Real;
      U_2      : in Float_4_Real;
      U_Stride : in Integer_4_Signed;
      U_Order  : in Integer_4_Signed;
      V_1      : in Float_4_Real;
      V_2      : in Float_4_Real;
      V_Stride : in Integer_4_Signed;
      V_Order  : in Integer_4_Signed;
      Points   : in Access_Constant_Float_4_Real);
    procedure Map_Grid(
      U_N : in Integer_4_Signed;
      U_1 : in Float_8_Real;
      U_2 : in Float_8_Real);
    procedure Map_Grid(
      U_N : in Integer_4_Signed;
      U_1 : in Float_4_Real;
      U_2 : in Float_4_Real);
    procedure Map_Grid(
      U_N : in Integer_4_Signed;
      U_1 : in Float_8_Real;
      U_2 : in Float_8_Real;
      V_N : in Integer_4_Signed;
      V_1 : in Float_8_Real;
      V_2 : in Float_8_Real);
    procedure Map_Grid(
      U_N : in Integer_4_Signed;
      U_1 : in Float_4_Real;
      U_2 : in Float_4_Real;
      V_N : in Integer_4_Signed;
      V_1 : in Float_4_Real;
      V_2 : in Float_4_Real);
    procedure Material(
      Face       : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real);
    procedure Material(
      Face       : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_4_Real);
    procedure Material(
      Face       : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed);
    procedure Material(
      Face       : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Integer_4_Signed);
    procedure Matrix_Mode(
      Mode : in Integer_4_Unsigned);
    procedure Multiply_Matrix(
      M : in Access_Constant_Float_8_Real);
    procedure Multiply_Matrix(
      M : in Access_Constant_Float_4_Real);
    procedure New_List(
      List : in Integer_4_Unsigned;
      Mode : in Integer_4_Unsigned);
    procedure Normal(
      N_X : in Integer_1_Unsigned;
      N_Y : in Integer_1_Unsigned;
      N_Z : in Integer_1_Unsigned);
    procedure Normal(
      V : in Win32.PCSTR);
    procedure Normal(
      N_X : in Float_8_Real;
      N_Y : in Float_8_Real;
      N_Z : in Float_8_Real);
    procedure Normal(
      V : in Access_Constant_Float_8_Real);
    procedure Normal(
      N_X : in Float_4_Real;
      N_Y : in Float_4_Real;
      N_Z : in Float_4_Real);
    procedure Normal(
      V : in Access_Constant_Float_4_Real);
    procedure Normal(
      N_X : in Integer_4_Signed;
      N_Y : in Integer_4_Signed;
      N_Z : in Integer_4_Signed);
    procedure Normal(
      V : in Access_Constant_Integer_4_Signed);
    procedure Normal(
      N_X : in Integer_2_Signed;
      N_Y : in Integer_2_Signed;
      N_Z : in Integer_2_Signed);
    procedure Normal(
      V : in Access_Constant_Integer_2_Signed);
    procedure Orthographic(
      Left   : in Float_8_Real;
      Right  : in Float_8_Real;
      Bottom : in Float_8_Real;
      Top    : in Float_8_Real;
      Z_Near : in Float_8_Real;
      Z_Far  : in Float_8_Real);
    procedure Pass_Through(
      Token : in Float_4_Real);
    procedure Pixel_Map(
      Map      : in Integer_4_Unsigned;
      Map_Size : in Integer_4_Signed;
      Values   : in Access_Constant_Float_4_Real);
    procedure Pixel_Map(
      Map      : in Integer_4_Unsigned;
      Map_Size : in Integer_4_Signed;
      Values   : in Access_Constant_Integer_4_Signed);
    procedure Pixel_Map(
      Map      : in Integer_4_Unsigned;
      Map_Size : in Integer_4_Signed;
      Values   : in Win32.PCWSTR);
    procedure Pixel_Store(
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real);
    procedure Pixel_Store(
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed);
    procedure Pixel_Transfer(
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real);
    procedure Pixel_Transfer(
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed);
    procedure Pixel_Zoom(
      X_Factor : in Float_4_Real;
      Y_Factor : in Float_4_Real);
    procedure Point_Size(
      Size : in Float_4_Real);
    procedure Polygon_Mode(
      Face : in Integer_4_Unsigned;
      Mode : in Integer_4_Unsigned);
    procedure Polygon_Stipple(
      Mask : in Access_Integer_1_Unsigned_C);
    procedure Pop_Attribute;
    procedure Pop_Client_Attribute;
    procedure Pop_Matrix;
    procedure Pop_Name;
    procedure Push_Attribute(
      Mask : in Integer_4_Unsigned);
    procedure Push_Matrix;
    procedure Push_Name(
      Name : in Integer_4_Unsigned);
    procedure Raster_Position(
      X : in Float_8_Real;
      Y : in Float_8_Real);
    procedure Raster_Position(
      V : in Access_Constant_Float_8_Real);
    procedure Raster_Position(
      X : in Float_4_Real;
      Y : in Float_4_Real);
    procedure Raster_Position(
      V : in Access_Constant_Float_4_Real);
    procedure Raster_Position(
      X : in Integer_4_Signed;
      Y : in Integer_4_Signed);
    procedure Raster_Position(
      V : in Access_Constant_Integer_4_Signed);
    procedure Raster_Position(
      X : in Integer_2_Signed;
      Y : in Integer_2_Signed);
    procedure Raster_Position(
      V : in Access_Constant_Integer_2_Signed);
    procedure Raster_Position(
      X : in Float_8_Real;
      Y : in Float_8_Real;
      Z : in Float_8_Real);
    procedure Raster_Position(
      V : in Access_Constant_Float_8_Real);
    procedure Raster_Position(
      X : in Float_4_Real;
      Y : in Float_4_Real;
      Z : in Float_4_Real);
    procedure Raster_Position(
      V : in Access_Constant_Float_4_Real);
    procedure Raster_Position(
      X : in Integer_4_Signed;
      Y : in Integer_4_Signed;
      Z : in Integer_4_Signed);
    procedure Raster_Position(
      V : in Access_Constant_Integer_4_Signed);
    procedure Raster_Position(
      X : in Integer_2_Signed;
      Y : in Integer_2_Signed;
      Z : in Integer_2_Signed);
    procedure Raster_Position(
      V : in Access_Constant_Integer_2_Signed);
    procedure Raster_Position(
      X : in Float_8_Real;
      Y : in Float_8_Real;
      Z : in Float_8_Real;
      W : in Float_8_Real);
    procedure Raster_Position(
      V : in Access_Constant_Float_8_Real);
    procedure Raster_Position(
      X : in Float_4_Real;
      Y : in Float_4_Real;
      Z : in Float_4_Real;
      W : in Float_4_Real);
    procedure Raster_Position(
      V : in Access_Constant_Float_4_Real);
    procedure Raster_Position(
      X : in Integer_4_Signed;
      Y : in Integer_4_Signed;
      Z : in Integer_4_Signed;
      W : in Integer_4_Signed);
    procedure Raster_Position(
      V : in Access_Constant_Integer_4_Signed);
    procedure Raster_Position(
      X : in Integer_2_Signed;
      Y : in Integer_2_Signed;
      Z : in Integer_2_Signed;
      W : in Integer_2_Signed);
    procedure Raster_Position(
      V : in Access_Constant_Integer_2_Signed);
    procedure Read_Buffer(
      Mode : in Integer_4_Unsigned);
    procedure Read_Pixels(
      X      : in Integer_4_Signed;
      Y      : in Integer_4_Signed;
      Width  : in Integer_4_Signed;
      Height : in Integer_4_Signed;
      Format : in Integer_4_Unsigned;
      Kind   : in Integer_4_Unsigned;
      Pixels : in PGLvoid);
    procedure Rectangle(
      X_1 : in Float_8_Real;
      Y_1 : in Float_8_Real;
      X_2 : in Float_8_Real;
      Y_2 : in Float_8_Real);
    procedure Rectangle(
      V_1 : in Access_Constant_Float_8_Real;
      V_2 : in Access_Constant_Float_8_Real);
    procedure Rectangle(
      X_1 : in Float_4_Real;
      Y_1 : in Float_4_Real;
      X_2 : in Float_4_Real;
      Y_2 : in Float_4_Real);
    procedure Rectangle(
      V_1 : in Access_Constant_Float_4_Real;
      V_2 : in Access_Constant_Float_4_Real);
    procedure Rectangle(
      X_1 : in Integer_4_Signed;
      Y_1 : in Integer_4_Signed;
      X_2 : in Integer_4_Signed;
      Y_2 : in Integer_4_Signed);
    procedure Rectangle(
      V_1 : in Access_Constant_Integer_4_Signed;
      V_2 : in Access_Constant_Integer_4_Signed);
    procedure Rectangle(
      X_1 : in Integer_2_Signed;
      Y_1 : in Integer_2_Signed;
      X_2 : in Integer_2_Signed;
      Y_2 : in Integer_2_Signed);
    procedure Rectangle(
      V_1 : in Access_Constant_Integer_2_Signed;
      V_2 : in Access_Constant_Integer_2_Signed);
    function Render_Mode(
      Mode : in Integer_4_Unsigned)
      return Integer_4_Signed;
    procedure Rotate(
      Angle : in Float_8_Real;
      X     : in Float_8_Real;
      Y     : in Float_8_Real;
      Z     : in Float_8_Real);
    procedure Rotate(
      Angle : in Float_4_Real;
      X     : in Float_4_Real;
      Y     : in Float_4_Real;
      Z     : in Float_4_Real);
    procedure Scale(
      X : in Float_8_Real;
      Y : in Float_8_Real;
      Z : in Float_8_Real);
    procedure Scale(
      X : in Float_4_Real;
      Y : in Float_4_Real;
      Z : in Float_4_Real);
    procedure Scissor(
      X      : in Integer_4_Signed;
      Y      : in Integer_4_Signed;
      Width  : in Integer_4_Signed;
      Height : in Integer_4_Signed);
    procedure Select_Buffer(
      Size   : in Integer_4_Signed;
      Buffer : in Access_Integer_4_Unsigned);
    procedure Shade_Model(
      Mode : in Integer_4_Unsigned);
    procedure Stencil_Function(
      Function  : in Integer_4_Unsigned;
      Reference : in Integer_4_Signed;
      Mask      : in Integer_4_Unsigned);
    procedure Stencil_Mask(
      Mask : in Integer_4_Unsigned);
    procedure Stencil_Operation(
      Fail   : in Integer_4_Unsigned;
      Z_Fail : in Integer_4_Unsigned;
      Z_Pass : in Integer_4_Unsigned);
    procedure Texture_Coordinate(
      S : in Float_8_Real);
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_8_Real);
    procedure Texture_Coordinate(
      S : in Float_4_Real);
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_4_Real);
    procedure Texture_Coordinate(
      S : in Integer_4_Signed);
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_4_Signed);
    procedure Texture_Coordinate(
      S : in Integer_2_Signed);
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_2_Signed);
    procedure Texture_Coordinate(
      S : in Float_8_Real;
      T : in Float_8_Real);
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_8_Real);
    procedure Texture_Coordinate(
      S : in Float_4_Real;
      T : in Float_4_Real);
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_4_Real);
    procedure Texture_Coordinate(
      S : in Integer_4_Signed;
      T : in Integer_4_Signed);
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_4_Signed);
    procedure Texture_Coordinate(
      S : in Integer_2_Signed;
      T : in Integer_2_Signed);
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_2_Signed);
    procedure Texture_Coordinate(
      S : in Float_8_Real;
      T : in Float_8_Real;
      R : in Float_8_Real);
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_8_Real);
    procedure Texture_Coordinate(
      S : in Float_4_Real;
      T : in Float_4_Real;
      R : in Float_4_Real);
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_4_Real);
    procedure Texture_Coordinate(
      S : in Integer_4_Signed;
      T : in Integer_4_Signed;
      R : in Integer_4_Signed);
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_4_Signed);
    procedure Texture_Coordinate(
      S : in Integer_2_Signed;
      T : in Integer_2_Signed;
      R : in Integer_2_Signed);
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_2_Signed);
    procedure Texture_Coordinate(
      S : in Float_8_Real;
      T : in Float_8_Real;
      R : in Float_8_Real;
      Q : in Float_8_Real);
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_8_Real);
    procedure Texture_Coordinate(
      S : in Float_4_Real;
      T : in Float_4_Real;
      R : in Float_4_Real;
      Q : in Float_4_Real);
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_4_Real);
    procedure Texture_Coordinate(
      S : in Integer_4_Signed;
      T : in Integer_4_Signed;
      R : in Integer_4_Signed;
      Q : in Integer_4_Signed);
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_4_Signed);
    procedure Texture_Coordinate(
      S : in Integer_2_Signed;
      T : in Integer_2_Signed;
      R : in Integer_2_Signed;
      Q : in Integer_2_Signed);
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_2_Signed);
    procedure Texture_Environment(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real);
    procedure Texture_Environment(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_4_Real);
    procedure Texture_Environment(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed);
    procedure Texture_Environment(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Integer_4_Signed);
    procedure Texture_Generate(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_8_Real);
    procedure Texture_Generate(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_8_Real);
    procedure Texture_Generate(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real);
    procedure Texture_Generate(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_4_Real);
    procedure Texture_Generate(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed);
    procedure Texture_Generate(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Integer_4_Signed);
    procedure Texture_Image_1D(
      Target     : in Integer_4_Unsigned;
      level      : in Integer_4_Signed;
      Components : in Integer_4_Signed;
      Width      : in Integer_4_Signed;
      Border     : in Integer_4_Signed;
      Format     : in Integer_4_Unsigned;
      Kind       : in Integer_4_Unsigned;
      Pixels     : in Win32.PCVOID);
    procedure Texture_Image_2D(
      Target     : in Integer_4_Unsigned;
      level      : in Integer_4_Signed;
      Components : in Integer_4_Signed;
      Width      : in Integer_4_Signed;
      Height     : in Integer_4_Signed;
      Border     : in Integer_4_Signed;
      Format     : in Integer_4_Unsigned;
      Kind       : in Integer_4_Unsigned;
      Pixels     : in Win32.PCVOID);
    procedure Texture_Parameter(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real);
    procedure Texture_Parameter(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_4_Real);
    procedure Texture_Parameter(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed);
    procedure Texture_Parameter(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Integer_4_Signed);
    procedure Translate(
      X : in Float_8_Real;
      Y : in Float_8_Real;
      Z : in Float_8_Real);
    procedure Translate(
      X : in Float_4_Real;
      Y : in Float_4_Real;
      Z : in Float_4_Real);
    procedure Vertex(
      X : in Float_8_Real;
      Y : in Float_8_Real);
    procedure Vertex(
      V : in Access_Constant_Float_8_Real);
    procedure Vertex(
      X : in Float_4_Real;
      Y : in Float_4_Real);
    procedure Vertex(
      V : in Access_Constant_Float_4_Real);
    procedure Vertex(
      X : in Integer_4_Signed;
      Y : in Integer_4_Signed);
    procedure Vertex(
      V : in Access_Constant_Integer_4_Signed);
    procedure Vertex(
      X : in Integer_2_Signed;
      Y : in Integer_2_Signed);
    procedure Vertex(
      V : in Access_Constant_Integer_2_Signed);
    procedure Vertex(
      X : in Float_8_Real;
      Y : in Float_8_Real;
      Z : in Float_8_Real);
    procedure Vertex(
      V : in Access_Constant_Float_8_Real);
    procedure Vertex(
      X : in Float_4_Real;
      Y : in Float_4_Real;
      Z : in Float_4_Real);
    procedure Vertex(
      V : in Access_Constant_Float_4_Real);
    procedure Vertex(
      X : in Integer_4_Signed;
      Y : in Integer_4_Signed;
      Z : in Integer_4_Signed);
    procedure Vertex(
      V : in Access_Constant_Integer_4_Signed);
    procedure Vertex(
      X : in Integer_2_Signed;
      Y : in Integer_2_Signed;
      Z : in Integer_2_Signed);
    procedure Vertex(
      V : in Access_Constant_Integer_2_Signed);
    procedure Vertex(
      X : in Float_8_Real;
      Y : in Float_8_Real;
      Z : in Float_8_Real;
      W : in Float_8_Real);
    procedure Vertex(
      V : in Access_Constant_Float_8_Real);
    procedure Vertex(
      X : in Float_4_Real;
      Y : in Float_4_Real;
      Z : in Float_4_Real;
      W : in Float_4_Real);
    procedure Vertex(
      V : in Access_Constant_Float_4_Real);
    procedure Vertex(
      X : in Integer_4_Signed;
      Y : in Integer_4_Signed;
      Z : in Integer_4_Signed;
      W : in Integer_4_Signed);
    procedure Vertex(
      V : in Access_Constant_Integer_4_Signed);
    procedure Vertex(
      X : in Integer_2_Signed;
      Y : in Integer_2_Signed;
      Z : in Integer_2_Signed;
      W : in Integer_2_Signed);
    procedure Vertex(
      V : in Access_Constant_Integer_2_Signed);
    procedure Viewport(
      X      : in Integer_4_Signed;
      Y      : in Integer_4_Signed;
      Width  : in Integer_4_Signed;
      Height : in Integer_4_Signed);
  ---------------
  -- Variables --
  ---------------
    glAccum                  : Access_Procedure_ := null;
    glAlphaFunc              : Access_Procedure_ := null;
    glAreTexturesResident    : Access_Procedure_ := null;
    glArrayElement           : Access_Procedure_ := null;
    glBegin                  : Access_Procedure_ := null;
    glBindTexture            : Access_Procedure_ := null;
    glBitmap                 : Access_Procedure_ := null;
    glBlendFunc              : Access_Procedure_ := null;
    glCallList               : Access_Procedure_ := null;
    glCallLists              : Access_Procedure_ := null;
    glClear                  : Access_Procedure_ := null;
    glClearAccum             : Access_Procedure_ := null;
    glClearColor             : Access_Procedure_ := null;
    glClearDepth             : Access_Procedure_ := null;
    glClearIndex             : Access_Procedure_ := null;
    glClearStencil           : Access_Procedure_ := null;
    glClipPlane              : Access_Procedure_ := null;
    glColor3b                : Access_Procedure_ := null;
    glColor3bv               : Access_Procedure_ := null;
    glColor3d                : Access_Procedure_ := null;
    glColor3dv               : Access_Procedure_ := null;
    glColor3f                : Access_Procedure_ := null;
    glColor3fv               : Access_Procedure_ := null;
    glColor3i                : Access_Procedure_ := null;
    glColor3iv               : Access_Procedure_ := null;
    glColor3s                : Access_Procedure_ := null;
    glColor3sv               : Access_Procedure_ := null;
    glColor3ub               : Access_Procedure_ := null;
    glColor3ubv              : Access_Procedure_ := null;
    glColor3ui               : Access_Procedure_ := null;
    glColor3uiv              : Access_Procedure_ := null;
    glColor3us               : Access_Procedure_ := null;
    glColor3usv              : Access_Procedure_ := null;
    glColor4b                : Access_Procedure_ := null;
    glColor4bv               : Access_Procedure_ := null;
    glColor4d                : Access_Procedure_ := null;
    glColor4dv               : Access_Procedure_ := null;
    glColor4f                : Access_Procedure_ := null;
    glColor4fv               : Access_Procedure_ := null;
    glColor4i                : Access_Procedure_ := null;
    glColor4iv               : Access_Procedure_ := null;
    glColor4s                : Access_Procedure_ := null;
    glColor4sv               : Access_Procedure_ := null;
    glColor4ub               : Access_Procedure_ := null;
    glColor4ubv              : Access_Procedure_ := null;
    glColor4ui               : Access_Procedure_ := null;
    glColor4uiv              : Access_Procedure_ := null;
    glColor4us               : Access_Procedure_ := null;
    glColor4usv              : Access_Procedure_ := null;
    glColorMask              : Access_Procedure_ := null;
    glColorMaterial          : Access_Procedure_ := null;
    glColorPointer           : Access_Procedure_ := null;
    glCopyPixels             : Access_Procedure_ := null;
    glCopyTexImage1D         : Access_Procedure_ := null;
    glCopyTexImage2D         : Access_Procedure_ := null;
    glCopyTexSubImage1D      : Access_Procedure_ := null;
    glCopyTexSubImage2D      : Access_Procedure_ := null;
    glCullFace               : Access_Procedure_ := null;
    glDeleteLists            : Access_Procedure_ := null;
    glDeleteTextures         : Access_Procedure_ := null;
    glDepthFunc              : Access_Procedure_ := null;
    glDepthMask              : Access_Procedure_ := null;
    glDepthRange             : Access_Procedure_ := null;
    glDisable                : Access_Procedure_ := null;
    glDisableClientState     : Access_Procedure_ := null;
    glDrawArrays             : Access_Procedure_ := null;
    glDrawBuffer             : Access_Procedure_ := null;
    glDrawElements           : Access_Procedure_ := null;
    glDrawPixels             : Access_Procedure_ := null;
    glEdgeFlag               : Access_Procedure_ := null;
    glEdgeFlagPointer        : Access_Procedure_ := null;
    glEdgeFlagv              : Access_Procedure_ := null;
    glEnable                 : Access_Procedure_ := null;
    glEnableClientState      : Access_Procedure_ := null;
    glEnd                    : Access_Procedure_ := null;
    glEndList                : Access_Procedure_ := null;
    glEvalCoord1d            : Access_Procedure_ := null;
    glEvalCoord1dv           : Access_Procedure_ := null;
    glEvalCoord1f            : Access_Procedure_ := null;
    glEvalCoord1fv           : Access_Procedure_ := null;
    glEvalCoord2d            : Access_Procedure_ := null;
    glEvalCoord2dv           : Access_Procedure_ := null;
    glEvalCoord2f            : Access_Procedure_ := null;
    glEvalCoord2fv           : Access_Procedure_ := null;
    glEvalMesh1              : Access_Procedure_ := null;
    glEvalMesh2              : Access_Procedure_ := null;
    glEvalPoint1             : Access_Procedure_ := null;
    glEvalPoint2             : Access_Procedure_ := null;
    glFeedbackBuffer         : Access_Procedure_ := null;
    glFinish                 : Access_Procedure_ := null;
    glFlush                  : Access_Procedure_ := null;
    glFogf                   : Access_Procedure_ := null;
    glFogfv                  : Access_Procedure_ := null;
    glFogi                   : Access_Procedure_ := null;
    glFogiv                  : Access_Procedure_ := null;
    glFrontFace              : Access_Procedure_ := null;
    glFrustum                : Access_Procedure_ := null;
    glGenLists               : Access_Procedure_ := null;
    glGenTextures            : Access_Procedure_ := null;
    glGetBooleanv            : Access_Procedure_ := null;
    glGetClipPlane           : Access_Procedure_ := null;
    glGetDoublev             : Access_Procedure_ := null;
    glGetError               : Access_Procedure_ := null;
    glGetFloatv              : Access_Procedure_ := null;
    glGetIntegerv            : Access_Procedure_ := null;
    glGetLightfv             : Access_Procedure_ := null;
    glGetLightiv             : Access_Procedure_ := null;
    glGetMapdv               : Access_Procedure_ := null;
    glGetMapfv               : Access_Procedure_ := null;
    glGetMapiv               : Access_Procedure_ := null;
    glGetMaterialfv          : Access_Procedure_ := null;
    glGetMaterialiv          : Access_Procedure_ := null;
    glGetPixelMapfv          : Access_Procedure_ := null;
    glGetPixelMapuiv         : Access_Procedure_ := null;
    glGetPixelMapusv         : Access_Procedure_ := null;
    glGetPointerb            : Access_Procedure_ := null;
    glGetPolygonStipple      : Access_Procedure_ := null;
    glGetString              : Access_Procedure_ := null;
    glGetTexEnvfv            : Access_Procedure_ := null;
    glGetTexEnviv            : Access_Procedure_ := null;
    glGetTexGendv            : Access_Procedure_ := null;
    glGetTexGenfv            : Access_Procedure_ := null;
    glGetTexGeniv            : Access_Procedure_ := null;
    glGetTexImage            : Access_Procedure_ := null;
    glGetTexLevelParameterfv : Access_Procedure_ := null;
    glGetTexLevelParameteriv : Access_Procedure_ := null;
    glGetTexParameterfv      : Access_Procedure_ := null;
    glGetTexParameteriv      : Access_Procedure_ := null;
    glHint                   : Access_Procedure_ := null;
    glIndexMask              : Access_Procedure_ := null;
    glIndexPointer           : Access_Procedure_ := null;
    glIndexd                 : Access_Procedure_ := null;
    glIndexdv                : Access_Procedure_ := null;
    glIndexf                 : Access_Procedure_ := null;
    glIndexfv                : Access_Procedure_ := null;
    glIndexi                 : Access_Procedure_ := null;
    glIndexiv                : Access_Procedure_ := null;
    glIndexs                 : Access_Procedure_ := null;
    glIndexsv                : Access_Procedure_ := null;
    glIndexub                : Access_Procedure_ := null;
    glIndexubv               : Access_Procedure_ := null;
    glInitNames              : Access_Procedure_ := null;
    glInterleavedArrays      : Access_Procedure_ := null;
    glIsEnabled              : Access_Procedure_ := null;
    glIsList                 : Access_Procedure_ := null;
    glIsTexture              : Access_Procedure_ := null;
    glLightModelf            : Access_Procedure_ := null;
    glLightModelfv           : Access_Procedure_ := null;
    glLightModeli            : Access_Procedure_ := null;
    glLightModeliv           : Access_Procedure_ := null;
    glLightf                 : Access_Procedure_ := null;
    glLightfv                : Access_Procedure_ := null;
    glLighti                 : Access_Procedure_ := null;
    glLightiv                : Access_Procedure_ := null;
    glLineStipple            : Access_Procedure_ := null;
    glLineWidth              : Access_Procedure_ := null;
    glListBase               : Access_Procedure_ := null;
    glLoadIdentity           : Access_Procedure_ := null;
    glLoadMatrixd            : Access_Procedure_ := null;
    glLoadMatrixf            : Access_Procedure_ := null;
    glLoadName               : Access_Procedure_ := null;
    glLogicOp                : Access_Procedure_ := null;
    glMap1D                  : Access_Procedure_ := null;
    glMap1f                  : Access_Procedure_ := null;
    glMap2D                  : Access_Procedure_ := null;
    glMap2f                  : Access_Procedure_ := null;
    glMapGrid1d              : Access_Procedure_ := null;
    glMapGrid1f              : Access_Procedure_ := null;
    glMapGrid2d              : Access_Procedure_ := null;
    glMapGrid2f              : Access_Procedure_ := null;
    glMaterialf              : Access_Procedure_ := null;
    glMaterialfv             : Access_Procedure_ := null;
    glMateriali              : Access_Procedure_ := null;
    glMaterialiv             : Access_Procedure_ := null;
    glMatrixMode             : Access_Procedure_ := null;
    glMultMatrixd            : Access_Procedure_ := null;
    glMultMatrixf            : Access_Procedure_ := null;
    glNewList                : Access_Procedure_ := null;
    glNormal3b               : Access_Procedure_ := null;
    glNormal3Bv              : Access_Procedure_ := null;
    glNormal3D               : Access_Procedure_ := null;
    glNormal3Dv              : Access_Procedure_ := null;
    glNormal3f               : Access_Procedure_ := null;
    glNormal3fv              : Access_Procedure_ := null;
    glNormal3i               : Access_Procedure_ := null;
    glNormal3iv              : Access_Procedure_ := null;
    glNormal3s               : Access_Procedure_ := null;
    glNormal3sv              : Access_Procedure_ := null;
    glNormalPointer          : Access_Procedure_ := null;
    glOrtho                  : Access_Procedure_ := null;
    glPassThrough            : Access_Procedure_ := null;
    glPixelMapfv             : Access_Procedure_ := null;
    glPixelMapuiv            : Access_Procedure_ := null;
    glPixelMapusv            : Access_Procedure_ := null;
    glPixelStoref            : Access_Procedure_ := null;
    glPixelStorei            : Access_Procedure_ := null;
    glPixelTransferf         : Access_Procedure_ := null;
    glPixelTransferi         : Access_Procedure_ := null;
    glPixelZoom              : Access_Procedure_ := null;
    glPointSize              : Access_Procedure_ := null;
    glPolygonMode            : Access_Procedure_ := null;
    glPolygonOffset          : Access_Procedure_ := null;
    glPolygonStipple         : Access_Procedure_ := null;
    glPopAttrib              : Access_Procedure_ := null;
    glPopClientAttrib        : Access_Procedure_ := null;
    glPopMatrix              : Access_Procedure_ := null;
    glPopName                : Access_Procedure_ := null;
    glPrioritizeTextures     : Access_Procedure_ := null;
    glPushAttrib             : Access_Procedure_ := null;
    glPushClientAttrib       : Access_Procedure_ := null;
    glPushMatrix             : Access_Procedure_ := null;
    glPushName               : Access_Procedure_ := null;
    glRasterPos2D            : Access_Procedure_ := null;
    glRasterPos2Dv           : Access_Procedure_ := null;
    glRasterPos2f            : Access_Procedure_ := null;
    glRasterPos2fv           : Access_Procedure_ := null;
    glRasterPos2i            : Access_Procedure_ := null;
    glRasterPos2iv           : Access_Procedure_ := null;
    glRasterPos2s            : Access_Procedure_ := null;
    glRasterPos2sv           : Access_Procedure_ := null;
    glRasterPos3d            : Access_Procedure_ := null;
    glRasterPos3dv           : Access_Procedure_ := null;
    glRasterPos3f            : Access_Procedure_ := null;
    glRasterPos3fv           : Access_Procedure_ := null;
    glRasterPos3i            : Access_Procedure_ := null;
    glRasterPos3iv           : Access_Procedure_ := null;
    glRasterPos3s            : Access_Procedure_ := null;
    glRasterPos3sv           : Access_Procedure_ := null;
    glRasterPos4d            : Access_Procedure_ := null;
    glRasterPos4dv           : Access_Procedure_ := null;
    glRasterPos4f            : Access_Procedure_ := null;
    glRasterPos4fv           : Access_Procedure_ := null;
    glRasterPos4i            : Access_Procedure_ := null;
    glRasterPos4iv           : Access_Procedure_ := null;
    glRasterPos4s            : Access_Procedure_ := null;
    glRasterPos4sv           : Access_Procedure_ := null;
    glReadBuffer             : Access_Procedure_ := null;
    glReadPixels             : Access_Procedure_ := null;
    glRectd                  : Access_Procedure_ := null;
    glRectdv                 : Access_Procedure_ := null;
    glRectf                  : Access_Procedure_ := null;
    glRectfv                 : Access_Procedure_ := null;
    glRecti                  : Access_Procedure_ := null;
    glRectiv                 : Access_Procedure_ := null;
    glRects                  : Access_Procedure_ := null;
    glRectsv                 : Access_Procedure_ := null;
    glRenderMode             : Access_Procedure_ := null;
    glRotated                : Access_Procedure_ := null;
    glRotatef                : Access_Procedure_ := null;
    glScaled                 : Access_Procedure_ := null;
    glScalef                 : Access_Procedure_ := null;
    glScissor                : Access_Procedure_ := null;
    glSelectBuffer           : Access_Procedure_ := null;
    glShadeModel             : Access_Procedure_ := null;
    glStencilFunc            : Access_Procedure_ := null;
    glStencilMask            : Access_Procedure_ := null;
    glStencilOp              : Access_Procedure_ := null;
    glTexCoord1d             : Access_Procedure_ := null;
    glTexCoord1dv            : Access_Procedure_ := null;
    glTexCoord1f             : Access_Procedure_ := null;
    glTexCoord1fv            : Access_Procedure_ := null;
    glTexCoord1i             : Access_Procedure_ := null;
    glTexCoord1iv            : Access_Procedure_ := null;
    glTexCoord1s             : Access_Procedure_ := null;
    glTexCoord1sv            : Access_Procedure_ := null;
    glTexCoord2d             : Access_Procedure_ := null;
    glTexCoord2dv            : Access_Procedure_ := null;
    glTexCoord2f             : Access_Procedure_ := null;
    glTexCoord2fv            : Access_Procedure_ := null;
    glTexCoord2i             : Access_Procedure_ := null;
    glTexCoord2iv            : Access_Procedure_ := null;
    glTexCoord2s             : Access_Procedure_ := null;
    glTexCoord2sv            : Access_Procedure_ := null;
    glTexCoord3d             : Access_Procedure_ := null;
    glTexCoord3dv            : Access_Procedure_ := null;
    glTexCoord3f             : Access_Procedure_ := null;
    glTexCoord3fv            : Access_Procedure_ := null;
    glTexCoord3i             : Access_Procedure_ := null;
    glTexCoord3iv            : Access_Procedure_ := null;
    glTexCoord3s             : Access_Procedure_ := null;
    glTexCoord3dv            : Access_Procedure_ := null;
    glTexCoord4d             : Access_Procedure_ := null;
    glTexCoord4dv            : Access_Procedure_ := null;
    glTexCoord4f             : Access_Procedure_ := null;
    glTexCoord4fv            : Access_Procedure_ := null;
    glTexCoord4i             : Access_Procedure_ := null;
    glTexCoord4iv            : Access_Procedure_ := null;
    glTexCoord4d             : Access_Procedure_ := null;
    glTexCoord4dv            : Access_Procedure_ := null;
    glTexCoordPointer        : Access_Procedure_ := null;
    glTexEnvf                : Access_Procedure_ := null;
    glTexEnvfv               : Access_Procedure_ := null;
    glTexEnvi                : Access_Procedure_ := null;
    glTexEnviv               : Access_Procedure_ := null;
    glTexGend                : Access_Procedure_ := null;
    glTexGendv               : Access_Procedure_ := null;
    glTexGenf                : Access_Procedure_ := null;
    glTexGenfv               : Access_Procedure_ := null;
    glTexGeni                : Access_Procedure_ := null;
    glTexGeniv               : Access_Procedure_ := null;
    glTexImage1D             : Access_Procedure_ := null;
    glTexImage2D             : Access_Procedure_ := null;
    glTexParameterf          : Access_Procedure_ := null;
    glTexParameterfv         : Access_Procedure_ := null;
    glTexParameteri          : Access_Procedure_ := null;
    glTexParameteriv         : Access_Procedure_ := null;
    glTexSubImage1D          : Access_Procedure_ := null;
    glTexSubImage2D          : Access_Procedure_ := null;
    glTranslated             : Access_Procedure_ := null;
    glTranslatef             : Access_Procedure_ := null;
    glVertex2d               : Access_Procedure_ := null;
    glVertex2dv              : Access_Procedure_ := null;
    glVertex2f               : Access_Procedure_ := null;
    glVertex2fv              : Access_Procedure_ := null;
    glVertex2i               : Access_Procedure_ := null;
    glVertex2iv              : Access_Procedure_ := null;
    glVertex2s               : Access_Procedure_ := null;
    glVertex2sv              : Access_Procedure_ := null;
    glVertex3d               : Access_Procedure_ := null;
    glVertex3dv              : Access_Procedure_ := null;
    glVertex3f               : Access_Procedure_ := null;
    glVertex3fv              : Access_Procedure_ := null;
    glVertex3i               : Access_Procedure_ := null;
    glVertex3iv              : Access_Procedure_ := null;
    glVertex3s               : Access_Procedure_ := null;
    glVertex3sv              : Access_Procedure_ := null;
    glVertex4d               : Access_Procedure_ := null;
    glVertex4dv              : Access_Procedure_ := null;
    glVertex4f               : Access_Procedure_ := null;
    glVertex4fv              : Access_Procedure_ := null;
    glVertex4i               : Access_Procedure_ := null;
    glVertex4iv              : Access_Procedure_ := null;
    glVertex4s               : Access_Procedure_ := null;
    glVertex4sv              : Access_Procedure_ := null;
    glVertexPointer          : Access_Procedure_ := null;

  ---------------------------
  -- Operation_To_String_2 --
  ---------------------------
    function Operation_To_String_2(
      Operation : in Integer_4_Unsigned)
      return String_2
      is
      begin
        case Operation is
          when 0 =>
            return "";
          when others =>
            return "";
        end case;
      end Operation_To_String_2;
  ----------------
  -- To_Boolean --
  ----------------
    function To_Boolean(
      Item : in Integer_1_Unsigned_C)
      return Boolean
      is
        if Item = GL_TRUE then
          return True;
        else
          return False;
        end if;
      begin
      end To_Boolean;
  -----------------------------
  -- To_Integer_1_Unsigned_C --
  -----------------------------
    function To_Integer_1_Unsigned_C(
      Item : in Boolean)
      return Integer_1_Unsigned_C
      is
      begin
        if Item then
          return GL_TRUE;
        else
          return GL_FALSE;
        end if;
      end To_Integer_1_Unsigned_C;
  -----------------------------------
  -- To_Array_Integer_1_Unsigned_C --
  -----------------------------------
    function To_Array_Integer_1_Unsigned_C(
      Item : in Array_Boolean)
      return Array_Integer_1_Unsigned_C
      is
      Output : Array_Integer_1_Unsigned_C(Item'first..Item'Length);
      begin
        for I in range(Item'first..Item'Length) loop
          Output(I) := To_Integer_1_Unsigned_C(Item(I));
        end loop;
        return Output;
      end To_Array_Integer_1_Unsigned_C;
  -----------------------------------
  -- To_Array_Integer_1_Unsigned_C --
  -----------------------------------
    function To_Array_Integer_1_Unsigned_C(
      Item : in Array_Integer_1_Unsigned)
      return Array_Integer_1_Unsigned_C
      is
      Output : Array_Integer_1_Unsigned_C(Item'first .. Item'last);
      begin
        for I in range(Item'first .. Item'last) loop
          Output(I) := Integer_1_Unsigned_C(Item(I));
        end loop;
        return Output;
      end To_Array_Integer_1_Unsigned_C;
  ---------------------------------
  -- To_Array_Integer_1_Unsigned --
  ---------------------------------
    function To_Array_Integer_1_Unsigned(
      Item : in Array_Integer_1_Unsigned_C)
      return Array_Integer_1_Unsigned
      is
      Output : Array_Integer_1_Unsigned(Item'first .. Item'last);
      begin
        for I in range(Item'first .. Item'last) loop
          Output(I) := Integer_1_Unsigned(Item(I));
        end loop;
        return Output;
      end To_Array_Integer_1_Unsigned;
  ----------------------
  -- To_Array_Boolean --
  ----------------------
    function To_Array_Boolean(
      Item : in Array_Integer_1_Unsigned_C)
      return Array_Boolean
      is
      Output : Array_Boolean(Item'first..Item'last);
      begin
        for I in range(Item'first..Item'last) loop
          Output(I) := To_Boolean(Item(I));
        end loop;
        return Output;
      end To_Array_Boolean;
  ---------------------------
  -- To_Array_Float_4_Real --
  ---------------------------
    function To_Array_Float_4_Real(
      Item : in Array_Float_4_Real_C)
      return Array_Float_4_Real
      is
      Output : Array_Float_4_Real(Item'first..Item'last);
      begin
        for I in range(Item'first..Item'last) loop
          Output(I) := Float_4_Real(Item(I));
        end loop;
        return Output;
      end To_Array_Float_4_Real;
  ----------------
  -- Accumulate --
  ----------------
    procedure Accumulate(
      Operation : in Integer_4_Unsigned;
      Value     : in Float_4_Real)
      is
      begin
        if glAccum = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glAccum"                        & "( " &
          Operation_To_String_2(Operation) & ", " &
          Float_4_Real'Wide_Image(Value)   & " )" );
        glAccum.All(
          Integer_4_Unsigned_C(Operation),
          Float_4_Real_C(Value));
      end if;
  --------------------
  -- Alpha_Function --
  --------------------
    procedure Alpha_Function(
      Operation : in Integer_4_Unsigned;
      Referece  : in Float_4_Real)
      is
      begin
        if glAlphaFunc = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glAlphaFunc"          & "( " &
          To_String_2(Operation) & ", " &
          Float_4_Real(Value)    & " )" );
        glAlphaFunc.All(
          Integer_4_Unsigned_C(Operation),
          Float_4_Real_C(Reference));
      end Alpha_Function;
  ---------------------------
  -- Are_Textures_Resident --
  ---------------------------
    function Are_Textures_Resident(
      Textures   : in Array_Integer_4_Unsigned_C
      Residences : in Access_Array_Boolean)
      return Boolean
      is
      Residences_C : Array_Integer_1_Unsigned_C(Residences'first .. Residences'last) := To_Array_Integer_1_Unsigned_C(Residences.All);
      Output       : Boolean                                                         := 0;
      begin
        if glAreTexturesResident = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glAreTexturesResident"                              & "( " &
          Natural'Wide_Image(Textures'Length)                  & ", " &
          "'const GLuint * textures' 'GLboolean * residences'" & " )" );
        Output := To_Boolean(glAreTexturesResident.All(
          Integer_4_Unsigned_C(Textures'Length),
          Textures'address,
          Residences_C'address));
        Residences.All := To_Array_Boolean(Residences_C);
        return Output;
      end Are_Textures_Resident;
  -------------------
  -- Array_Element --
  -------------------
    procedure Array_Element(
      Index : Integer_4_Signed);
      is
      begin
        if glArrayElement = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glArrayElement"                   & "( " &
          Integer_4_Signed'Wide_Image(Index) & " )" );
        glArrayElement.All(
          Integer_4_Signed_C(Index));
      end Array_Element;
  -------------------
  -- Begin_Drawing --
  -------------------
    procedure Begin_Drawing(
      Mode : in Integer_4_Unsigned)
      is
      begin
        if glBegin = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glBegin"            & "( " &
          Get_String.all(Mode) & " )" );
        glBegin.all(
          Integer_4_Unsigned_C(Mode));
      end Begin_Drawing;
  ------------------
  -- Bind_Texture --
  ------------------
    procedure Bind_Texture(
      Target  : in Integer_4_Unsigned
      Texture : in Integer_4_Unsigned)
      is
      begin
        if glBindTexture = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glBindTexture"               & "( " &
          Get_String(Target)            & ", " &
          Integer_4_Unsigned_C(Texture) & " )" );
        glBindTexture.All(
          Integer_4_Unsigned_C(Target),
          Integer_ 4_Unsigned_C(Texture);
      end Bind_Texture;
  ------------
  -- Bitmap --
  ------------
    procedure Bitmap(
      Width    : in Integer_4_Signed;
      Height   : in Integer_4_Signed;
      X_Origin : in Float_4_Real;
      Y_Origin : in Float_4_Real;
      X_Move   : in Float_4_Real;
      Y_Move   : in Float_4_Real;
      Bitmap   : in Array_Integer_1_Unsigned)
      is
      begin
        if glBitmap = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glBitmap"                          & "( " &
          Integer_4_Singed'Wide_Image(Width)  & ", " &
          Integer_4_Singed'Wide_Image(Height) & ", " &
          Float_4_Real'Wide_Image(X_Origin)   & ", " &
          Float_4_Real'Wide_Image(Y_Origin)   & ", " &
          Float_4_Real'Wide_Image(X_Move)     & ", " &
          Float_4_Real'Wide_Image(Y_Move)     & ", " &
          "const GLubyte * bitmap"            & " )" );
        glBitmap.All(
          Integer_4_Unsigned_C(Width),
          Integer_4_Unsigned_C(Height),
          Integer_4_Unsigned_C(X_Origin),
          Integer_4_Unsigned_C(Y_Origin),
          Integer_4_Unsigned_C(X_Move),
          Integer_4_Unsigned_C(Y_Move),
          Bitmap'address);
      end Bitmap;
  --------------------
  -- Blend_Function --
  --------------------
    procedure Blend_Function(
      S_Factor : in Integer_4_Unsigned;
      D_Factor : in Integer_4_Unsigned)
      is
      begin
        if glBlendFunc = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glBlendFunc"        & "( " &
          Get_String(S_Factor) & ", " &
          Get_String(D_Factor) & " )" );
        glBlendFunc.All(
          Integer_4_Unsigned_C(S_Factor),
          Integer_4_Unsigned_C(D_Factor));
      end Blend_Function;
  ---------------
  -- Call_List --
  ---------------
    procedure Call_List(
      List : in Integer_4_Unsigned)
      is
      begin
        if glCallList = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glCallList" & "( " &
          Integer_4_Unsigned(List));
        glCallList.All(
          Integer_4_Unsigned_C(List));
      end Call_List;
  ----------------
  -- Call_Lists --
  ----------------
    procedure Call_Lists(
      Number   : in Integer_4_Signed;
      Grouping : in Integer_4_Unsigned := GL_UNSIGNED_BYTE;
      Lists    : in Array_Integer_1_Unsigned)
      is
      begin
        if glCallLists = null then
          raise Call_Failure;
        end if;
        if Grouping /= GL_UNSIGNED_BYTE or
           Grouping /= GL_2_BYTES       or
           Grouping /= GL_3_BYTES       or
           Grouping /= GL_4_BYTES       then
          raise Call_Failure;
        end if;
        Put_Line(
          "glCallLists"                         & "( " &
          Integer_4_Signed_C'Wide_Image(Number) & ", " &
          Get_String(Grouping)                  & ", " &
          "'const GLvoid * lists'"              & " )" );
        glCallLists.All(
          Integer_4_Signed_C(Number),
          Integer_4_Unsigned_C(Pairing),
          Lists'address);
      end Call_Lists;
    procedure Call_Lists(
      Number : in Integer_4_Signed;
      Lists  : in Array_Integer_2_Unsigned)
      is
      begin
        if glCallLists = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glCallLists"                         & "( " &
          Integer_4_Signed_C'Wide_Image(Number) & ", " &
          Get_String(GL_UNSIGNED_SHORT)         & ", " &
          "'const GLvoid * lists'"              & " )" );
        glCallLists.All(
          Integer_4_Signed_C(Number),
          Integer_4_Unsigned_C(GL_UNSIGNED_SHORT)),
          Lists'address);
      end Call_Lists;
    procedure Call_Lists(
      Number : in Integer_4_Signed;
      Lists  : in Array_Integer_4_Unsigned)
      is
      begin
        if glCallLists = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glCallLists"                         & "( " &
          Integer_4_Signed_C'Wide_Image(Number) & ", " &
          Get_String(GL_UNSIGNED_INT)           & ", " &
          "'const GLvoid * lists'"              & " )" );
        glCallLists.All(
          Integer_4_Signed_C(Number),
          Integer_4_Unsigned_C(GL_UNSIGNED_INT)),
          Lists'address);
      end Call_Lists;
    procedure Call_Lists(
      Number : in Integer_4_Signed;
      Lists  : in Array_Integer_1_Signed)
      is
      begin
        if glCallLists = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glCallLists"                         & "( " &
          Integer_4_Signed_C'Wide_Image(Number) & ", " &
          Get_String(GL_BYTE)                   & ", " &
          "'const GLvoid * lists'"              & " )" );
        glCallLists.All(
          Integer_4_Signed_C(Number),
          Integer_4_Unsigned_C(GL_BYTE)),
          Lists'address);
      end Call_Lists;
    procedure Call_Lists(
      Number : in Integer_4_Signed;
      Lists  : in Array_Integer_2_Signed)
      is
      begin
        if glCallLists = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glCallLists"                         & "( " &
          Integer_4_Signed_C'Wide_Image(Number) & ", " &
          Get_String(GL_SHORT)                  & ", " &
          "'const GLvoid * lists'"              & " )" );
        glCallLists.All(
          Integer_4_Signed_C(Number),
          Integer_4_Unsigned_C(GL_SHORT)),
          Lists'address);
      end Call_Lists;
    procedure Call_Lists(
      Number : in Integer_4_Signed;
      Lists  : in Array_Integer_4_Signed)
      is
      begin
        if glCallLists = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glCallLists"                         & "( " &
          Integer_4_Signed_C'Wide_Image(Number) & ", " &
          Get_String(GL_INT)                    & ", " &
          "'const GLvoid * lists'"              & " )" );
        glCallLists.All(
          Integer_4_Signed_C(Number),
          Integer_4_Unsigned_C(GL_INT)),
          Lists'address);
      end Call_Lists;
    procedure Call_Lists(
      Number : in Integer_4_Signed;
      Lists  : in Array_Float_4_Real)
      is
      begin
        if glCallLists = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glCallLists"                         & "( " &
          Integer_4_Signed_C'Wide_Image(Number) & ", " &
          Get_String(GL_FLOAT)                  & ", " &
          "'const GLvoid * lists'"              & " )" );
        glCallLists.All(
          Integer_4_Signed_C(Number),
          Integer_4_Unsigned_C(GL_FLOAT)),
          Lists'address);
      end Call_Lists;
  -----------
  -- Clear --
  -----------
    procedure Clear(
      Mask : in Integer_4_Unsigned)
      is
      begin
        if glClear = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glClear"                           & "( " &
          Integer_4_Unsigned'Wide_Image(Mask) & " )" );
        glClear.All(
          Integer_4_Unsigned_C(Mask));
      end Clear;
  ------------------------
  -- Clear_Accumulation --
  ------------------------
    procedure Clear_Accumulation(
      Red   : in Float_4_Real;
      Green : in Float_4_Real;
      Blue  : in Float_4_Real;
      Alpha : in Float_4_Real)
      is
      begin
        if glClearAccum = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glClearAccum"                 & "( " &
          Float_4_Real'Wide_Image(Red)   & ", " &
          Float_4_Real'Wide_Image(Green) & ", " &
          Float_4_Real'Wide_Image(Blue)  & ", " &
          Float_4_Real'Wide_Image(Alpha) & " )" );
        glClearAccum.All(
          Float_4_Real_C(Red),
          Float_4_Real_C(Green),
          Float_4_Real_C(Blue),
          Float_4_Real_C(Alpha));
      end Clear_Accumulation;
  -----------------
  -- Clear_Color --
  -----------------
    procedure Clear_Color(
      Red   : in Float_4_Real;
      Green : in Float_4_Real;
      Blue  : in Float_4_Real;
      Alpha : in Float_4_Real)
      is
      begin
        if glClearColor = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glClearColor"                 & "( " &
          Float_4_Real'Wide_Image(Red)   & ", " &
          Float_4_Real'Wide_Image(Green) & ", " &
          Float_4_Real'Wide_Image(Blue)  & ", " &
          Float_4_Real'Wide_Image(Alpha) & " )" );
        glClearColor.All(
          Float_4_Real_C(Red),
          Float_4_Real_C(Green),
          Float_4_Real_C(Blue),
          Float_4_Real_C(Alpha));
      end Clear_Color;
  -----------------
  -- Clear_Depth --
  -----------------
    procedure Clear_Depth(
      Depth : in Float_8_Real)
      is
      begin
        if glClearDepth = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glClearDepth"                 & "( " &
          Float_8_Real'Wide_Image(Depth) & " )" );
        glClearDepth.All(
          Float_8_Real_C(Depth));
      end Clear_Depth;
  -----------------
  -- Clear_Index --
  -----------------
    procedure Clear_Index(
      C : in Float_4_Real)
      is
      begin
        if glClearIndex = null then
          raise Call_Failure;
        end if;
        Put_Line("glClearIndex" & "( " &
          Float_4_Real(C)       & " )" );
        glClearIndex.All(
          Float_4_Real_C(C));
      end Clear_Index;.
  -------------------
  -- Clear_Stencil --
  -------------------
    procedure Clear_Stencil(
      S : in Integer_4_Signed)
      is
      begin
        if glClearStencil = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glClearStencil"               & "( " &
          Integer_4_Signed'Wide_Image(S) & " )" );
        glClearStencil.All(
          Integer_4_Signed_C(S));
      end Clear_Stencil;
  ----------------
  -- Clip_Plane --
  ----------------
    procedure Clip_Plane(
      Plane    : in Integer_4_Unsigned;
      Equation : in Vector_4_Float_8_Real) --VECTOR
      is
      begin
        if glClipPlane = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glClipPlane"        & "( " &
          Get_String(Plane)    & ", " &
          "Vector"             & "( " &
            Float_8_Real'Wide_Image(V(1)) & ", " &
            Float_8_Real'Wide_Image(V(2)) & ", " &
            Float_8_Real'Wide_Image(V(3)) & ", " &
            Float_8_Real'Wide_Image(V(4)) & " )" & " )" );
        glClipPlane.All(
          Integer_4_Unsigned_C(Plane),
          Equation'address);
      end Clip_Plane;
  -----------
  -- Color --
  -----------
    procedure Color(
      Red   : in Integer_1_Unsigned;
      Green : in Integer_1_Unsigned;
      Blue  : in Integer_1_Unsigned)
      is
      begin
        if glColor3b = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor3b"                          & "( " &
          Integer_1_Unsigned'Wide_Image(Red)   & ", " &
          Integer_1_Unsigned'Wide_Image(Green) & ", " &
          Integer_1_Unsigned'Wide_Image(Blue)  & " )" );
        glColor3b.All(
          Integer_1_Unsigned_C(Red),
          Integer_1_Unsigned_C(Green),
          Integer_1_Unsigned_C(Blue));
      end Color;
    procedure Color(
      V : in Vector_3_Integer_1_Signed) --VECTOR
      is
      begin
        if glColor3bv = null then
          raise Call_Failure;
        end if;
        Put_Line("glColor3bv"  & "( " &
          "Vector"      & "( " &
            Integer_1_Signed'Wide_Image(V(1)) & ", " &
            Integer_1_Signed'Wide_Image(V(2)) & ", " &
            Integer_1_Signed'Wide_Image(V(3)) & " )" & " )" );
        glColor3bv.All(
          V'address);
      end Color;
    procedure Color(
      Red   : in Float_8_Real;
      Green : in Float_8_Real;
      Blue  : in Float_8_Real)
      is
      begin
        if glColor3d = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor3d"                    & "( " &
          Float_8_Real'Wide_Image(Red)   & ", " &
          Float_8_Real'Wide_Image(Green) & ", " &
          Float_8_Real'Wide_Image(Blue)  & " )" );
        glColor3d.All(
          Float_8_Real_C(Red),
          Float_8_Real_C(Green),
          Float_8_Real_C(Blue));
      end Color;
    procedure Color(
      V : in Vector_3_Float_8_Real) --VECTOR
      is
      begin
        if glColor3dv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor3dv"  & "( " &
          "Vector"      & "( " &
            Float_8_Real'Wide_Image(V(1)) & ", " &
            Float_8_Real'Wide_Image(V(2)) & ", " &
            Float_8_Real'Wide_Image(V(3)) & " )" & " )" );
        glColor3dv.All(
          V'address);
      end Color;
    procedure Color(
      Red   : in Float_4_Real;
      Green : in Float_4_Real;
      Blue  : in Float_4_Real)
      is
      begin
        if glColor3f = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor3f"                    & "( " &
          Float_4_Real'Wide_Image(Red)   & ", " &
          Float_4_Real'Wide_Image(Green) & ", " &
          Float_4_Real'Wide_Image(Blue)  & " )" );
        glColor3f.All(
          Float_4_Real_C(Red),
          Float_4_Real_C(Green),
          Float_4_Real_C(Blue));
      end Color;
    procedure Color(
      V : in Vector_3_Float_4_Real) --VECTOR
      is
      begin
        if glColor3sfv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor3fv"  & "( " &
          "Vector"      & "( " &
            Float_4_Real'Wide_Image(V(1)) & ", " &
            Float_4_Real'Wide_Image(V(2)) & ", " &
            Float_4_Real'Wide_Image(V(3)) & " )" & " )" );
        glColor3fv.All(
          V'address);
    procedure Color(
      Red   : in Integer_4_Signed;
      Green : in Integer_4_Signed;
      Blue  : in Integer_4_Signed)
      is
      begin
        if glColor3i = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor3i"                        & "( " &
          Integer_4_Signed'Wide_Image(Red)   & ", " &
          Integer_4_Signed'Wide_Image(Green) & ", " &
          Integer_4_Signed'Wide_Image(Blue)  & " )" );
        glColor3i.All(
          Integer_4_Signed_C(Red),
          Integer_4_Signed_C(Green),
          Integer_4_Signed_C(Blue));
      end Color;
    procedure Color(
      V : in Vector_3_Integer_4_Signed) --VECTOR
      is
      begin
        if glColor3iv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor3iv"  & "( " &
          "Vector"      & "( " &
            Integer_4_Signed'Wide_Image(V(1)) & ", " &
            Integer_4_Signed'Wide_Image(V(2)) & ", " &
            Integer_4_Signed'Wide_Image(V(3)) & " )" & " )" );
        glColor3iv.All(
          V'address);
      end Color;
    procedure Color(
      Red   : in Integer_2_Signed;
      Green : in Integer_2_Signed;
      Blue  : in Integer_2_Signed)
      is
      begin
        if glColor3s = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor3s"                        & "( " &
          Integer_2_Signed'Wide_Image(Red)   & ", " &
          Integer_2_Signed'Wide_Image(Green) & ", " &
          Integer_2_Signed'Wide_Image(Blue)  & " )" );
        glColor3s.All(
          Integer_2_Singed(Red),
          Integer_2_Singed(Green),
          Integer_2_Singed(Blue));
      end Color;
    procedure Color(
      V : in Vector_3_Integer_2_Signed) --VECTOR
      is
      begin
        if glColor3sv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor3sv"  & "( " &
          "Vector"      & "( " &
            Integer_2_Signed'Wide_Image(V(1)) & ", " &
            Integer_2_Signed'Wide_Image(V(2)) & ", " &
            Integer_2_Signed'Wide_Image(V(3)) & " )" & " )" );
        glColor3sv.All(
          V'address);
      end Color;
    procedure Color(
      Red   : in Integer_1_Unsigned;
      Green : in Integer_1_Unsigned;
      Blue  : in Integer_1_Unsigned)
      is
      begin
        if glColor3ub = null then
          raise Call_Failure;
        end if;
        Put_Line("glColor3ub"                  & "( " &
          Integer_1_Unsigned'Wide_Image(Red)   & ", " &
          Integer_1_Unsigned'Wide_Image(Green) & ", " &
          Integer_1_Unsigned'Wide_Image(Blue)  & " )" );
        glColor3ub.All(
          Integer_1_Unsigned_C(Red),
          Integer_1_Unsigned_C(Green),
          Integer_1_Unsigned_C(Blue));
      end Color;
    procedure Color(
      V : in Vector_3_Integer_1_Unsigned) --VECTOR
      is
      begin
        if glColor3ubv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor3ubv" & "( " &
          "Vector"      & "( " &
            Integer_1_Unsigned'Wide_Image(V(1)) & ", " &
            Integer_1_Unsigned'Wide_Image(V(2)) & ", " &
            Integer_1_Unsigned'Wide_Image(V(3)) & " )" & " )" );
        glColor3ubv.All(
          V'address);
      end Color;
    procedure Color(
      Red   : in Integer_4_Unsigned;
      Green : in Integer_4_Unsigned;
      Blue  : in Integer_4_Unsigned)
      is
      begin
        if glColor3ui = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor3ui"                         & "( " &
          Integer_4_Unsigned'Wide_Image(Red)   & ", " &
          Integer_4_Unsigned'Wide_Image(Green) & ", " &
          Integer_4_Unsigned'Wide_Image(Blue)  & " )" );
        glColor3ui.All(
          Integer_4_Unsigned_C(Red),
          Integer_4_Unsigned_C(Green),
          Integer_4_Unsigned_C(Blue));
      end Color;
    procedure Color(
      V : in Vector_3_Integer_4_Unsigned) --VECTOR
      is
      begin
        if glColor3uiv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor3uiv" & "( " &
          "Vector"      & "( " &
            Integer_4_Signed'Wide_Image(V(1)) & ", " &
            Integer_4_Signed'Wide_Image(V(2)) & ", " &
            Integer_4_Signed'Wide_Image(V(3)) & " )" & " )" );
        glColor3uiv.All(
          V'address);
      end Color;
    procedure Color(
      Red   : in Integer_2_Unsigned;
      Green : in Integer_2_Unsigned;
      Blue  : in Integer_2_Unsigned)
      is
      begin
        if glColor3us = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor3us"                         & "( " &
          Integer_2_Unsigned'Wide_Image(Red)   & ", " &
          Integer_2_Unsigned'Wide_Image(Green) & ", " &
          Integer_2_Unsigned'Wide_Image(Blue)  & " )" );
        glColor3us.All(
          Integer_2_Unsigned_C(Red),
          Integer_2_Unsigned_C(Green),
          Integer_2_Unsigned_C(Blue));
      end Color;
    procedure Color(
      V : in Vector_3_Integer_2_Unsigned_C) --VECTOR
      is
      begin
        if glColor4usv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor3usv" & "( " &
          "Vector"      & "( " &
            Integer_2_Unsigned'Wide_Image(V(1)) & ", " &
            Integer_2_Unsigned'Wide_Image(V(2)) & ", " &
            Integer_2_Unsigned'Wide_Image(V(3)) & " )" & " )" );
        glColor3usv.All(
          V'address);
      end Color;
    procedure Color(
      Red   : in Integer_1_Signed;
      Green : in Integer_1_Signed;
      Blue  : in Integer_1_Signed;
      Alpha : in Integer_1_Signed)
      is
      begin
        if glColor4b = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4b"                        & "( " &
          Integer_1_Signed'Wide_Image(Red)   & ", " &
          Integer_1_Signed'Wide_Image(Green) & ", " &
          Integer_1_Signed'Wide_Image(Blue)  & ", " &
          Integer_1_Signed'Wide_Image(Alpha) & " )" );
        glColor4b.All(
          Integer_1_Signed_C(Red),
          Integer_1_Signed_C(Green),
          Integer_1_Signed_C(Blue),
          Integer_1_Signed_C(Alpha));
      end Color;
    procedure Color(
      V : in Vector_4_Integer_1_Signed) --VECTOR
      is
      begin
        if glColor4bv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4bv"  & "( " &
          "Vector"      & "( " &
            Integer_1_Signed'Wide_Image(V(1)) & ", " &
            Integer_1_Signed'Wide_Image(V(2)) & ", " &
            Integer_1_Signed'Wide_Image(V(3)) & ", " &
            Integer_1_Signed'Wide_Image(V(4)) & " )" & " )" );
        glColor4bv.All(
          V'address);
      end Color;
    procedure Color(
      Red   : in Float_8_Real;
      Green : in Float_8_Real;
      Blue  : in Float_8_Real;
      Alpha : in Float_8_Real)
      is
      begin
        if glColor4d = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4d"                    & "( " &
          Float_8_Real'Wide_Image(Red)   & ", " &
          Float_8_Real'Wide_Image(Green) & ", " &
          Float_8_Real'Wide_Image(Blue)  & ", " &
          Float_8_Real'Wide_Image(Alpha  & " )" );
        glColor4d.All(
          Float_8_Real'Wide_Image(Red),
          Float_8_Real'Wide_Image(Green),
          Float_8_Real'Wide_Image(Blue),
          Float_8_Real'Wide_Image(Alpha));
      end Color;
    procedure Color(
      V : in Vector_4_Float_8_Real) --VECTOR
      is
      begin
        if glColor4dv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4dv"  & "( " &
          "Vector"      & "( " &
            Float_8_Real'Wide_Image(V(1)) & ", " &
            Float_8_Real'Wide_Image(V(2)) & ", " &
            Float_8_Real'Wide_Image(V(3)) & ", " &
            Float_8_Real'Wide_Image(V(4)) & " )" & " )" );
        glColor4dv.All(
          V'address);
      end Color;
    procedure Color(
      Red   : in Float_4_Real;
      Green : in Float_4_Real;
      Blue  : in Float_4_Real;
      Alpha : in Float_4_Real)
      is
      begin
        if glColor4f = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4f"                    & "( " &
          Float_4_Real'Wide_Image(Red)   & ", " &
          Float_4_Real'Wide_Image(Green) & ", " &
          Float_4_Real'Wide_Image(Blue)  & ", " &
          Float_4_Real'Wide_Image(Alpha) & " )" );
        glColor4f.All(
          Float_4_Real_C(Red),
          Float_4_Real_C(Green),
          Float_4_Real_C(Blue),
          Float_4_Real_C(Alpha));
      end Color;
    procedure Color(
      V : in Vector_4_Float_4_Real) --VECTOR
      is
      begin
        if glColor4fv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4fv"  & "( " &
          "Vector"      & "( " &
            Float_4_Real'Wide_Image(V(1)) & ", " &
            Float_4_Real'Wide_Image(V(2)) & ", " &
            Float_4_Real'Wide_Image(V(3)) & ", " &
            Float_4_Real'Wide_Image(V(4)) & " )" & " )" );
        glColor4fv.All(
          V'address);
      end Color;
    procedure Color(
      Red   : in Integer_4_Signed;
      Green : in Integer_4_Signed;
      Blue  : in Integer_4_Signed;
      Alpha : in Integer_4_Signed)
      is
      begin
        if glColor4i = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4i"                        & "( " &
          Integer_4_Signed'Wide_Image(Red)   & ", " &
          Integer_4_Signed'Wide_Image(Green  & ", " &
          Integer_4_Signed'Wide_Image(Blue)  & ", " &
          Integer_4_Singed'Wide_Image(Alpha) & " )" );
        glColor4i.All(
          Integer_4_Signed_C(Red),
          Integer_4_Signed_C(Green),
          Integer_4_Signed_C(Blue),
          Integer_4_Signed_C(Alpha));
      end Color;
    procedure Color(
      V : in Vector_4_Integer_4_Signed) --VECTOR
      is
      begin
        if glColor4iv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4iv"  & "( " &
          "Vector"      & "( " &
            Integer_4_Signed'Wide_Image(V(1)) & ", " &
            Integer_4_Signed'Wide_Image(V(2)) & ", " &
            Integer_4_Signed'Wide_Image(V(3)) & ", " &
            Integer_4_Signed'Wide_Image(V(4)) & " )" & " )" );
        glColor4iv(
          V'address);
      end Color;
    procedure Color(
      Red   : in Integer_2_Signed;
      Green : in Integer_2_Signed;
      Blue  : in Integer_2_Signed;
      Alpha : in Integer_2_Signed)
      is
      begin
        if glColor4s = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4s"                        & "( " &
          Integer_2_Signed'Wide_Image(Red)   & ", " &
          Integer_2_Signed'Wide_Image(Green) & ", " &
          Integer_2_Signed'Wide_Image(Blue)  & ", " &
          Integer_2_Signed'Wide_Image(Alpha  & " )" );
        glColor4s.All(
          Integer_2_Signed_C(Red),
          Integer_2_Signed_C(Green),
          Integer_2_Signed_C(Blue),
          Integer_2_Signed_C(Alpha));
      end Color;
    procedure Color(
      V : in Vector_4_Integer_2_Signed) --VECTOR
      is
      begin
        if glColor4sv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4sv"  & "( " &
          "Vector"      & "( " &
            Integer_2_Signed'Wide_Image(V(1)) & ", " &
            Integer_2_Signed'Wide_Image(V(2)) & ", " &
            Integer_2_Signed'Wide_Image(V(3)) & ", " &
            Integer_2_Signed'Wide_Image(V(4)) & " )" & " )" );
        glColor4sv(
          V'address);
      end Color;
    procedure Color(
      Red   : in Integer_1_Unsigned;
      Green : in Integer_1_Unsigned;
      Blue  : in Integer_1_Unsigned;
      Alpha : in Integer_1_Unsigned)
      is
      begin
        if glColor4ub = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4ub"                         & "( " &
          Integer_1_Unsigned'Wide_Image(Red)   & ", " &
          Integer_1_Unsigned'Wide_Image(Green) & ", " &
          Integer_1_Unsigned'Wide_Image(Blue), & ", " &
          Integer_1_Unsigned'Wide_Image(Alpha) & " )" );
        glColor4ub.All(
          Integer_1_Unsigned_C(Red),
          Integer_1_Unsigned_C(Green),
          Integer_1_Unsigned_C(Blue),
          Integer_1_Unsigned_C(Alpha));
      end Color;
    procedure Color(
      V : in Vector_4_Integer_1_Unsigned) --VECTOR
      is
      begin
        if glColor4ubv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4ubv" & "( " &
          "Vector"      & "( " &
            Integer_1_Unsigned'Wide_Image(V(1)) & ", " &
            Integer_1_Unsigned'Wide_Image(V(2)) & ", " &
            Integer_1_Unsigned'Wide_Image(V(3)) & ", " &
            Integer_1_Unsigned'Wide_Image(V(4)) & " )" & " )" );
        glColor4ubv(
          V'address);
      end Color;
    procedure Color(
      Red   : in Integer_4_Unsigned;
      Green : in Integer_4_Unsigned;
      Blue  : in Integer_4_Unsigned;
      Alpha : in Integer_4_Unsigned)
      is
      begin
        if glColor4ui = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4ui"                         & "( " &
          Integer_4_Unsigned'Wide_Image(Red)   & ", " &
          Integer_4_Unsigned'Wide_Image(Green) & ", " &
          Integer_4_Unsigned'Wide_Image(Blue)  & ", " &
          Integer_4_Unsigned'Wide_Image(Alpha) & " )" );
        glColor4ui.All(
          Integer_4_Unsigned_C(Red),
          Integer_4_Unsigned_C(Green),
          Integer_4_Unsigned_C(Blue),
          Integer_4_Unsigned_C(Alpha));
      end Color;
    procedure Color(
      V : in Vector_4_Integer_4_Unsigned) --VECTOR
      is
      begin
        if glColor4uiv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4uiv" & "( " &
          "Vector"      & "( " &
            Integer_4_Unsigned'Wide_Image(V(1)) & ", " &
            Integer_4_Unsigned'Wide_Image(V(2)) & ", " &
            Integer_4_Unsigned'Wide_Image(V(3)) & ", " &
            Integer_4_Unsigned'Wide_Image(V(4)) & " )" & " )" );
        glColor4uiv.All(
          V'address);
      end Color;
    procedure Color(
      Red   : in Integer_2_Unsigned;
      Green : in Integer_2_Unsigned;
      Blue  : in Integer_2_Unsigned;
      Alpha : in Integer_2_Unsigned)
      is
      begin
        if glColor4us = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4us"                         & "( " &
          Integer_2_Unsigned'Wide_Image(Red)   & ", " &
          Integer_2_Unsigned'Wide_Image(Green) & ", " &
          Integer_2_Unsigned'Wide_Image(Blue)  & ", " &
          Integer_2_Unsigned'Wide_Image(Alpha) & " )" );
        glColor4us.All(
          Integer_2_Unsigned(Red),
          Integer_2_Unsigned(Green),
          Integer_2_Unsigned(Blue),
          Integer_2_Unsigned(Alpha));
      end Color;
    procedure Color(
      V : in Vector_2_Integer_2_Unsigned) --VECTOR
      is
      begin
        if glColor4usv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColor4usv" & "( " &
          "Vector"      & "( " &
            Integer_2_Unsigned'Wide_Image(V(1)) & ", " &
            Integer_2_Unsigned'Wide_Image(V(2)) & ", " &
            Integer_2_Unsigned'Wide_Image(V(3)) & ", " &
            Integer_2_Unsigned'Wide_Image(V(4)) & " )" & " )" );
        glColor4usv(
          V);
      end Color;
  ----------------
  -- Color_Mask --
  ----------------
    procedure Color_Mask(
      Red   : in Integer_1_Unsigned;
      Green : in Integer_1_Unsigned;
      Blue  : in Integer_1_Unsigned;
      Alpha : in Integer_1_Unsigned)
      is
      begin
        if glColorMask = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColorMask"                        & "( " &
          Integer_1_Unsigned'Wide_Image(Red)   & ", " &
          Integer_1_Unsigned'Wide_Image(Green) & ", " &
          Integer_1_Unsigned'Wide_Image(Blue)  & ", " &
          Integer_1_Unsigned'Wide_Image(Alpha) & " )" );
        glColorMask.All(
          Integer_1_Unsigned_C(Red),
          Integer_1_Unsigned_C(Green),
          Integer_1_Unsigned_C(Blue),
          Integer_1_Unsigned_C(Alpha));
      end Color_Mask;
  --------------------
  -- Color_Material --
  --------------------
    procedure Color_Material(
      Race : in Integer_4_Unsigned;
      Mode : in Integer_4_Unsigned)
      is
      begin
        if glColorMaterial = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColorMaterial" & "( " &
          Get_String(Face)  & ", " &
          Get_String(Mode)  & " )" );
        glColorMaterial.All(
          Integer_4_Unsigned_C(Face),
          Integer_4_Unsigned_C(Mode));
      end Color_Material;
  -------------------
  -- Color_Pointer --
  -------------------
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Integer_1_Unsigned)
      is
      begin
        if glColorPointer = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColorPointer"                    & "( " &
          Integer_4_Signed'Wide_Image(Size)   & ", " &
          Get_String(GL_UNSIGNED_BYTE)        & ", " &
          Integer_4_Signed'Wide_Image(Stride) & ", " &
          "'const GLvoid * pointer'"          & " )" &
        glColorPointer.All(
          Integer_4_Signed_C(Size),
          Integer_4_Unsigned_C(GL_UNSIGNED_BYTE),
          Integer_4_Signed_C(Stride),
          Color_Elements'address);
      end Color_Pointer;
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Integer_2_Unsigned)
      is
      begin
        if glColorPointer = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColorPointer"                    & "( " &
          Integer_4_Signed'Wide_Image(Size)   & ", " &
          Get_String(GL_UNSIGNED_SHORT)       & ", " &
          Integer_4_Signed'Wide_Image(Stride) & ", " &
          "'const GLvoid * pointer'"          & " )" &
        glColorPointer.All(
          Integer_4_Signed_C(Size),
          Integer_4_Unsigned_C(GL_UNSIGNED_SHORT),
          Integer_4_Signed_C(Stride),
          Color_Elements'address);
      end Color_Pointer;
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Integer_4_Unsigned)
      is
      begin
        if glColorPointer = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColorPointer"                    & "( " &
          Integer_4_Signed'Wide_Image(Size)   & ", " &
          Get_String(GL_UNSIGNED_INT)         & ", " &
          Integer_4_Signed'Wide_Image(Stride) & ", " &
          "'const GLvoid * pointer'"          & " )" &
        glColorPointer.All(
          Integer_4_Signed_C(Size),
          Integer_4_Unsigned_C(GL_UNSIGNED_INT),
          Integer_4_Signed_C(Stride),
          Color_Elements'address);
      end Color_Pointer;
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Integer_1_Signed)
      is
      begin
        if glColorPointer = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColorPointer"                    & "( " &
          Integer_4_Signed'Wide_Image(Size)   & ", " &
          Get_String(GL_BYTE)                 & ", " &
          Integer_4_Signed'Wide_Image(Stride) & ", " &
          "'const GLvoid * pointer'"          & " )" &
        glColorPointer.All(
          Integer_4_Signed_C(Size),
          Integer_4_Unsigned_C(GL_BYTE),
          Integer_4_Signed_C(Stride),
          Color_Elements'address);
      end Color_Pointer;
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Integer_2_Signed)
      is
      begin
        if glColorPointer = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColorPointer"                    & "( " &
          Integer_4_Signed'Wide_Image(Size)   & ", " &
          Get_String(GL_SHORT)                & ", " &
          Integer_4_Signed'Wide_Image(Stride) & ", " &
          "'const GLvoid * pointer'"          & " )" &
        glColorPointer.All(
          Integer_4_Signed_C(Size),
          Integer_4_Unsigned_C(GL_SHORT),
          Integer_4_Signed_C(Stride),
          Color_Elements'address);
      end Color_Pointer;
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Integer_4_Signed)
      is
      begin
        if glColorPointer = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColorPointer"                    & "( " &
          Integer_4_Signed'Wide_Image(Size)   & ", " &
          Get_String(GL_INT)                  & ", " &
          Integer_4_Signed'Wide_Image(Stride) & ", " &
          "'const GLvoid * pointer'"          & " )" &
        glColorPointer.All(
          Integer_4_Signed_C(Size),
          Integer_4_Unsigned_C(GL_INT),
          Integer_4_Signed_C(Stride),
          Color_Elements'address);
      end Color_Pointer;
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Float_4_Real)
      is
      begin
        if glColorPointer = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColorPointer"                    & "( " &
          Integer_4_Signed'Wide_Image(Size)   & ", " &
          Get_String(GL_FLOAT)                & ", " &
          Integer_4_Signed'Wide_Image(Stride) & ", " &
          "'const GLvoid * pointer'"          & " )" &
        glColorPointer.All(
          Integer_4_Signed_C(Size),
          Integer_4_Unsigned_C(GL_FLOAT),
          Integer_4_Signed_C(Stride),
          Color_Elements'address);
      end Color_Pointer;
    procedure Color_Pointer(
      Size           : in Integer_4_Signed;
      Stride         : in Integer_4_Signed;
      Color_Elements : in Array_Float_8_Real)
      is
      begin
        if glColorPointer = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glColorPointer"                    & "( " &
          Integer_4_Signed'Wide_Image(Size)   & ", " &
          Get_String(GL_DOUBLE)               & ", " &
          Integer_4_Signed'Wide_Image(Stride) & ", " &
          "'const GLvoid * pointer'"          & " )" &
        glColorPointer.All(
          Integer_4_Signed_C(Size),
          Integer_4_Unsigned_C(GL_DOUBLE),
          Integer_4_Signed_C(Stride),
          Color_Elements'address);
      end Color_Pointer;
  -----------------
  -- Copy_Pixels --
  -----------------
    procedure Copy_Pixels(
      X      : in Integer_4_Signed;
      Y      : in Integer_4_Signed;
      Width  : in Integer_4_Signed;
      Height : in Integer_4_Signed;
      Kind   : in Integer_4_Unsigned)
      is
      begin
        if glCopyPixels = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glCopyPixels"                      & "( " &
          Integer_4_Signed'Wide_Image(X)      & ", " &
          Integer_4_Signed'Wide_Image(Y)      & ", " &
          Integer_4_Signed'Wide_Image(Width)  & ", " &
          Integer_4_Signed'Wide_Image(Height) & ", " &
          Get_String(Kind)                    & " )" );
        glCopyPixels.All(
          Integer_4_Signed_C(X),
          Integer_4_Signed_C(Y),
          Integer_4_Signed_C(Width),
          Integer_4_Signed_C(Height),
          Integer_4_Unsigned_C(Kind));
      end Copy_Pixels;
  ---------------------------
  -- Copy_Texture_Image_1D --
  ---------------------------
    procedure Copy_Texture_1D(
      Target : in Integer_4_Unsigned;
      Level  : in Integer_4_Signed;
      Format : in Integer_4_Unsigned;
      X      : in Integer_4_Signed;
      Y      : in Integer_4_Signed;
      Width  : in Integer_4_Signed;
      Border : in Integer_4_Signed)
      is
      begin
        if glCopyTexImage1D = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glCopyTexImage1D"                  & "( " &
          Get_String(Target)                  & ", " &
          Integer_4_Signed'Wide_Image(Level)  & ", " &
          Get_String(Format)                  & ", " &
          Integer_4_Signed'Wide_Image(X)      & ", " &
          Integer_4_Signed'Wide_Image(Y)      & ", " &
          Integer_4_Signed'Wide_Image(Width)  & ", " &
          Integer_4_Signed'Wide_Image(Border) & " )" );
        glCopyTexImage1D.All(
          Integer_4_Unsigned_C(Target),
          Integer_4_Signed_C(Level),
          Integer_4_Unsigned_C(Format),
          Integer_4_Signed_C(X),
          Integer_4_Signed_C(Y),
          Integer_4_Signed_C(Width),
          Integer_4_Signed_C(Border));
      end Copy_Texture_1D;
  ---------------------------
  -- Copy_Texture_Image_2D --
  ---------------------------
    procedure Copy_Texture_Image_2D(
      Target : in Integer_4_Unsigned;
      Level  : in Integer_4_Signed;
      Format : in Integer_4_Unsigned;
      X      : in Integer_4_Signed;
      Y      : in Integer_4_Signed;
      Width  : in Integer_4_Signed;
      Height : in Integer_4_Signed;
      Border : in Integer_4_Signed)
      is
      begin
        if glCopyTexImage2D = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glCopyTexImage2D"                  & "( " &
          Get_String(Target)                  & ", " &
          Integer_4_Signed'Wide_Image(Level)  & ", " &
          Get_String(Format)                  & ", " &
          Integer_4_Signed'Wide_Image(X)      & ", " &
          Integer_4_Signed'Wide_Image(Y)      & ", " &
          Integer_4_Signed'Wide_Image(Width)  & ", " &
          Integer_4_Signed'Wide_Image(Height) & ", " &
          Integer_4_Signed'Wide_Image(Border) & " )" );
        glCopyTexImage2D.All(
          Integer_4_Unsigned_C(Target),
          Integer_4_Signed_C(Level),
          Integer_4_Unsigned_C(Format),
          Integer_4_Signed_C(X),
          Integer_4_Singed_C(Y),
          Integer_4_Signed_C(Width),
          Integer_4_Signed_C(Height),
          Integer_4_Signed_C(Border));
      end Copy_Texture_Image_2D;
  ------------------------------
  -- Copy_Texture_Subimage_1D --
  ------------------------------
    procedure Copy_Texture_Subimage_1D(
      Target   : in Integer_4_Unsigned;
      Level    : in Integer_4_Signed;
      X_Offset : in Integer_4_Signed;
      X        : in Integer_4_Signed;
      Y        : in Integer_4_Signed;
      Width    : in Integer_4_Signed)
      is
      begin
        if glCopyTexSubImage1D = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glCopyTexSubImage1D"                 & "( " &
          Get_String(Target)                    & ", " &
          Integer_4_Signed'Wide_Image(Level)    & ", " &
          Integer_4_Signed'Wide_Image(X_Offset) & ", " &
          Integer_4_Signed'Wide_Image(X)        & ", " &
          Integer_4_Signed'Wide_Image(Y)        & ", " &
          Integer_4_Signed'Wide_Image(Width)    & " )" );
        glCopyTexSubImage1D.All(
          Integer_4_Unsigned(Target),
          Integer_4_Signed(Level),
          Integer_4_Signed(X_Offset),
          Integer_4_Signed(X),
          Integer_4_Signed(Y),
          Integer_4_Signed(Width));
      end Copy_Texture_Subimage_1D;
  ------------------------------
  -- Copy_Texture_Subimage_2D --
  ------------------------------
    procedure Copy_Texture_Subimage_2D(
      Target   : Integer_4_Unsigned;
      Level    : Integer_4_Signed;
      X_Offset : Integer_4_Signed;
      Y_Offset : Integer_4_Signed;
      X        : Integer_4_Signed;
      Y        : Integer_4_Signed;
      Width    : Integer_4_Signed;
      Height   : Integer_4_Signed)
      is
      begin
        if glCopyTexSubImage2D = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glCopyTexSubImage2D"                 & "( " &
          Get_String(Target)                    & ", " &
          Integer_4_Signed'Wide_Image(Level)    & ", " &
          Integer_4_Signed'Wide_Image(X_Offset) & ", " &
          Integer_4_Signed'Wide_Image(Y_Offset) & ", " &
          Integer_4_Signed'Wide_Image(X)        & ", " &
          Integer_4_Signed'Wide_Image(Y)        & ", " &
          Integer_4_Signed'Wide_Image(Width)    & ", " &
          Integer_4_Signed'Wide_Image(Height)   & " )" &;
        glCopyTexSubImage2D.All(
          Integer_4_Unsigned_C(Target),
          Integer_4_Signed_C(Level),
          Integer_4_Signed_C(X_Offset),
          Integer_4_Signed_C(Y_Offset),
          Integer_4_Signed_C(X),
          Integer_4_Signed_C(Y),
          Integer_4_Signed_C(Width),
          Integer_4_Signed_C(Height));
      end Copy_Texture_Subimage_2D;
  ---------------
  -- Cull_Face --
  ---------------
    procedure Cull_Face(
      Mode : in Integer_4_Unsigned)
      is
      begin
        if glCullFace = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glCullFace"     & "( " &
          Get_String(Mode) & " )" );
        glCullFace.All(
          Integer_4_Unsigned_C(Mode);
      end Cull_Face;
  ------------------
  -- Delete_Lists --
  ------------------
    procedure Delete_Lists(
      List   : in Integer_4_Unsigned;
      Bounds : in Integer_4_Signed)
      is
      begin
        if glDeleteLists = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDeleteLists" & "( " &
          Integer_4_Unsigned'Wide_Image(List) & ", " &
          Integer_4_Signed'Wide_Image(Bounds) & " )" );
        glDeleteLists.All(
          Integer_4_Unsigned_C(List),
          Integer_4_Signed_C(Bounds));
      end Delete_Lists;
  ---------------------
  -- Delete_Textures --
  ---------------------
    procedure Delete_Textures(
      N        : in     Integer_4_Signed_C,
      Textures : in out Array_Integer_1_Unsigned_C)
      is
      begin
        if glDeleteTextures = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDeleteTextures"               & "( " &
          Integer_4_Signed_C'Wide_Image(N) & ", " &
          "'const GLuint * textures'"      & " )" );
        glDeleteTextures.All(
          Integer_4_Signed_C(N),
          Textures'address);
      end Delete_Textures;
  --------------------
  -- Depth_Function --
  --------------------
    procedure Depth_Function(
      Operation : in Integer_4_Unsigned)
      is
      begin
        if glDepthFunc = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDepthFunc"         & "( " &
          Get_String(Operation) & " )" );
        glDepthFunc.All(
          Integer_4_Unsigned_C(Operation));
      end Depth_Function;
  ----------------
  -- Depth_Mask --
  ----------------
    procedure Depth_Mask(
      Flag : in Integer_1_Unsigned)
      is
      begin
        if glDepthMask = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDepthMask"            & "( " &
          Integer_1_Unsigned(Flag) & " )" );
        glDepthMask.All(
          Integer_1_Unsigned(Flag));
      end Depth_Mask;
  -----------------
  -- Depth_Range --
  -----------------
    procedure Depth_Range(
      Z_Near : in Float_8_Real;
      Z_Far  : in Float_8_Real)
      is
      begin
        if glDepthRange = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDepthRange"                  & "( " &
          Float_8_Real'Wide_Image(Z_Near) & ", " &
          Float_8_Real'Wide_Image(Z_Far)  & " )" );
        glDepthRange.All(
          Float_9_Real_C(Z_Near),
          Float_9_Real_C(Z_Far);
      end Depth_Range;
  -------------
  -- Disable --
  -------------
    procedure Disable(
      Cap : in Integer_4_Unsigned)
      is
      begin
        if glDisable = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDisable"     & "( " &
          Get_String(Cap) & " )" );
        glDisable.All(
          Integer_4_Unsigned_C(Cap));
      end Disable;
  --------------------------
  -- Disable_Client_State --
  --------------------------
    procedure Disable_Client_State(
      Cap : in Integer_4_Unsigned)
      is
      begin
        if glDisableClientState = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDisableClientState" & "( " &
          Get_String(Cap)        & " )" );
        glDisableClientState.All(
          Cap);
      end Disable_Cliend_State;
  -----------------
  -- Draw_Arrays --
  -----------------
    procedure Draw_Arrays(
      Mode  : Integer_4_Unsigned;
      First : Integer_4_Signed;
      Count : Integer_4_Signed)
      is
      begin
        if glDrawArrays = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDrawArrays"                     & "( " &
          Get_String(Mode)                   & ", " &
          Integer_4_Signed'Wide_Image(First) & ", " &
          Integer_4_Signed'Wide_Image(Count) & " )" );
        glDrawArrays.All(
          Integer_4_Unsigned_C(Mode),
          Integer_4_Signed_C(First),
          Integer_4_Signed_C(Count));
      end Draw_Arrays;
  -----------------
  -- Draw_Buffer --
  -----------------
    procedure Draw_Buffer(
      Mode : in Integer_4_Unsigned)
      is
      begin
        if glDrawBuffer = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDrawBuffer"   & "( " &
          Get_String(Mode) & " )" );
        glDrawBuffer.All(
          Integer_4_Unsigned_C(Mode));
      end Draw_Buffer;
  -------------------
  -- Draw_Elements --
  -------------------
    procedure Draw_Elements(
      Mode    : in Integer_4_Unsigned;
      Indices : in Array_Integer_1_Unsigned)
      is
      begin
        if glDrawElements = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDrawElements"                     & "( " &
          Get_String(Mode)                     & ", " &
          Positive'Wide_Image(Indicies'Length) & ", " &
          Get_String(GL_UNSIGNED_BYTE)         & ", " &
          "'const GLvoid * indices'"           & " )" );
        glDrawElements.All(
          Integer_4_Unsigned_C(Mode),
          Integer_4_Unsigned_C(Indices'Length),
          Integer_4_Unsigned_C(GL_UNSIGNED_BYTE),
          Indices'address);
      end Draw_Elements;
    procedure Draw_Elements(
      Mode    : in Integer_4_Unsigned;
      Indices : in Array_Integer_2_Unsigned)
      is
      begin
        if glDrawElements = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDrawElements"                     & "( " &
          Get_String(Mode)                     & ", " &
          Positive'Wide_Image(Indicies'Length) & ", " &
          Get_String(GL_UNSIGNED_SHORT)        & ", " &
          "'const GLvoid * indices'"           & " )" );
        glDrawElements.All(
          Integer_4_Unsigned_C(Mode),
          Integer_4_Unsigned_C(Indices'Length),
          Integer_4_Unsigned_C(GL_UNSIGNED_SHORT),
          Indices'address);
      end Draw_Elements;
    procedure Draw_Elements(
      Mode    : in Integer_4_Unsigned;
      Indices : in Array_Integer_4_Unsigned)
      is
      begin
        if glDrawElements = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDrawElements"                     & "( " &
          Get_String(Mode)                     & ", " &
          Positive'Wide_Image(Indicies'Length) & ", " &
          Get_String(GL_UNSIGNED_INT)          & ", " &
          "'const GLvoid * indices'"           & " )" );
        glDrawElements.All(
          Integer_4_Unsigned_C(Mode),
          Integer_4_Unsigned_C(Indices'Length),
          Integer_4_Unsigned_C(GL_UNSIGNED_INT),
          Indices'address);
      end Draw_Elements;
  -----------------
  -- Draw_Pixels --
  -----------------
    procedure Draw_Pixels(
      Format : in Integer_4_Unsigned;
      Pixels : in Matrix_Integer_1_Unsigned) --MATRIX
      is
      begin
        if glDrawPixels = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDrawPixels"                                   & "( " &
          Positive'Wide_Image(Pixels'Length)               & ", " &
          Positive'Wide_Image(Pixels(Pixels'first)'Length) & ", " &
          Get_String(Format)                               & ", " &
          Get_String(GL_UNSIGNED_BYTE)                     & ", " &
          "'const GLvoid * pixels'"                        & " )" );
        glDrawPixel.All(
          Integer_4_Signed_C(Pixels'Length),
          Integer_4_Signed_C(Pixels(Pixels'first)'Length),
          Integer_4_Unsigned_C(Format),
          Integer_4_Unsigned_C(GL_UNSIGNED_BYTE),
          Pixels'address);
      end Draw_Pixels;
    procedure Draw_Pixels(
      Format : in Integer_4_Unsigned;
      Pixels : in Matrix_Integer_1_Signed) --MATRIX
      is
      begin
        if glDrawPixels = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDrawPixels"                                   & "( " &
          Positive'Wide_Image(Pixels'Length)               & ", " &
          Positive'Wide_Image(Pixels(Pixels'first)'Length) & ", " &
          Get_String(Format)                               & ", " &
          Get_String(GL__BYTE)                             & ", " &
          "'const GLvoid * pixels'"                        & " )" );
        glDrawPixel.All(
          Integer_4_Signed_C(Pixels'Length),
          Integer_4_Signed_C(Pixels(Pixels'first)'Length),
          Integer_4_Unsigned_C(Format),
          Integer_4_Unsigned_C(GL_BYTE),
          Pixels'address);
      end Draw_Pixels;
    procedure Draw_Pixels(
      Format : in Integer_4_Unsigned;
      Pixels : in Matrix_Integer_2_Unsigned) --MATRIX
      is
      begin
        if glDrawPixels = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDrawPixels"                                   & "( " &
          Positive'Wide_Image(Pixels'Length)               & ", " &
          Positive'Wide_Image(Pixels(Pixels'first)'Length) & ", " &
          Get_String(Format)                               & ", " &
          Get_String(GL_UNSIGNED_SHORT)                    & ", " &
          "'const GLvoid * pixels'"                        & " )" );
        glDrawPixel.All(
          Integer_4_Signed_C(Pixels'Length),
          Integer_4_Signed_C(Pixels(Pixels'first)'Length),
          Integer_4_Unsigned_C(Format),
          Integer_4_Unsigned_C(GL_UNSIGNED_SHORT),
          Pixels'address);
      end Draw_Pixels;
    procedure Draw_Pixels(
      Format : in Integer_4_Unsigned;
      Pixels : in Matrix_Integer_2_Signed) --MATRIX
      is
      begin
        if glDrawPixels = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDrawPixels"                                   & "( " &
          Positive'Wide_Image(Pixels'Length)               & ", " &
          Positive'Wide_Image(Pixels(Pixels'first)'Length) & ", " &
          Get_String(Format)                               & ", " &
          Get_String(GL_SHORT)                             & ", " &
          "'const GLvoid * pixels'"                        & " )" );
        glDrawPixel.All(
          Integer_4_Signed_C(Pixels'Length),
          Integer_4_Signed_C(Pixels(Pixels'first)'Length),
          Integer_4_Unsigned_C(Format),
          Integer_4_Unsigned_C(GL_SHORT),
          Pixels'address);
      end Draw_Pixels;
    procedure Draw_Pixels(
      Format : in Integer_4_Unsigned;
      Pixels : in Matrix_Integer_4_Unsigned) --MATRIX
      is
      begin
        if glDrawPixels = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDrawPixels"                                   & "( " &
          Positive'Wide_Image(Pixels'Length)               & ", " &
          Positive'Wide_Image(Pixels(Pixels'first)'Length) & ", " &
          Get_String(Format)                               & ", " &
          Get_String(GL_UNSIGNED_INT)                      & ", " &
          "'const GLvoid * pixels'"                        & " )" );
        glDrawPixel.All(
          Integer_4_Signed_C(Pixels'Length),
          Integer_4_Signed_C(Pixels(Pixels'first)'Length),
          Integer_4_Unsigned_C(Format),
          Integer_4_Unsigned_C(GL_UNSIGNED_INT),
          Pixels'address);
      end Draw_Pixels;
    procedure Draw_Pixels(
      Format : in Integer_4_Unsigned;
      Pixels : in Matrix_Integer_4_Signed) --MATRIX
      is
      begin
        if glDrawPixels = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glDrawPixels"                                   & "( " &
          Positive'Wide_Image(Pixels'Length)               & ", " &
          Positive'Wide_Image(Pixels(Pixels'first)'Length) & ", " &
          Get_String(Format)                               & ", " &
          Get_String(GL_INT)                               & ", " &
          "'const GLvoid * pixels'"                        & " )" );
        glDrawPixel.All(
          Integer_4_Signed_C(Pixels'Length),
          Integer_4_Signed_C(Pixels(Pixels'first)'Length),
          Integer_4_Unsigned_C(Format),
          Integer_4_Unsigned_C(GL_INT),
          Pixels'address);
      end Draw_Pixels;
  ---------------
  -- Edge_Flag --
  ---------------
    procedure Edge_Flag(
      Flag : in Integer_1_Unsigned)
      is
      begin
        if glEdgeFlag = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEdgeFlag"                        & "( " &
          Integer_1_Unsigned'Wide_Image(Flag) & " )" );
        glEdgeFlag.All(
          Integer_1_Unsigned_C(Flag));
      end Edge_Flag;
    -- procedure Edge_Flag(
    --   Offset  : Integer_4_Signed_C,
    --   Pointer : GLvoid *) --UNKNOWN
    --   is
    --   begin
    --     if glEdgeFlagPointer = null then
    --       raise Call_Failure;
    --     end if;
    --     Put_Line(
    --       "glEdgeFlagPointer"                   & "( " &
    --       Integer_4_Signed_C'Wide_Image(Offset) & ", " &
    --       "'const GLvoid * pointer'"            & " )" &);
    --     glEdgeFlagPointer.All(
    --       Integer_4_Signed_C(Offset),
    --       Pointer'address);
    --   end Edge_Flag;
    procedure Edge_Flag(
      Flag : Integer_1_Unsigned)
      is
      begin
        if glEdgeFlag = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEdgeFlag"                        & "( " &
          Integer_1_Unsigned'Wide_Image(Flag) & " )" );
        glEdgeFlag.All(
          Integer_1_Unsigned_C(Flag);
      end Edge_Flag;
  ------------
  -- Enable --
  ------------
    procedure Enable(
      Cap : in Integer_4_Unsigned)
      is
      begin
        if glEnable = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEnable"      & "( " &
          Get_String(Cap) & " )" );
        glEnable.All(C
          Integer_4_Unsigned_C(Cap));
      end Enable;
  -------------------------
  -- Enable_Client_State --
  -------------------------
    procedure Enable_Client_State(
      State : Integer_4_Unsigned)
      is
      begin
        if glEnableClientState = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEnableClientState" & "( " &
          Get_String(State)     & " )" );
        glEnableClientState.All(
          Integer_4_Unsigned_C(State));
      end Enable_Cliend_State;
  ----------------
  -- End_OpenGL --
  ----------------
    procedure End_Drawing
      is
      begin
        if glEnd = null then
          raise Call_Failure;
        end if;
        Put_Line("glEnd");
        glEnd.All;
      end End_Drawing;
  --------------
  -- End_List --
  --------------
    procedure End_List
      is
      begin
        if glEndList = null then
          raise Call_Failure;
        end if;
        Put_Line("glEndList");
        glEndList.All;
      end End_List;
  -------------------------
  -- Evaluate_Coordinate --
  -------------------------
    procedure Evaluate_Coordinate(
      U : in Float_8_Real)
      is
      begin
        if glEvalCoord1d = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEvalCoord1d"            & "( " &
          Float_8_Real'Wide_Image(U) & " )" );
        glEvalCoord1d.All(
          Float_8_Real_C(U));
      end Evaluate_Coordinate;
    procedure Evaluate_Coordinate(
      U : in Array_Vector_3_Float_8_Real) --VECTOR
      is
      begin
        if glEvalCoord1dv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEvalCoord1dv"       & "( " &
          "'const GLdouble * u'" & " )" );
        glEvalCoord1dv.All(
          U'address);
      end Evaluate_Coordinate;
    procedure Evaluate_Coordinate(
      U : in Float_4_Real)
      is
      begin
        if glEvalCoord1f = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEvalCoord1f"
          Float_4_Real'Wide_Image(U));
        glEvalCoord1f.All(
          Float_4_Real(U));
      end Evaluate_Coordinate;
    procedure Evaluate_Coordinate(
      U : in Array_Vector_3_Float_4_Real) --VECTOR
      is
      begin
        if glEvalCoord1fv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEvalCoord1fv"      & "( " &
          "'const GLfloat * u'" & " )" );
        glEvalCoord1fv.All(
          U'address);
      end Evaluate_Coordinate;
    procedure Evaluate_Coordinate(
      U : in Float_8_Real;
      V : in Float_8_Real)
      is
      begin
        if glEvalCoord2d = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEvalCoord2d"            & "( " &
          Float_8_Real'Wide_Image(U) & ", " &
          Float_8_Real'Wide_Image(V) & " )" );
        glEvalCoord2d.All(
          Float_8_Real_C(U),
          Float_8_Real_C(V));
      end Evaluate_Coordinate;
    procedure Evaluate_Coordinate(
      U : in Array_Vector_3_Float_8_Real) --VECTOR
      is
      begin
        if glEvalCoord2dv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEvalCoord2dv"       & "( " &
          "'const GLdouble * u'" & " )" );
        glEvalCoord2dv.All(
          U'address);
      end Evaluate_Coordinate;
    procedure Evaluate_Coordinate(
      U : in Float_4_Real;
      V : in Float_4_Real)
      is
      begin
        if glEvalCoord2f = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEvalCoord2f"            & "( " &
          Float_4_Real'Wide_Image(U) & ", " &
          Float_4_Real'Wide_Image(V) & " )" );
        glEvalCoord2f.All(
          Float_4_Real_C(U),
          Float_4_Real_C(V));
      end Evaluate_Coordinate;
    procedure Evaluate_Coordinate(
      U : in Access_Constant_Float_4_Real) --VECTOR
      is
      begin
        if glEvalCoord2fv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEvalCoord2fv"
          "'const GLfloat * u'");
        glEvalCoord2fv.All(
          U'address);
      end Evaluate_Coordinate;
  -------------------
  -- Evaluate_Mesh --
  -------------------
    procedure Evaluate_Mesh(
      Mode : in Integer_4_Unsigned;
      I_1  : in Integer_4_Signed;
      J_2  : in Integer_4_Signed)
      is
      begin
        if glEvalMesh1 = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEvalMesh1"         & "( " &
          Get_String(Mode)      & ", " &
          Integer_4_Signed(I_1) & ", " &
          Integer_4_Signed(I_2) & " )" );
        glEvalMesh1.All(
          Integer_4_Unsigned_C(Mode),
          Integer_4_Signed(I_1),
          Integer_4_Signed(I_2));
      end Evaluate_Mesh;
    procedure Evaluate_Mesh(
      Mode : in Integer_4_Unsigned;
      I_1  : in Integer_4_Signed;
      I_2  : in Integer_4_Signed;
      J_1  : in Integer_4_Signed;
      J_2  : in Integer_4_Signed)
      is
      begin
        if glEvalMesh2 = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEvalMesh2"         & "( " &
          Get_String(Mode)      & ", " &
          Integer_4_Signed(I_1) & ", " &
          Integer_4_Signed(I_2) & ", " &
          Integer_4_Signed(J_1) & ", " &
          Integer_4_Signed(J_2) & " )" );
        EvalMesh2.All(
          Integer_4_Unsigned_C(Mode),
          Integer_4_Signed_C(I_1),
          Integer_4_Signed_C(I_2),
          Integer_4_Signed_C(J_1),
          Integer_4_Signed_C(J_2));
      end Evaluate_Mesh;
  --------------------
  -- Evaluate_Point --
  --------------------
    procedure Evaluate_Point(
      I : in Integer_4_Signed)
      is
      begin
        Put_Line(
          "glEvalPoint1"                 & "( " &
          Integer_4_Signed'Wide_Image(I) & " )" );
        Eval_Point_1.All(
          Integer_4_Signed_C(I));
      end Evaluate_Point;
    procedure Evaluate_Point(
      I : in Integer_4_Signed;
      J : in Integer_4_Signed)
      is
      begin
        if glEvalPoint2 = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glEvalPoint2"                 & "( " &
          Integer_4_Signed'Wide_Image(I) & ", " &
          Integer_4_Signed'Wide_Image(J) & " )" );
        glEvalPoint2(
          Integer_4_Signed_C(I),
          Integer_4_Signed_C(J));
      end Evaluate_Point;
  ---------------------
  -- Feedback_Buffer --
  ---------------------
    Function Get_Feedback_Buffer(
      Size   : in     Integer_4_Signed;
      Kind   : in     Integer_4_Unsigned);
      return Array_Float_4_Real
      is
      Output := new Array_Float_4_Real_C(1..Size) := (others => 0.0);
      begin
        if glFeedbackBuffer = null then
          raise Call_Failure;
        end if;
        Put_Line("glFeedbackBuffer"         & "( " &
          Integer_4_Signed'Wide_Image(Size) & ", " &
          Get_String(Kind)                  & ", " &
          "'GLfloat * buffer'"              & " )" );
        glFeedbackBuffer.All(
          Integer_4_Signed_C(Size),
          Integer_4_Unsigned_C(Kind),
          Output'address);
        return To_Array_Float_4_Real(Output);
      end Get_Feedback_Buffer;
  ------------
  -- Finish --
  ------------
    procedure Finish
      is
      begin
        if glFinish = null then
          raise Call_Failure;
        end if;
        Put_Line("glFinish");
        glFinish.All;
      end Finish;
  -----------
  -- Flush --
  -----------
    procedure Flush
      is
      begin
        if glFlush = null then
          raise Call_Failure;
        end if;
        Put_Line("glFlush");
        glFlush.All;
      end Flush;
  ----------
  -- Fog --
  ---------
    procedure Fog(
      Name      : in Integer_4_Unsigned;
      Parameter : in Float_4_Real)
      is
      begin
        if glFogf = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glFogf"                            & "( " &
          Get_String(Name)                    & ", " &
          Float_4_Real'Wide_Image(Parameter) & " )" );
        glFogf.All(
          Integer_4_Unsigned_C(Name),
          Float_4_Real_C(Parameter));
      end Fog;
    procedure Fog(
      Name      : in Integer_4_Unsigned;
      Parameter : in Access_Constant_Float_4_Real) --VECTOR
      is
      begin
        if glFogfv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glFogfv"                  & "( " &
          Get_String(Name)           & ", " &
          "'const GLfloat * params'" & " )" );
        glFogfv.All(
          Integer_4_Unsigned_C(Name),
          Parameter'address);
      end Fog;
    procedure Fog(
      Name      : in Integer_4_Unsigned;
      Parameter : in Integer_4_Signed)
      is
      begin
        if glFogi = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glFogi"                               & "( " &
          Get_String(Name)                       & ", " &
          Integer_4_Signed'Wide_Image(Parameter) & " )" );
        glFogi.All(
          Integer_4_Unsigned_C(Name),
          Integer_4_Signed_C(Parameter));
      end Fog;
    procedure Fog(
      Name      : in Integer_4_Unsigned;
      Parameter : in Access_Constant_Integer_4_Signed) --VECTOR
      is
      begin
        if glFogiv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glFogiv"                & "( " &
          Get_String(Name)         & ", " &
          "'const GLint * params'" & " )" );
        glFogiv.All(
          Integer_4_Unsigned_C(Name),
          Parameter'address);
      end Fog;
  ----------------
  -- Front_Face --
  ----------------
    procedure Front_Face(
      Mode : in Integer_4_Unsigned)
      is
      begin
        if glFrontFace = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glFrontFace"    & "( " &
          Get_String(Mode) & " )" );
        glFrontFace.All(
          Integer_4_Unsigned_C(Mode));
      end Front_Face;
  -------------
  -- Frustum --
  -------------
    procedure Frustum(
      Left   : in Float_8_Real;
      Right  : in Float_8_Real;
      Bottom : in Float_8_Real;
      Top    : in Float_8_Real;
      Z_Near : in Float_8_Real;
      Z_Far  : in Float_8_Real)
      is
      begin
        if glFrustum = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glFrustum"                     & "( " &
          Float_8_Real'Wide_Image(Left)   & ", " &
          Float_8_Real'Wide_Image(Right)  & ", " &
          Float_8_Real'Wide_Image(Bottom) & ", " &
          Float_8_Real'Wide_Image(Top)    & ", " &
          Float_8_Real'Wide_Image(Z_Near) & ", " &
          Float_8_Real'Wide_Image(Z_Far)  & " )" );
        glFrustum.All(
          Float_8_Real_C(Left),
          Float_8_Real_C(Right),
          Float_8_Real_C(Bottom),
          Float_8_Real_C(Top),
          Float_8_Real_C(Z_Near),
          Float_8_Real_C(Z_Far));
      end Frustum;
  --------------------
  -- Generate_Lists --
  --------------------
    function Generate_Lists(
      Bounds : in Integer_4_Signed)
      return Integer_4_Unsigned
      is
      begin
        if glGenLists = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glGenLists"             & "( " &
          Integer_4_Signed(Bounds) & " )" );
        return Integer_4_Unsigned(
          glGenLists.All(
            Integer_4_Unsigned_C(Bounds)));
      end Generate_Lists;
  -----------------------
  -- Generate_Textures --
  -----------------------
    function Generate_Textures(
      Size : in Integer_4_Positive)
      return Array_Integer_4_Unsigned
      is
      Output : Array_Integer_4_Unsigned_C(1..Size) := (others => 0);
      begin
        if glGenTextures = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glGenTextures"                     & "( " &
          Integer_4_Positive'Wide_Image(Size) & " )" );
        if(Size > Integer_4_Signed_C'last){
          Put_Line("Warning in function glGenTextures: Parameter 'size' is greater than Integer_4_Signed'last.");
          Size := Integer_4_Positive(Integer_4_Signed_C'last);
        }
        glGenTextures.All(
          Integer_4_Signed_C(Size),
          Output'address);
        return To_Array_Integer_4_Unsigned(Output);
      end Generate_Textures;
  ---------------
  -- Get_Bytes --
  ---------------
    function Get_Bytes(
      Name : in Integer_4_Unsigned)
      return Array_Integer_1_Unsigned
      is
      Output : Access_Array_Integer_1_Unsigned_C := new Array_Integer_1_Unsigned_C;
      begin
        if glGetBooleanv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glGetBooleanv"        & "( " &
          Get_String(Name)       & ", " &
          "'GLboolean * params'" & " )" );
        glGetBooleanv.All(
          Integer_4_Unsigned_C(Name),
          Output'address);
        return To_Array_Integer_1_Unsigned(Address_To_Access_Unbounded_Array(Output'address));
      end Get_Bytes;
  --------------------
  -- Get_Clip_Plane --
  --------------------
    function Get_Clip_Plane(
      Plane    : in Integer_4_Unsigned)
      return Vector_4_Float_8_Real       --VECTOR
      is
      Equation : Vector_4_Float_8_Real_C;
      begin
        if glGetClipPlane = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glGetClipPlane"        & "( " &
          Get_String(Plane)       & ", " &
          "'GLdouble * equation'" & " )" );
        glGetClipPlane.All(
          Integer_4_Unsigned_C(Plane),
          Equation'address);
        return To_Vector_4_Float_8_Real_C(Equation);
      end Get_Clip_Plane;
  ----------------
  -- Get_Double --
  ----------------
    function Get_Double(
      Name : in Integer_4_Unsigned)
      return Array_Float_8_Real
      is
      Output : Float_8_Real_C := 0.0;
      begin
        if glGetDoublev = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glGetDoublev"        & "( " &
          Get_String(Name)      & ", " &
          "'GLdouble * params'" & " )" );
        glGetDoublev.All(
          Integer_4_Unsigned_C(Name),
          Output'address);
        return
          To_Array_Float_8_Real(
            Address_To_Access_Unbounded_Array(
              Output'access));
      end Get_Double;
  ---------------
  -- Get_Error --
  ---------------
    function Get_Error
      return Integer_4_Unsigned
      is
      begin
        if glGetError = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glGetError");
        return Integer_4_Unsigned(glGetError.All);
      end Get_Error;
  ---------------
  -- Get_Float --
  ---------------
    function Get_Float(
      Name : in Integer_4_Unsigned)
      return Array_Float_4_Real
      is
      Output : Float_4_Real_C := 0.0;
      begin
        if glGetFloatv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glGetFloatv"        & "( " &
          Get_String(Name)     & ", " &
          "'GLfloat * params'" & " )" );
        glGetFloatv.All(
          Integer_4_Unsigned(Name),
          Output'address);
        return
          To_Array_Float_4_Real(
            Address_To_Access_Unbounded_Array(
              Output'access));
      end Get_Float;
  -----------------
  -- Get_Integer --
  -----------------
    function Get_Integer(
      Name : in Integer_4_Unsigned)
      return Array_Integer_4_Unsigned
      is
      Output : Integer_4_Signed_C
      begin
        if glGetIntegerv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glGetIntegerv"    & "( " &
          Get_String(Name)   & ", " &
          "'GLint * params'" & " )" );
        glGetIntegerv.All(Name, params);
      end Get_Integer;
  ---------------
  -- Get_Light --
  ---------------
    procedure Get_Light(
      Light      : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned)
      return Access_Array_Float_4_Real
      is
      Output : Access_Array_Float
      begin
        if glGetLightfv = null then
          raise Call_Failure;
        end if;
        Put_Line(
          "glGetLightfv"       & "( " &
          Get_String(Light)    & ", " &
          Get_String(Name)     & ", " &
          "'GLfloat * params'" & " )" );
        GetLightfv(
          Integer_4_Unsigned_C(Light),
          Integer_4_Unsigned_C(Name),
          params);
      end Get_Light;
    procedure Get_Light(
      Light      : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Integer_4_Signed)
      is
      begin
        -- unknown type: "GLint *" name: "params"
        Put_Line("glGetLightiv %s %s 'GLint * params'", EnumString(light), EnumString(pname));
        GetLightiv(light, pname, params);
      end Get_Light;
  -------------
  -- Get_Map --
  -------------
    procedure Get_Map(
      Target : in Integer_4_Unsigned;
      Query  : in Integer_4_Unsigned;
      V      : in Access_Float_8_Real)
      is
      begin
        -- unknown type: "GLdouble *" name: "v"
        Put_Line("glGetMapdv %s %s 'GLdouble * v'", EnumString(target), EnumString(query));
        GetMapdv(target, query, v);
      end Get_Map;
    procedure Get_Map(
      Target : in Integer_4_Unsigned;
      Query  : in Integer_4_Unsigned;
      V      : in Access_Float_4_Real)
      is
      begin
        -- unknown type: "GLfloat *" name: "v"
        Put_Line("glGetMapfv %s %s 'GLfloat * v'", EnumString(target), EnumString(query));
        GetMapfv(target, query, v);
      end Get_Map;
    procedure Get_Map(
      Target : in Integer_4_Unsigned;
      Query  : in Integer_4_Unsigned;
      V      : in Access_Integer_4_Signed)
      is
      begin
        -- unknown type: "GLint *" name: "v"
        Put_Line("glGetMapiv %s %s 'GLint * v'", EnumString(target), EnumString(query));
        GetMapiv(target, query, v);
      end Get_Map;
  ------------------
  -- Get_Material --
  ------------------
    procedure Get_Material(
      Face       : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_4_Real)
      is
      begin
        -- unknown type: "GLfloat *" name: "params"
        Put_Line("glGetMaterialfv %s %s 'GLfloat * params'", EnumString(face), EnumString(pname));
        GetMaterialfv(face, pname, params);
      end Get_Material;
    procedure Get_Material(
      Face       : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Integer_4_Signed)
      is
      begin
        -- unknown type: "GLint *" name: "params"
        Put_Line("glGetMaterialiv %s %s 'GLint * params'", EnumString(face), EnumString(pname));
        GetMaterialiv(face, pname, params);
      end Get_Material;
  -------------------
  -- Get_Pixel_Map --
  -------------------
    procedure Get_Pixel_Map(
      Map    : in Integer_4_Unsigned;
      Values : in Access_Float_4_Real)
      is
      begin
        -- unknown type: "GLfloat *" name: "values"
        Put_Line("glGetPixelMapfv %s 'GLfloat * values'", EnumString(map));
        GetPixelMapfv(map, values);
      end Get_Pixel_Map;
    procedure Get_Pixel_Map(
      Map    : in Integer_4_Unsigned;
      Values : in Access_Integer_4_Unsigned)
      is
      begin
        -- unknown type: "GLuint *" name: "values"
        Put_Line("glGetPixelMapuiv %s 'GLuint * values'", EnumString(map));
        GetPixelMapuiv(map, values);
      end Get_Pixel_Map;
    procedure Get_Pixel_Map(
      Map    : in Integer_4_Unsigned;
      Values : in Win32.PWSTR)
      is
      begin
        -- unknown type: "GLushort *" name: "values"
        Put_Line("glGetPixelMapusv %s 'GLushort * values'", EnumString(map));
        GetPixelMapusv(map, values);
      end Get_Pixel_Map;
  -----------------
  -- Get_Pointer --
  -----------------
    procedure Get_Pointer(
      GLenum pname,
      GLvoid* *params)
      is
      begin
        -- unknown type: "GLvoid* *" name: "params"
        Put_Line("glGetPointerv %s 'GLvoid* * params'", EnumString(pname));
        GetPointerv(pname, params);
      end Get_Pointer;
  -------------------------
  -- Get_Polygon_Stipple --
  -------------------------
    procedure Get_Polygon_Stipple(
      Mask : in Access_Integer_1_Unsigned);
      is
      begin
        -- unknown type: "GLubyte *" name: "mask"
        Put_Line("glGetPolygonStipple 'GLubyte * mask'");
        GetPolygonStipple(mask);
      end Get_Polygon_Stipple;
  ----------------
  -- Get_String --
  ----------------
    function Get_String(
      Name : in Integer_4_Unsigned)
      return String_2_C
      is
      begin
        Put_Line(
          "glGetString"                  & "( " &
          Integer_4_Unsigned'Wide_Image(Name) & " )" );
        return To_Wide_String(To_Ada(Get_String(
          Name)));
      end Get_String;
  -----------------------------
  -- Get_Texture_Environment --
  -----------------------------
    procedure Get_Texture_Environment(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_4_Real)
      is
      begin
        -- unknown type: "GLfloat *" name: "params"
        Put_Line("glGetTexEnvfv %s %s 'GLfloat * params'", EnumString(target), EnumString(pname));
        GetTexEnvfv(target, pname, params);
      end Get_Texture_Environment;
    procedure Get_Texture_Environment(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Integer_4_Signed)
      is
      begin
        -- unknown type: "GLint *" name: "params"
        Put_Line("glGetTexEnviv %s %s 'GLint * params'", EnumString(target), EnumString(pname));
        GetTexEnviv(target, pname, params);
      end Get_Texture_Environment;
  ----------------------------
  -- Get_Texture_Generation --
  ----------------------------
    procedure Get_Texture_Generation(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_8_Real)
      is
      begin
        -- unknown type: "GLdouble *" name: "params"
        Put_Line("glGetTexGendv %s %s 'GLdouble * params'", EnumString(coord), EnumString(pname));
        GetTexGendv(coord, pname, params);
      end Get_Texture_Generation;
    procedure Get_Texture_Generation(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_4_Real)
      is
      begin
        -- unknown type: "GLfloat *" name: "params"
        Put_Line("glGetTexGenfv %s %s 'GLfloat * params'", EnumString(coord), EnumString(pname));
        GetTexGenfv(coord, pname, params);
      end Get_Texture_Generation;
    procedure Get_Texture_Generation(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Integer_4_Signed)
      is
      begin
        -- unknown type: "GLint *" name: "params"
        Put_Line("glGetTexGeniv %s %s 'GLint * params'", EnumString(coord), EnumString(pname));
        GetTexGeniv(coord, pname, params);
      end Get_Texture_Generation;
  -----------------------
  -- Get_Texture_Image --
  -----------------------
    procedure Get_Texture_Image(
      Target : in Integer_4_Unsigned;
      Level  : in Integer_4_Signed;
      Format : in Integer_4_Unsigned;
      Kind   : in Integer_4_Unsigned;
      Pixels : in PGLvoid)
      is
      begin
        -- unknown type: "GLvoid *" name: "pixels"
        Put_Line("glGetTexImage %s %d %s %s 'GLvoid * pixels'", EnumString(target), level, EnumString(format), EnumString(type));
        GetTexImage(target, level, format, type, pixels);
      end Get_Texture_Image;
  ---------------------------------
  -- Get_Texture_Level_Parameter --
  ---------------------------------
    procedure Get_Texture_Level_Parameter(
      Target     : in Integer_4_Unsigned;
      Level      : in Integer_4_Signed;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_4_Real)
      is
      begin
        -- unknown type: "GLfloat *" name: "params"
        Put_Line("glGetTexLevelParameterfv %s %d %s 'GLfloat * params'", EnumString(target), level, EnumString(pname));
        GetTexLevelParameterfv(target, level, pname, params);
      end Get_Texture_Level_Parameter;
    procedure Get_Texture_Level_Parameter(
      Target : in Integer_4_Unsigned;
      Level  : in Integer_4_Signed;
      Name   : in Integer_4_Unsigned;
      Parameters : in Access_Integer_4_Signed)
      is
      begin
        -- unknown type: "GLint *" name: "params"
        Put_Line("glGetTexLevelParameteriv %s %d %s 'GLint * params'", EnumString(target), level, EnumString(pname));
        GetTexLevelParameteriv(target, level, pname, params);
      end Get_Texture_Level_Parameter;
  ---------------------------
  -- Get_Texture_Parameter --
  ---------------------------
    procedure Get_Texture_Parameter(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Float_4_Real)
      is
      begin
        -- unknown type: "GLfloat *" name: "params"
        Put_Line("glGetTexParameterfv %s %s 'GLfloat * params'", EnumString(target), EnumString(pname));
        GetTexParameterfv(target, pname, params);
      end Get_Texture_Parameter;
    procedure Get_Texture_Parameter(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Integer_4_Signed)
      is
      begin
        -- unknown type: "GLint *" name: "params"
        Put_Line("glGetTexParameteriv %s %s 'GLint * params'", EnumString(target), EnumString(pname));
        GetTexParameteriv(target, pname, params);
      end Get_Texture_Parameter;
  ----------
  -- Hint --
  ----------
    procedure Hint(
      Target : in Integer_4_Unsigned;
      Mode   : in Integer_4_Unsigned)
      is
      begin
        if glHint = null then
          raise Call_Failure;
        end if;
        Put_Line(
         "glHint"            & "( " &
          Get_String(Target) & ", " &
          Get_String(Mode)   & " )" );
        glHint.All(
          Integer_4_Unsigned_C(Target),
          Integer_4_Unsigned_C(Mode));
      end Hint;
  ----------------
  -- Index_Mask --
  ----------------
    procedure Index_Mask(
      Mask : in Integer_4_Unsigned)
      is
      begin
        Put_Line(
          "glIndexMask"                       & "( " &
          Integer_4_Unsigned'Wide_Image(Mask) & " )" );
        IndexMask(
          Integer_4_Unsigned_C(Mask));
      end Index_Mask;
  -----------
  -- Index --
  -----------
    procedure Index(
      Kind    : Integer_4_Unsigned;
      Stride  : Integer_4_Signed;
      Pointer : const GLvoid *)
      is
      begin
        Put_Line("glIndexPointer %s %d 'const GLvoid * pointer'", EnumString(type), stride);
        IndexPointer(type, stride, pointer);
      end Index;
    procedure Index(
      C : in Float_8_Real)
      is
      begin
        Put_Line("glIndexd %g", c);
        Indexd(c);
      end Index;
    procedure Index(
      C : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "c"
        Put_Line("glIndexdv 'const GLdouble * c'");
        Indexdv(c);
      end Index;
    procedure Index(
      C : in Float_4_Real)
      is
      begin
        Put_Line("glIndexf %g", c);
        Indexf(c);
      end Index;
    procedure Index(
      C : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "c"
        Put_Line("glIndexfv 'const GLfloat * c'");
        Indexfv(c);
      end Index;
    procedure Index(
      C : in Integer_4_Signed)
      is
      begin
        Put_Line("glIndexi %d", c);
        Indexi(c);
      end Index;
    procedure Index(
      C : in Access_Constant_Integer_4_Unsigned)
      is
      begin
        -- unknown type: "const GLint *" name: "c"
        Put_Line("glIndexiv 'const GLint * c'");
        Indexiv(c);
      end Index;
    procedure Index(
      C : in Integer_2_Signed)
      is
      begin
        Put_Line("glIndexs %d", c);
        Indexs(c);
      end Index;
    procedure Index(
      C : in Access_Constant_Integer_2_Signed)
      is
      begin
        -- unknown type: "const GLshort *" name: "c"
        Put_Line("glIndexsv 'const GLshort * c'");
        Indexsv(c);
      end Index;
    procedure Index(
      GLubyte c)
      is
      begin
        Put_Line("glIndexub %d", c);
        Indexub(c);
      end Index;
    procedure Index(
      const GLubyte *c)
      is
      begin
        -- unknown type: "const GLubyte *" name: "c"
        Put_Line("glIndexubv 'const GLubyte * c'");
        Indexubv(c);
      end Index;
  ----------------------
  -- Initialize_Names --
  ----------------------
    procedure Initialize_Names
      is
      begin
        Put_Line("glInitNames");
        InitNames;
      end Initialize_Names;
  ------------------------
  -- Interleaved_Arrays --
  ------------------------
    procedure Interleaved_Arrays(
      GLenum format,
      GLsizei stride,
      const GLvoid *pointer)
      is
      begin
        -- unknown type: "const GLvoid *" name: "pointer"
        Put_Line("glInterleavedArrays %s %d 'const GLvoid * pointer'", EnumString(format), stride);
        InterleavedArrays(format, stride, pointer);
      end Interleaved_Arrays;
  ----------------
  -- Is_Enabled --
  ----------------
    function Is_Enabled(
      Cap : in Integer_4_Unsigned)
      return Boolean
      is
      begin
        Put_Line("glIsEnabled %s", EnumString(cap));
        return dllIsEnabled(cap);
      end Is_Enabled;
  -------------
  -- Is_List --
  -------------
    function Is_List(
      List : in Integer_4_Unsigned)
      return Boolean
      is
      begin
        Put_Line("glIsList %d", list);
        return dllIsList(list);
      end Is_List;
  ----------------
  -- Is_Texture --
  ----------------
    function Is_Texture(
      GLuint texture)
      return Boolean
      is
      begin
        Put_Line("glIsTexture %d", texture);
        return dllIsTexture(texture);
      end Is_Texture;
  -----------------
  -- Light_Model --
  -----------------
    procedure Light_Model(
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real)
      is
      begin
        Put_Line("glLightModelf %s %g", EnumString(pname), param);
        LightModelf(pname, param);
      end Light_Model;
    procedure Light_Model(
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "params"
        Put_Line("glLightModelfv %s 'const GLfloat * params'", EnumString(pname));
        LightModelfv(pname, params);
      end Light_Model;
    procedure Light_Model(
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed)
      is
      begin
        Put_Line("glLightModeli %s %d", EnumString(pname), param);
        LightModeli(pname, param);
      end Light_Model;
    procedure Light_Model(
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Integer_4_Unsigned)
      is
      begin
        -- unknown type: "const GLint *" name: "params"
        Put_Line("glLightModeliv %s 'const GLint * params'", EnumString(pname));
        LightModeliv(pname, params);
      end Light_Model;
  -----------
  -- Light --
  -----------
    procedure Light(
      Light      : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real)
      is
      begin
        Put_Line("glLightf %s %s %g", EnumString(light), EnumString(pname), param);
        Lightf(light, pname, param);
      end Light;
    procedure Light(
      Light      : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "params"
        Put_Line("glLightfv %s %s 'const GLfloat * params'", EnumString(light), EnumString(pname));
        Lightfv(light, pname, params);
      end Light;
    procedure Light(
      Light      : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed)
      is
      begin
        Put_Line("glLighti %s %s %d", EnumString(light), EnumString(pname), param);
        Lighti(light, pname, param);
      end Light;
    procedure Light(
      Light      : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Integer_4_Unsigned)
      is
      begin
        -- unknown type: "const GLint *" name: "params"
        Put_Line("glLightiv %s %s 'const GLint * params'", EnumString(light), EnumString(pname));
        Lightiv(light, pname, params);
      end Light;
  ------------------
  -- Line_Stipple --
  ------------------
    procedure Line_Stipple(
      Factor  : in Integer_4_Signed;
      Pattern : in Integer_2_Unsigned)
      is
      begin
        Put_Line("glLineStipple %d %d", factor, pattern);
        LineStipple(factor, pattern);
      end Line_Stipple;
  ----------------
  -- Line_Width --
  ----------------
    procedure Line_Width(
      Width : in Float_4_Real)
      is
      begin
        Put_Line("glLineWidth %g", width);
        LineWidth(width);
      end Line_Width;
  ---------------
  -- List_Base --
  ---------------
    procedure List_Base(
      Base : in Integer_4_Unsigned)
      is
      begin
        Put_Line("glListBase %d", base);
        ListBase(base);
      end List_Base;
  -------------------
  -- Load_Identity --
  -------------------
    procedure Load_Identity
      is
      begin
        Put_Line("glLoadIdentity");
        LoadIdentity;
      end Load_Identity;
  -----------------
  -- Load_Matrix --
  -----------------
    procedure Load_Matrix(
      M : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "m"
        Put_Line("glLoadMatrixd 'const GLdouble * m'");
        LoadMatrixd(m);
      end Load_Matrix;
    procedure Load_Matrix(
      M : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "m"
        Put_Line("glLoadMatrixf 'const GLfloat * m'");
        LoadMatrixf(m);
      end Load_Matrix;
  ---------------
  -- Load_Name --
  ---------------
    procedure Load_Name(
      Name : in Integer_4_Unsigned)
      is
      begin
        Put_Line("glLoadName %d", name);
        LoadName(name);
      end Load_Name;
  ---------------------
  -- Logic_Operation --
  ---------------------
    procedure Logic_Operation(
      Operation_Code : in Integer_4_Unsigned)
      is
      begin
        Put_Line("glLogicOp %s", EnumString(opcode));
        LogicOp(opcode);
      end Logic_Operation;
  ---------
  -- Map --
  ---------
    procedure Map(
      Target : in Integer_4_Unsigned;
      U_1    : in Float_8_Real;
      U_2    : in Float_8_Real;
      Stride : in Integer_4_Signed;
      Order  : in Integer_4_Signed;
      Points : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "points"
        Put_Line("glMap1d %s %g %g %d %d 'const GLdouble * points'", EnumString(target), u1, u2, stride, order);
        Map1d(target, u1, u2, stride, order, points);
      end Map;
    procedure Map(
      Target : in Integer_4_Unsigned;
      U_1     : in Float_4_Real;
      U_2     : in Float_4_Real;
      Stride : in Integer_4_Signed;
      Order  : in Integer_4_Signed;
      Points : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "points"
        Put_Line("glMap1f %s %g %g %d %d 'const GLfloat * points'", EnumString(target), u1, u2, stride, order);
        Map1f(target, u1, u2, stride, order, points);
      end Map;
    procedure Map(
      Target   : in Integer_4_Unsigned;
      U_1      : in Float_8_Real;
      U_2      : in Float_8_Real;
      U_Stride : in Integer_4_Signed;
      U_Order  : in Integer_4_Signed;
      V_1      : in Float_8_Real;
      V_2      : in Float_8_Real;
      V_Stride : in Integer_4_Signed;
      V_Order  : in Integer_4_Signed;
      Points   : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "points"
        Put_Line("glMap2d %s %g %g %d %d %g %g %d %d 'const GLdouble * points'", EnumString(target), u1, u2, ustride, uorder, v1, v2, vstride, vorder);
        Map2d(target, u1, u2, ustride, uorder, v1, v2, vstride, vorder, points);
      end Map;
    procedure Map(
      Target   : in Integer_4_Unsigned;
      U_1      : in Float_4_Real;
      U_2      : in Float_4_Real;
      U_Stride : in Integer_4_Signed;
      U_Order  : in Integer_4_Signed;
      V_1      : in Float_4_Real;
      V_2      : in Float_4_Real;
      V_Stride : in Integer_4_Signed;
      V_Order  : in Integer_4_Signed;
      Points   : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "points"
        Put_Line("glMap2f %s %g %g %d %d %g %g %d %d 'const GLfloat * points'", EnumString(target), u1, u2, ustride, uorder, v1, v2, vstride, vorder);
        Map2f(target, u1, u2, ustride, uorder, v1, v2, vstride, vorder, points);
      end Map;
  --------------
  -- Map_Grid --
  --------------
    procedure Map_Grid(
      U_N : in Integer_4_Signed;
      U_1 : in Float_8_Real;
      U_2 : in Float_8_Real)
      is
      begin
        Put_Line("glMapGrid1d %d %g %g", un, u1, u2);
        MapGrid1d(un, u1, u2);
      end Map_Grid;
    procedure Map_Grid(
      U_N : in Integer_4_Signed;
      U_1 : in Float_4_Real;
      U_2 : in Float_4_Real)
      is
      begin
        Put_Line("glMapGrid1f %d %g %g", un, u1, u2);
        MapGrid1f(un, u1, u2);
      end Map_Grid;
    procedure Map_Grid(
      U_N : in Integer_4_Signed;
      U_1 : in Float_8_Real;
      U_2 : in Float_8_Real;
      V_N : in Integer_4_Signed;
      V_1 : in Float_8_Real;
      V_2 : in Float_8_Real)
      is
      begin
        Put_Line("glMapGrid2d %d %g %g %d %g %g", un, u1, u2, vn, v1, v2);
        MapGrid2d(un, u1, u2, vn, v1, v2);
      end Map_Grid;
    procedure Map_Grid(
      U_N : in Integer_4_Signed;
      U_1 : in Float_4_Real;
      U_2 : in Float_4_Real;
      V_N : in Integer_4_Signed;
      V_1 : in Float_4_Real;
      V_2 : in Float_4_Real)
      is
      begin
        Put_Line("glMapGrid2f %d %g %g %d %g %g", un, u1, u2, vn, v1, v2);
        MapGrid2f(un, u1, u2, vn, v1, v2);
      end Map_Grid;
  --------------
  -- Material --
  --------------
    procedure Material(
      Face       : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real)
      is
      begin
        Put_Line("glMaterialf %s %s %g", EnumString(face), EnumString(pname), param);
        Materialf(face, pname, param);
      end Material;
    procedure Material(
      Face       : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "params"
        Put_Line("glMaterialfv %s %s 'const GLfloat * params'", EnumString(face), EnumString(pname));
        Materialfv(face, pname, params);
      end Material;
    procedure Material(
      Face       : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed)
      is
      begin
        Put_Line("glMateriali %s %s %d", EnumString(face), EnumString(pname), param);
        Materiali(face, pname, param);
      end Material;
    procedure Material(
      Face       : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "params"
        Put_Line("glMaterialiv %s %s 'const GLint * params'", EnumString(face), EnumString(pname));
        Materialiv(face, pname, params);
      end Material;
  -----------------
  -- Matrix_Mode --
  -----------------
    procedure Matrix_Mode(
      Mode : in Integer_4_Unsigned)
      is
      begin
        Put_Line("glMatrixMode %s", EnumString(mode));
        MatrixMode(mode);
      end Matrix_Mode;
  ---------------------
  -- Multiply_Matrix --
  ---------------------
    procedure Multiply_Matrix(
      M : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "m"
        Put_Line("glMultMatrixd 'const GLdouble * m'");
        MultMatrixd(m);
      end Multiply_Matrix;
    procedure Multiply_Matrix(
      M : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "m"
        Put_Line("glMultMatrixf 'const GLfloat * m'");
        MultMatrixf(m);
      end Multiply_Matrix;
  --------------
  -- New_List --
  --------------
    procedure New_List(
      List : in Integer_4_Unsigned;
      Mode : in Integer_4_Unsigned)
      is
      begin
        Put_Line("glNewList %d %s", list, EnumString(mode));
        NewList(list, mode);
      end New_List;
  ------------
  -- Normal --
  ------------
    procedure Normal(
      N_X : in Integer_1_Unsigned;
      N_Y : in Integer_1_Unsigned;
      N_Z : in Integer_1_Unsigned)
      is
      begin
        Put_Line("glNormal3b %d %d %d", nx, ny, nz);
        Normal3b(nx, ny, nz);
      end Normal;
    procedure Normal(
      V : in Win32.PCSTR)
      is
      begin
        -- unknown type: "const GLbyte *" name: "v"
        Put_Line("glNormal3bv 'const GLbyte * v'");
        Normal3bv(v);
      end Normal;
    procedure Normal(
      N_X : in Float_8_Real;
      N_Y : in Float_8_Real;
      N_Z : in Float_8_Real)
      is
      begin
        Put_Line("glNormal3d %g %g %g", nx, ny, nz);
        Normal3d(nx, ny, nz);
      end Normal;
    procedure Normal(
      V : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "v"
        Put_Line("glNormal3dv 'const GLdouble * v'");
        Normal3dv(v);
      end Normal;
    procedure Normal(
      N_X : in Float_4_Real;
      N_Y : in Float_4_Real;
      N_Z : in Float_4_Real)
      is
      begin
        Put_Line("glNormal3f %g %g %g", nx, ny, nz);
        Normal3f(nx, ny, nz);
      end Normal;
    procedure Normal(
      V : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "v"
        Put_Line("glNormal3fv 'const GLfloat * v'");
        Normal3fv(v);
      end Normal;
    procedure Normal(
      N_X : in Integer_4_Signed;
      N_Y : in Integer_4_Signed;
      N_Z : in Integer_4_Signed)
      is
      begin
        Put_Line("glNormal3i %d %d %d", nx, ny, nz);
        Normal3i(nx, ny, nz);
      end Normal;
    procedure Normal(
      V : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "v"
        Put_Line("glNormal3iv 'const GLint * v'");
        Normal3iv(v);
      end Normal;
    procedure Normal(
      N_X : in Integer_2_Signed;
      N_Y : in Integer_2_Signed;
      N_Z : in Integer_2_Signed)
      is
      begin
        Put_Line("glNormal3s %d %d %d", nx, ny, nz);
        Normal3s(nx, ny, nz);
      end Normal;
    procedure Normal(
      V : in Access_Constant_Integer_2_Signed)
      is
      begin
        -- unknown type: "const GLshort *" name: "v"
        Put_Line("glNormal3sv 'const GLshort * v'");
        Normal3sv(v);
      end Normal;
    procedure Normal(
      GLenum type,
      GLsizei stride,
      const GLvoid *pointer)
      is
      begin
        -- unknown type: "const GLvoid *" name: "pointer"
        Put_Line("glNormalPointer %s %d 'const GLvoid * pointer'", EnumString(type), stride);
        NormalPointer(type, stride, pointer);
      end Normal;
  ------------------
  -- Orthographic --
  ------------------
    procedure Orthographic(
      Left   : in Float_8_Real;
      Right  : in Float_8_Real;
      Bottom : in Float_8_Real;
      Top    : in Float_8_Real;
      Z_Near : in Float_8_Real;
      Z_Far  : in Float_8_Real)
      is
      begin
        Put_Line("glOrtho %g %g %g %g %g %g", left, right, bottom, top, zNear, zFar);
        Ortho(left, right, bottom, top, zNear, zFar);
      end Orthographic;
  ------------------
  -- Pass_Through --
  ------------------
    procedure Pass_Through(
      Token : in Float_4_Real)
      is
      begin
        Put_Line("glPassThrough %g", token);
        PassThrough(token);
      end Pass_Through;
  ---------------
  -- Pixel_Map --
  ---------------
    procedure Pixel_Map(
      Map      : in Integer_4_Unsigned;
      Map_Size : in Integer_4_Signed;
      Values   : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "values"
        Put_Line("glPixelMapfv %s %d 'const GLfloat * values'", EnumString(map), mapsize);
        PixelMapfv(map, mapsize, values);
      end Pixel_Map;
    procedure Pixel_Map(
      Map      : in Integer_4_Unsigned;
      Map_Size : in Integer_4_Signed;
      Values   : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLuint *" name: "values"
        Put_Line("glPixelMapuiv %s %d 'const GLuint * values'", EnumString(map), mapsize);
        PixelMapuiv(map, mapsize, values);
      end Pixel_Map;
    procedure Pixel_Map(
      Map      : in Integer_4_Unsigned;
      Map_Size : in Integer_4_Signed;
      Values   : in Win32.PCWSTR)
      is
      begin
        -- unknown type: "const GLushort *" name: "values"
        Put_Line("glPixelMapusv %s %d 'const GLushort * values'", EnumString(map), mapsize);
        PixelMapusv(map, mapsize, values);
      end Pixel_Map;
  -----------------
  -- Pixel_Store --
  -----------------
    procedure Pixel_Store(
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real)
      is
      begin
        Put_Line("glPixelStoref %s %g", EnumString(pname), param);
        PixelStoref(pname, param);
      end Pixel_Store;
    procedure Pixel_Store(
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed)
      is
      begin
        Put_Line("glPixelStorei %s %d", EnumString(pname), param);
        PixelStorei(pname, param);
      end Pixel_Store;
  --------------------
  -- Pixel_Transfer --
  --------------------
    procedure Pixel_Transfer(
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real)
      is
      begin
        Put_Line("glPixelTransferf %s %g", EnumString(pname), param);
        PixelTransferf(pname, param);
      end Pixel_Transfer;
    procedure Pixel_Transfer(
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed)
      is
      begin
        Put_Line("glPixelTransferi %s %d", EnumString(pname), param);
        PixelTransferi(pname, param);
      end Pixel_Transfer;
  ----------------
  -- Pixel_Zoom --
  ----------------
    procedure Pixel_Zoom(
      X_Factor : in Float_4_Real;
      Y_Factor : in Float_4_Real)
      is
      begin
        Put_Line("glPixelZoom %g %g", xfactor, yfactor);
        PixelZoom(xfactor, yfactor);
      end Pixel_Zoom;
  ----------------
  -- Point_Size --
  ----------------
    procedure Point_Size(
      Size : in Float_4_Real)
      is
      begin
        Put_Line("glPointSize %g", size);
        PointSize(size);
      end Point_Size;
  ------------------
  -- Polygon_Mode --
  ------------------
    procedure Polygon_Mode(
      Face : in Integer_4_Unsigned;
      Mode : in Integer_4_Unsigned)
      is
      begin
        Put_Line("glPolygonMode %s %s", EnumString(face), EnumString(mode));
        PolygonMode(face, mode);
      end Polygon_Mode;
  --------------------
  -- Polygon_Offset --
  --------------------
    procedure Polygon_Offset(
      GLfloat factor,
      GLfloat units)
      is
      begin
        Put_Line("glPolygonOffset %g %g", factor, units);
        PolygonOffset(factor, units);
      end Polygon_Offset;
  ---------------------
  -- Polygon_Stipple --
  ---------------------
    procedure Polygon_Stipple(
      Mask : in Access_Integer_1_Unsigned_C)
      is
      begin
        -- unknown type: "const GLubyte *" name: "mask"
        Put_Line("glPolygonStipple 'const GLubyte * mask'");
        PolygonStipple(mask);
      end Polygon_Stipple;
  -------------------
  -- Pop_Attribute --
  -------------------
    procedure Pop_Attribute
      is
      begin
        Put_Line("glPopAttrib");
        PopAttrib;
      end Pop_Attribute;
  --------------------------
  -- Pop_Client_Attribute --
  --------------------------
    procedure Pop_Client_Attribute
      is
      begin
        Put_Line("glPopClientAttrib");
        PopClientAttrib;
      end Pop_Client_Attribute;
  ----------------
  -- Pop_Matrix --
  ----------------
    procedure Pop_Matrix
      is
      begin
        Put_Line("glPopMatrix");
        PopMatrix;
      end Pop_Matrix;
  --------------
  -- Pop_Name --
  --------------
    procedure Pop_Name
      is
      begin
        Put_Line("glPopName");
        PopName;
      end Pop_Name;
  -------------------------
  -- Prioritize_Textures --
  -------------------------
    procedure Prioritize_Textures(
      GLsizei n,
      const GLuint *textures,
      const GLclampf *priorities)
      is
      begin
        -- unknown type: "const GLuint *" name: "textures"
        -- unknown type: "const GLclampf *" name: "priorities"
        Put_Line("glPrioritizeTextures %d 'const GLuint * textures' 'const GLclampf * priorities'", n);
        PrioritizeTextures(n, textures, priorities);
      end Prioritize_Textures;
  --------------------
  -- Push_Attribute --
  --------------------
    procedure Push_Attribute(
      Mask : in Integer_4_Unsigned)
      is
      begin
        -- unknown type: "GLbitfield" name: "mask"
        Put_Line("glPushAttrib 'GLbitfield mask'");
        PushAttrib(mask);
      end Push_Attribute;
  ---------------------------
  -- Push_Client_Attribute --
  ---------------------------
    procedure Push_Client_Attribute(
      GLbitfield mask)
      is
      begin
        -- unknown type: "GLbitfield" name: "mask"
        Put_Line("glPushClientAttrib 'GLbitfield mask'");
        PushClientAttrib(mask);
      end Push_Client_Attribute;
  -----------------
  -- Push_Matrix --
  -----------------
    procedure Push_Matrix
      is
      begin
        Put_Line("glPushMatrix");
        PushMatrix;
      end Push_Matrix;
  ---------------
  -- Push_Name --
  ---------------
    procedure Push_Name(
      Name : in Integer_4_Unsigned)
      is
      begin
        Put_Line("glPushName %d", name);
        PushName(name);
      end Push_Name;
  ---------------------
  -- Raster_Position --
  ---------------------
    procedure Raster_Position(
      X : in Float_8_Real;
      Y : in Float_8_Real)
      is
      begin
        Put_Line("glRasterPos2d %g %g", x, y);
        RasterPos2d(x, y);
      end Raster_Position;
    procedure Raster_Position(
      V : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "v"
        Put_Line("glRasterPos2dv 'const GLdouble * v'");
        RasterPos2dv(v);
      end Raster_Position;
    procedure Raster_Position(
      X : in Float_4_Real;
      Y : in Float_4_Real)
      is
      begin
        Put_Line("glRasterPos2f %g %g", x, y);
        RasterPos2f(x, y);
      end Raster_Position;
    procedure Raster_Position(
      V : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "v"
        Put_Line("glRasterPos2fv 'const GLfloat * v'");
        RasterPos2fv(v);
      end Raster_Position;
    procedure Raster_Position(
      X : in Integer_4_Signed;
      Y : in Integer_4_Signed)
      is
      begin
        Put_Line("glRasterPos2i %d %d", x, y);
        RasterPos2i(x, y);
      end Raster_Position;
    procedure Raster_Position(
      V : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "v"
        Put_Line("glRasterPos2iv 'const GLint * v'");
        RasterPos2iv(v);
      end Raster_Position;
    procedure Raster_Position(
      X : in Integer_2_Signed;
      Y : in Integer_2_Signed)
      is
      begin
        Put_Line("glRasterPos2s %d %d", x, y);
        RasterPos2s(x, y);
      end Raster_Position;
    procedure Raster_Position(
      V : in Access_Constant_Integer_2_Signed)
      is
      begin
        -- unknown type: "const GLshort *" name: "v"
        Put_Line("glRasterPos2sv 'const GLshort * v'");
        RasterPos2sv(v);
      end Raster_Position;
    procedure Raster_Position(
      X : in Float_8_Real;
      Y : in Float_8_Real;
      Z : in Float_8_Real)
      is
      begin
        Put_Line("glRasterPos3d %g %g %g", x, y, z);
        RasterPos3d(x, y, z);
      end Raster_Position;
    procedure Raster_Position(
      V : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "v"
        Put_Line("glRasterPos3dv 'const GLdouble * v'");
        RasterPos3dv(v);
      end Raster_Position;
    procedure Raster_Position(
      X : in Float_4_Real;
      Y : in Float_4_Real;
      Z : in Float_4_Real)
      is
      begin
        Put_Line("glRasterPos3f %g %g %g", x, y, z);
        RasterPos3f(x, y, z);
      end Raster_Position;
    procedure Raster_Position(
      V : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "v"
        Put_Line("glRasterPos3fv 'const GLfloat * v'");
        RasterPos3fv(v);
      end Raster_Position;
    procedure Raster_Position(
      X : in Integer_4_Signed;
      Y : in Integer_4_Signed;
      Z : in Integer_4_Signed)
      is
      begin
        Put_Line("glRasterPos3i %d %d %d", x, y, z);
        RasterPos3i(x, y, z);
      end Raster_Position;
    procedure Raster_Position(
      V : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "v"
        Put_Line("glRasterPos3iv 'const GLint * v'");
        RasterPos3iv(v);
      end Raster_Position;
    procedure Raster_Position(
      X : in Integer_2_Signed;
      Y : in Integer_2_Signed;
      Z : in Integer_2_Signed)
      is
      begin
        Put_Line("glRasterPos3s %d %d %d", x, y, z);
        RasterPos3s(x, y, z);
      end Raster_Position;
    procedure Raster_Position(
      V : in Access_Constant_Integer_2_Signed)
      is
      begin
        -- unknown type: "const GLshort *" name: "v"
        Put_Line("glRasterPos3sv 'const GLshort * v'");
        RasterPos3sv(v);
      end Raster_Position;
    procedure Raster_Position(
      X : in Float_8_Real;
      Y : in Float_8_Real;
      Z : in Float_8_Real;
      W : in Float_8_Real)
      is
      begin
        Put_Line("glRasterPos4d %g %g %g %g", x, y, z, w);
        RasterPos4d(x, y, z, w);
      end Raster_Position;
    procedure Raster_Position(
      V : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "v"
        Put_Line("glRasterPos4dv 'const GLdouble * v'");
        RasterPos4dv(v);
      end Raster_Position;
    procedure Raster_Position(
      X : in Float_4_Real;
      Y : in Float_4_Real;
      Z : in Float_4_Real;
      W : in Float_4_Real)
      is
      begin
        Put_Line("glRasterPos4f %g %g %g %g", x, y, z, w);
        RasterPos4f(x, y, z, w);
      end Raster_Position;
    procedure Raster_Position(
      V : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "v"
        Put_Line("glRasterPos4fv 'const GLfloat * v'");
        RasterPos4fv(v);
      end Raster_Position;
    procedure Raster_Position(
      X : in Integer_4_Signed;
      Y : in Integer_4_Signed;
      Z : in Integer_4_Signed;
      W : in Integer_4_Signed)
      is
      begin
        Put_Line("glRasterPos4i %d %d %d %d", x, y, z, w);
        RasterPos4i(x, y, z, w);
      end Raster_Position;
    procedure Raster_Position(
      V : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "v"
        Put_Line("glRasterPos4iv 'const GLint * v'");
        RasterPos4iv(v);
      end Raster_Position;
    procedure Raster_Position(
      X : in Integer_2_Signed;
      Y : in Integer_2_Signed;
      Z : in Integer_2_Signed;
      W : in Integer_2_Signed)
      is
      begin
        Put_Line("glRasterPos4s %d %d %d %d", x, y, z, w);
        RasterPos4s(x, y, z, w);
      end Raster_Position;
    procedure Raster_Position(
      V : in Access_Constant_Integer_2_Signed
      is
      begin
        -- unknown type: "const GLshort *" name: "v"
        Put_Line("glRasterPos4sv 'const GLshort * v'");
        RasterPos4sv(v);
      end Raster_Position;
  -----------------
  -- Read_Buffer --
  -----------------
    procedure Read_Buffer(
      Mode : in Integer_4_Unsigned)
      is
      begin
        Put_Line("glReadBuffer %s", EnumString(mode));
        ReadBuffer(mode);
      end Read_Buffer;
  -----------------
  -- Read_Pixels --
  -----------------
    procedure Read_Pixels(
      X      : in Integer_4_Signed;
      Y      : in Integer_4_Signed;
      Width  : in Integer_4_Signed;
      Height : in Integer_4_Signed;
      Format : in Integer_4_Unsigned;
      Kind   : in Integer_4_Unsigned;
      Pixels : in PGLvoid)
      is
      begin
        -- unknown type: "GLvoid *" name: "pixels"
        Put_Line("glReadPixels %d %d %d %d %s %s 'GLvoid * pixels'", x, y, width, height, EnumString(format), EnumString(type));
        ReadPixels(x, y, width, height, format, type, pixels);
      end Read_Pixels;
  ---------------
  -- Rectangle --
  ---------------
    procedure Rectangle(
      X_1 : in Float_8_Real;
      Y_1 : in Float_8_Real;
      X_2 : in Float_8_Real;
      Y_2 : in Float_8_Real)
      is
      begin
        Put_Line("glRectd %g %g %g %g", x1, y1, x2, y2);
        Rectd(x1, y1, x2, y2);
      end Rectangle;
    procedure Rectangle(
      V_1 : in Access_Constant_Float_8_Real;
      V_2 : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "v1"
        -- unknown type: "const GLdouble *" name: "v2"
        Put_Line("glRectdv 'const GLdouble * v1' 'const GLdouble * v2'");
        Rectdv(v1, v2);
      end Rectangle;
    procedure Rectangle(
      X_1 : in Float_4_Real;
      Y_1 : in Float_4_Real;
      X_2 : in Float_4_Real;
      Y_2 : in Float_4_Real)
      is
      begin
        Put_Line("glRectf %g %g %g %g", x1, y1, x2, y2);
        Rectf(x1, y1, x2, y2);
      end Rectangle;
    procedure Rectangle(
      V_1 : in Access_Constant_Float_4_Real;
      V_2 : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "v1"
        -- unknown type: "const GLfloat *" name: "v2"
        Put_Line("glRectfv 'const GLfloat * v1' 'const GLfloat * v2'");
        Rectfv(v1, v2);
      end Rectangle;
    procedure Rectangle(
      X_1 : in Integer_4_Signed;
      Y_1 : in Integer_4_Signed;
      X_2 : in Integer_4_Signed;
      Y_2 : in Integer_4_Signed)
      is
      begin
        Put_Line("glRecti %d %d %d %d", x1, y1, x2, y2);
        Recti(x1, y1, x2, y2);
      end Rectangle;
    procedure Rectangle(
      V_1 : in Access_Constant_Integer_4_Signed;
      V_2 : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "v1"
        -- unknown type: "const GLint *" name: "v2"
        Put_Line("glRectiv 'const GLint * v1' 'const GLint * v2'");
        Rectiv(v1, v2);
      end Rectangle;
    procedure Rectangle(
      X_1 : in Integer_2_Signed;
      Y_1 : in Integer_2_Signed;
      X_2 : in Integer_2_Signed;
      Y_2 : in Integer_2_Signed)
      is
      begin
        Put_Line("glRects %d %d %d %d", x1, y1, x2, y2);
        Rects(x1, y1, x2, y2);
      end Rectangle;
    procedure Rectangle(
      V_1 : in Access_Constant_Integer_2_Signed;
      V_2 : in Access_Constant_Integer_2_Signed)
      is
      begin
        -- unknown type: "const GLshort *" name: "v1"
        -- unknown type: "const GLshort *" name: "v2"
        Put_Line("glRectsv 'const GLshort * v1' 'const GLshort * v2'");
        Rectsv(v1, v2);
      end Rectangle;
  -----------------
  -- Render_Mode --
  -----------------
    function Render_Mode(
      Mode : in Integer_4_Unsigned)
      return Integer_4_Signed
      is
      begin
        Put_Line("glRenderMode %s", EnumString(mode));
        return dllRenderMode(mode);
      end Render_Mode;
  ------------
  -- Rotate --
  ------------
    procedure Rotate(
      Angle : in Float_8_Real;
      X     : in Float_8_Real;
      Y     : in Float_8_Real;
      Z     : in Float_8_Real)
      is
      begin
        Put_Line("glRotated %g %g %g %g", angle, x, y, z);
        Rotated(angle, x, y, z);
      end Rotate;
    procedure Rotate(
      Angle : in Float_4_Real;
      X     : in Float_4_Real;
      Y     : in Float_4_Real;
      Z     : in Float_4_Real)
      is
      begin
        Put_Line("glRotatef %g %g %g %g", angle, x, y, z);
        Rotatef(angle, x, y, z);
      end Rotate;
  -----------
  -- Scale --
  -----------
    procedure Scale(
      X : in Float_8_Real;
      Y : in Float_8_Real;
      Z : in Float_8_Real)
      is
      begin
        Put_Line("glScaled %g %g %g", x, y, z);
        Scaled(x, y, z);
      end Scale;
    procedure Scale(
      X : in Float_4_Real;
      Y : in Float_4_Real;
      Z : in Float_4_Real)
      is
      begin
        Put_Line("glScalef %g %g %g", x, y, z);
        Scalef(x, y, z);
      end Scale;
  -------------
  -- Scissor --
  -------------
    procedure Scissor(
      X      : in Integer_4_Signed;
      Y      : in Integer_4_Signed;
      Width  : in Integer_4_Signed;
      Height : in Integer_4_Signed)
      is
      begin
        Put_Line("glScissor %d %d %d %d", x, y, width, height);
        Scissor(x, y, width, height);
      end Scissor;
  -------------------
  -- Select_Buffer --
  -------------------
    procedure Select_Buffer(
      Size   : in Integer_4_Signed;
      Buffer : in Access_Integer_4_Unsigned)
      is
      begin
        if ---
          raise Call_Failure;
        end if;
        -- unknown type: "GLuint *" name: "buffer"
        Put_Line("glSelectBuffer %d 'GLuint * buffer'", size);
        SelectBuffer(size, buffer);
      end Select_Buffer;
  -----------------
  -- Shade_Model --
  -----------------
    procedure Shade_Model(
      Mode : in Integer_4_Unsigned)
      is
      begin
        Put_Line("glShadeModel %s", EnumString(mode));
        ShadeModel(mode);
      end Shade_Model;
  ----------------------
  -- Stencil_Function --
  ----------------------
    procedure Stencil_Function(
      Function  : in Integer_4_Unsigned;
      Reference : in Integer_4_Signed;
      Mask      : in Integer_4_Unsigned)
      is
      begin
        Put_Line("glStencilFunc %s %d %d", EnumString(func), ref, mask);
        StencilFunc(func, ref, mask);
      end Stencil_Function;
  ------------------
  -- Stencil_Mask --
  ------------------
    procedure Stencil_Mask(
      Mask : in Integer_4_Unsigned)
      is
      begin
        Put_Line("glStencilMask %d", mask);
        StencilMask(mask);
      end Stencil_Mask;
  -----------------------
  -- Stencil_Operation --
  -----------------------
    procedure Stencil_Operation(
      Fail   : in Integer_4_Unsigned;
      Z_Fail : in Integer_4_Unsigned;
      Z_Pass : in Integer_4_Unsigned)
      is
      begin
        Put_Line("glStencilOp %s %s %s", EnumString(fail), EnumString(zfail), EnumString(zpass));
        StencilOp(fail, zfail, zpass);
      end Stencil_Operation;
  ------------------------
  -- Texture_Coordinate --
  ------------------------
    procedure Texture_Coordinate(
      S : in Float_8_Real)
      is
      begin
        Put_Line("glTexCoord1d %g", s);
        TexCoord1d(s);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "v"
        Put_Line("glTexCoord1dv 'const GLdouble * v'");
        TexCoord1dv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Float_4_Real)
      is
      begin
        Put_Line("glTexCoord1f %g", s);
        TexCoord1f(s);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "v"
        Put_Line("glTexCoord1fv 'const GLfloat * v'");
        TexCoord1fv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Integer_4_Signed)
        Put_Line("glTexCoord1i %d", s);
        TexCoord1i(s);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "v"
        Put_Line("glTexCoord1iv 'const GLint * v'");
        TexCoord1iv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Integer_2_Signed)
      is
      begin
        Put_Line("glTexCoord1s %d", s);
        TexCoord1s(s);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_2_Signed)
      is
      begin
        -- unknown type: "const GLshort *" name: "v"
        Put_Line("glTexCoord1sv 'const GLshort * v'");
        TexCoord1sv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Float_8_Real;
      T : in Float_8_Real)
      is
      begin
        Put_Line("glTexCoord2d %g %g", s, t);
        TexCoord2d(s, t);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "v"
        Put_Line("glTexCoord2dv 'const GLdouble * v'");
        TexCoord2dv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Float_4_Real;
      T : in Float_4_Real)
      is
      begin
        Put_Line("glTexCoord2f %g %g", s, t);
        TexCoord2f(s, t);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "v"
        Put_Line("glTexCoord2fv 'const GLfloat * v'");
        TexCoord2fv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Integer_4_Signed;
      T : in Integer_4_Signed)
      is
      begin
        Put_Line("glTexCoord2i %d %d", s, t);
        TexCoord2i(s, t);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "v"
        Put_Line("glTexCoord2iv 'const GLint * v'");
        TexCoord2iv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Integer_2_Signed;
      T : in Integer_2_Signed)
      is
      begin
        Put_Line("glTexCoord2s %d %d", s, t);
        TexCoord2s(s, t);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_2_Signed)
      is
      begin
        -- unknown type: "const GLshort *" name: "v"
        Put_Line("glTexCoord2sv 'const GLshort * v'");
        TexCoord2sv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Float_8_Real;
      T : in Float_8_Real;
      R : in Float_8_Real)
      is
      begin
        Put_Line("glTexCoord3d %g %g %g", s, t, r);
        TexCoord3d(s, t, r);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "v"
        Put_Line("glTexCoord3dv 'const GLdouble * v'");
        TexCoord3dv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Float_4_Real;
      T : in Float_4_Real;
      R : in Float_4_Real)
      is
      begin
        Put_Line("glTexCoord3f %g %g %g", s, t, r);
        TexCoord3f(s, t, r);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "v"
        Put_Line("glTexCoord3fv 'const GLfloat * v'");
        TexCoord3fv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Integer_4_Signed;
      T : in Integer_4_Signed;
      R : in Integer_4_Signed)
      is
      begin
        Put_Line("glTexCoord3i %d %d %d", s, t, r);
        TexCoord3i(s, t, r);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "v"
        Put_Line("glTexCoord3iv 'const GLint * v'");
        TexCoord3iv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Integer_2_Signed;
      T : in Integer_2_Signed;
      R : in Integer_2_Signed)
      is
      begin
        Put_Line("glTexCoord3s %d %d %d", s, t, r);
        TexCoord3s(s, t, r);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_2_Signed)
      is
      begin
        -- unknown type: "const GLshort *" name: "v"
        Put_Line("glTexCoord3sv 'const GLshort * v'");
        TexCoord3sv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Float_8_Real;
      T : in Float_8_Real;
      R : in Float_8_Real;
      Q : in Float_8_Real)
      is
      begin
        Put_Line("glTexCoord4d %g %g %g %g", s, t, r, q);
        TexCoord4d(s, t, r, q);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "v"
        Put_Line("glTexCoord4dv 'const GLdouble * v'");
        TexCoord4dv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Float_4_Real;
      T : in Float_4_Real;
      R : in Float_4_Real;
      Q : in Float_4_Real)
      is
      begin
        Put_Line("glTexCoord4f %g %g %g %g", s, t, r, q);
        TexCoord4f(s, t, r, q);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "v"
        Put_Line("glTexCoord4fv 'const GLfloat * v'");
        TexCoord4fv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Integer_4_Signed;
      T : in Integer_4_Signed;
      R : in Integer_4_Signed;
      Q : in Integer_4_Signed)
      is
      begin
        Put_Line("glTexCoord4i %d %d %d %d", s, t, r, q);
        TexCoord4i(s, t, r, q);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "v"
        Put_Line("glTexCoord4iv 'const GLint * v'");
        TexCoord4iv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      S : in Integer_2_Signed;
      T : in Integer_2_Signed;
      R : in Integer_2_Signed;
      Q : in Integer_2_Signed)
      is
      begin
        Put_Line("glTexCoord4s %d %d %d %d", s, t, r, q);
        TexCoord4s(s, t, r, q);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      V : in Access_Constant_Integer_2_Signed)
      is
      begin
        -- unknown type: "const GLshort *" name: "v"
        Put_Line("glTexCoord4sv 'const GLshort * v'");
        TexCoord4sv(v);
      end Texture_Coordinate;
    procedure Texture_Coordinate(
      GLint size,
      GLenum type,
      GLsizei stride,
      const GLvoid *pointer)
      is
      begin
        -- unknown type: "const GLvoid *" name: "pointer"
        Put_Line("glTexCoordPointer %d %s %d 'const GLvoid * pointer'", size, EnumString(type), stride);
        TexCoordPointer(size, type, stride, pointer);
      end Texture_Coordinate;
  -------------------------
  -- Texture_Environment --
  -------------------------
    procedure Texture_Environment(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real)
      is
      begin
        Put_Line("glTexEnvf %s %s %g", EnumString(target), EnumString(pname), param);
        TexEnvf(target, pname, param);
      end Texture_Environment;
    procedure Texture_Environment(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "params"
        Put_Line("glTexEnvfv %s %s 'const GLfloat * params'", EnumString(target), EnumString(pname));
        TexEnvfv(target, pname, params);
      end Texture_Environment;
    procedure Texture_Environment(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed)
      is
      begin
        Put_Line("glTexEnvi %s %s %d", EnumString(target), EnumString(pname), param);
        TexEnvi(target, pname, param);
      end Texture_Environment;
    procedure Texture_Environment(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "params"
        Put_Line("glTexEnviv %s %s 'const GLint * params'", EnumString(target), EnumString(pname));
        TexEnviv(target, pname, params);
      end Texture_Environment;
  ----------------------
  -- Texture_Generate --
  ----------------------
    procedure Texture_Generate(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_8_Real)
      is
      begin
        Put_Line("glTexGend %s %s %g", EnumString(coord), EnumString(pname), param);
        TexGend(coord, pname, param);
      end Texture_Generate;
    procedure Texture_Generate(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "params"
        Put_Line("glTexGendv %s %s 'const GLdouble * params'", EnumString(coord), EnumString(pname));
        TexGendv(coord, pname, params);
      end Texture_Generate;
    procedure Texture_Generate(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real)
      is
      begin
        Put_Line("glTexGenf %s %s %g", EnumString(coord), EnumString(pname), param);
        TexGenf(coord, pname, param);
      end Texture_Generate;
    procedure Texture_Generate(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "params"
        Put_Line("glTexGenfv %s %s 'const GLfloat * params'", EnumString(coord), EnumString(pname));
        TexGenfv(coord, pname, params);
      end Texture_Generate;
    procedure Texture_Generate(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed)
      is
      begin
        Put_Line("glTexGeni %s %s %d", EnumString(coord), EnumString(pname), param);
        TexGeni(coord, pname, param);
      end Texture_Generate;
    procedure Texture_Generate(
      Coordinate : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "params"
        Put_Line("glTexGeniv %s %s 'const GLint * params'", EnumString(coord), EnumString(pname));
        TexGeniv(coord, pname, params);
      end Texture_Generate;
  ----------------------
  -- Texture_Image_1D --
  ----------------------
    procedure Texture_Image_1D(
      Target     : in Integer_4_Unsigned;
      level      : in Integer_4_Signed;
      components : in Integer_4_Signed;
      Width      : in Integer_4_Signed;
      Border     : in Integer_4_Signed;
      Format     : in Integer_4_Unsigned;
      Kind       : in Integer_4_Unsigned;
      Pixels     : in Win32.PCVOID)
      is
      begin
        -- unknown type: "const GLvoid *" name: "pixels"
        Put_Line("glTexImage1D %s %d %d %d %d %s %s 'const GLvoid * pixels'", EnumString(target), level, internalformat, width, border, EnumString(format), EnumString(type));
        TexImage1D(target, level, internalformat, width, border, format, type, pixels);
      end Texture_Image_1D;
  ----------------------
  -- Texture_Image_2D --
  ----------------------
    procedure Texture_Image_2D(
      Target     : in Integer_4_Unsigned;
      level      : in Integer_4_Signed;
      components : in Integer_4_Signed;
      Width      : in Integer_4_Signed;
      Height     : in Integer_4_Signed;
      Border     : in Integer_4_Signed;
      Format     : in Integer_4_Unsigned;
      Kind       : in Integer_4_Unsigned;
      Pixels     : in Win32.PCVOID)
      is
      begin
        -- unknown type: "const GLvoid *" name: "pixels"
        Put_Line("glTexImage2D %s %d %d %d %d %d %s %s 'const GLvoid * pixels'", EnumString(target), level, internalformat, width, height, border, EnumString(format), EnumString(type));
        TexImage2D(target, level, internalformat, width, height, border, format, type, pixels);
      end Texture_Image_2D;
  -----------------------
  -- Texture_Parameter --
  -----------------------
    procedure Texture_Parameter(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Float_4_Real)
      is
      begin
        Put_Line("glTexParameterf %s %s %g", EnumString(target), EnumString(pname), param);
        TexParameterf(target, pname, param);
      end Texture_Parameter;
    procedure Texture_Parameter(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "params"
        Put_Line("glTexParameterfv %s %s 'const GLfloat * params'", EnumString(target), EnumString(pname));
        TexParameterfv(target, pname, params);
      end Texture_Parameter;
    procedure Texture_Parameter(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Integer_4_Signed)
      is
      begin
        Put_Line("glTexParameteri %s %s %d", EnumString(target), EnumString(pname), param);
        TexParameteri(target, pname, param);
      end Texture_Parameter;
    procedure Texture_Parameter(
      Target     : in Integer_4_Unsigned;
      Name       : in Integer_4_Unsigned;
      Parameters : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "params"
        Put_Line("glTexParameteriv %s %s 'const GLint * params'", EnumString(target), EnumString(pname));
        TexParameteriv(target, pname, params);
      end Texture_Parameter;
  -------------------------
  -- Texture_Subimage_1D --
  -------------------------
    procedure Texture_Subimage_1D(
      GLenum target,
      GLint level,
      GLint xoffset,
      GLsizei width,
      GLenum format,
      GLenum type,
      const GLvoid *pixels)
      is
      begin
        -- unknown type: "const GLvoid *" name: "pixels"
        Put_Line("glTexSubImage1D %s %d %d %d %s %s 'const GLvoid * pixels'", EnumString(target), level, xoffset, width, EnumString(format), EnumString(type));
        TexSubImage1D(target, level, xoffset, width, format, type, pixels);
      end Texture_Subimage_1D;
  -------------------------
  -- Texture_Subimage_2D --
  -------------------------
    procedure Texture_Subimage_2D(
      GLenum target,
      GLint level,
      GLint xoffset,
      GLint yoffset,
      GLsizei width,
      GLsizei height,
      GLenum format,
      GLenum type,
      const GLvoid *pixels)
      is
      begin
        -- unknown type: "const GLvoid *" name: "pixels"
        Put_Line("glTexSubImage2D %s %d %d %d %d %d %s %s 'const GLvoid * pixels'", EnumString(target), level, xoffset, yoffset, width, height, EnumString(format), EnumString(type));
        TexSubImage2D(target, level, xoffset, yoffset, width, height, format, type, pixels);
      end Texture_Subimage_2D;
  ---------------
  -- Translate --
  ---------------
    procedure Translate(
      X : in Float_8_Real;
      Y : in Float_8_Real;
      Z : in Float_8_Real)
      is
      begin
        Put_Line("glTranslated %g %g %g", x, y, z);
        Translated(x, y, z);
      end Translate;
    procedure Translate(
      X : in Float_4_Real;
      Y : in Float_4_Real;
      Z : in Float_4_Real)
      is
      begin
        Put_Line("glTranslatef %g %g %g", x, y, z);
        Translatef(x, y, z);
      end Translate;
  ------------
  -- Vertex --
  ------------
    procedure Vertex(
      X : in Float_8_Real;
      Y : in Float_8_Real)
      is
      begin
        Put_Line("glVertex2d %g %g", x, y);
        Vertex2d(x, y);
      end ;
    procedure Vertex(
      V : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "v"
        Put_Line("glVertex2dv 'const GLdouble * v'");
        Vertex2dv(v);
      end ;
    procedure Vertex(
      X : in Float_4_Real;
      Y : in Float_4_Real)
      is
      begin
        Put_Line("glVertex2f %g %g", x, y);
        Vertex2f(x, y);
      end ;
    procedure Vertex(
      V : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "v"
        Put_Line("glVertex2fv 'const GLfloat * v'");
        Vertex2fv(v);
      end Vertex;
    procedure Vertex(
      X : in Integer_4_Signed;
      Y : in Integer_4_Signed)
      is
      begin
        Put_Line("glVertex2i %d %d", x, y);
        Vertex2i(x, y);
      end Vertex;
    procedure Vertex(
      V : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "v"
        Put_Line("glVertex2iv 'const GLint * v'");
        Vertex2iv(v);
      end Vertex;
    procedure Vertex(
      X : in Integer_2_Signed;
      Y : in Integer_2_Signed)
      is
      begin
        Put_Line("glVertex2s %d %d", x, y);
        Vertex2s(x, y);
      end Vertex;
    procedure Vertex(
      V : in Access_Constant_Integer_2_Signed)
      is
      begin
        -- unknown type: "const GLshort *" name: "v"
        Put_Line("glVertex2sv 'const GLshort * v'");
        Vertex2sv(v);
      end Vertex;
    procedure Vertex(
      X : in Float_8_Real;
      Y : in Float_8_Real;
      Z : in Float_8_Real)
      is
      begin
        Put_Line("glVertex3d %g %g %g", x, y, z);
        Vertex3d(x, y, z);
      end Vertex;
    procedure Vertex(
      V : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "v"
        Put_Line("glVertex3dv 'const GLdouble * v'");
        Vertex3dv(v);
      end Vertex;
    procedure Vertex(
      X : in Float_4_Real;
      Y : in Float_4_Real;
      Z : in Float_4_Real)
      is
      begin
        Put_Line("glVertex3f %g %g %g", x, y, z);
        Vertex3f(x, y, z);
      end Vertex;
    procedure Vertex(
      V : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "v"
        Put_Line("glVertex3fv 'const GLfloat * v'");
        Vertex3fv(v);
      end Vertex;
    procedure Vertex(
      X : in Integer_4_Signed;
      Y : in Integer_4_Signed;
      Z : in Integer_4_Signed)
      is
      begin
        Put_Line("glVertex3i %d %d %d", x, y, z);
        Vertex3i(x, y, z);
      end Vertex;
    procedure Vertex(
      V : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "v"
        Put_Line("glVertex3iv 'const GLint * v'");
        Vertex3iv(v);
      end Vertex;
    procedure Vertex(
      X : in Integer_2_Signed;
      Y : in Integer_2_Signed;
      Z : in Integer_2_Signed)
      is
      begin
        Put_Line("glVertex3s %d %d %d", x, y, z);
        Vertex3s(x, y, z);
      end Vertex;
    procedure Vertex(
      V : in Access_Constant_Integer_2_Signed)
      is
      begin
        -- unknown type: "const GLshort *" name: "v"
        Put_Line("glVertex3sv 'const GLshort * v'");
        Vertex3sv(v);
      end Vertex;
    procedure Vertex(
      X : in Float_8_Real;
      Y : in Float_8_Real;
      Z : in Float_8_Real;
      W : in Float_8_Real)
      is
      begin
        Put_Line("glVertex4d %g %g %g %g", x, y, z, w);
        Vertex4d(x, y, z, w);
      end Vertex;
    procedure Vertex(
      V : in Access_Constant_Float_8_Real)
      is
      begin
        -- unknown type: "const GLdouble *" name: "v"
        Put_Line("glVertex4dv 'const GLdouble * v'");
        Vertex4dv(v);
      end Vertex;
    procedure Vertex(
      X : in Float_4_Real;
      Y : in Float_4_Real;
      Z : in Float_4_Real;
      W : in Float_4_Real)
      is
      begin
        Put_Line("glVertex4f %g %g %g %g", x, y, z, w);
        Vertex4f(x, y, z, w);
      end Vertex;
    procedure Vertex(
      V : in Access_Constant_Float_4_Real)
      is
      begin
        -- unknown type: "const GLfloat *" name: "v"
        Put_Line("glVertex4fv 'const GLfloat * v'");
        Vertex4fv(v);
      end Vertex;
    procedure Vertex(
      X : in Integer_4_Signed;
      Y : in Integer_4_Signed;
      Z : in Integer_4_Signed;
      W : in Integer_4_Signed)
      is
      begin
        Put_Line("glVertex4i %d %d %d %d", x, y, z, w);
        Vertex4i(x, y, z, w);
      end Vertex;
    procedure Vertex(
      V : in Access_Constant_Integer_4_Signed)
      is
      begin
        -- unknown type: "const GLint *" name: "v"
        Put_Line("glVertex4iv 'const GLint * v'");
        Vertex4iv(v);
      end Vertex;
    procedure Vertex(
      X : in Integer_2_Signed;
      Y : in Integer_2_Signed;
      Z : in Integer_2_Signed;
      W : in Integer_2_Signed)
      is
      begin
        Put_Line("glVertex4s %d %d %d %d", x, y, z, w);
        Vertex4s(x, y, z, w);
      end Vertex;
    procedure Vertex(
      V : in Access_Constant_Integer_2_Signed)
      is
      begin
        -- unknown type: "const GLshort *" name: "v"
        Put_Line("glVertex4sv 'const GLshort * v'");
        Vertex4sv(v);
      end Vertex;
    procedure Vertex(
      GLint size,
      GLenum type,
      GLsizei stride,
      const GLvoid *pointer)
      is
      begin
        -- unknown type: "const GLvoid *" name: "pointer"
        Put_Line("glVertexPointer %d %s %d 'const GLvoid * pointer'", size, EnumString(type), stride);
        VertexPointer(size, type, stride, pointer);
      end Vertex;
  --------------
  -- Viewport --
  --------------
    procedure Viewport(
      X      : in Integer_4_Signed;
      Y      : in Integer_4_Signed;
      Width  : in Integer_4_Signed;
      Height : in Integer_4_Signed)
      is
      begin
        Put_Line("glViewport %d %d %d %d", x, y, width, height);
        Viewport(x, y, width, height);
      end Viewport;
  end Neo.Command.System.OpenGL;
