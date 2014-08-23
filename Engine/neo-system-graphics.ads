package Neo.System.Graphics is
procedure Junk;
--      with Neo.Processor.Geometry; use Neo.Processor.Geometry;
-- with Neo.File.Model;         use Neo.File.Model;
-- with Neo.File.Image;         use Neo.File.Image;
-- package Neo.System.Graphics is
--     Level_Initialized_While_Already_Running : Exception;
--     Level_Finalized_Without_Being_Run       : Exception;
--     No_Such_Graphics_Card                   : Exception;
--     Invalid_Enumeration                     : Exception;
--     Stack_Underflow                         : Exception;
--     Stack_Overflow                          : Exception;
--     Out_Of_Memory                           : Exception;
--     Invalid_Value                           : Exception;
--     Unsupported                             : Exception;
--     Inturrupted                             : Exception;
--     type Enumerated_Material    is (Light_Material)
--     type Enumerated_Property    is (Normal_Property, Diffuse_Property, Specular_Property);
--     type Enumerated_Stereo_Mode is (Off_Mode, Side_By_Side_Compressed_Mode, Top_And_Bottom_Compressed_Mode, Side_By_Side_Mode, Interlaced_Mode, Quad_Buffer_Mode, HDMI_720_Mode);
--     type Enumerated_API is(
--       OpenGL_API,
--       -- 1992 Silicon Graphics
--       --      http://web.archive.org/web/20130722222817/http://www.opengl.org/registry/doc/glspec43.core.20130214.pdf
--       Direct3D_API,
--       -- 1995 Microsoft
--       --      http://web.archive.org/web/20120819174252/http://msdn.microsoft.com/en-US/library/hh309466(v=vs.85).aspx
--       GCM_API);
--       -- 2006 Sony
--       --      http://web.archive.org/web/20130715050830/http://research.ncl.ac.uk/game/mastersdegree/workshops/ps3introductiontogcm/
--     type Enumerated_Shading_Language is(
--       Architecture_Review_Board_Language,
--       -- 2002 OpenGL Architecture Review Board
--       --      http://web.archive.org/web/20120802192218/http://www.renderguild.com/gpuguide.pdf
--       --      http://web.archive.org/web/20130512010221/http://oss.sgi.com/projects/ogl-sample/registry/ARB/vertex_program.txt
--       C_For_Graphics_Language,
--       -- 2002 Nvidia
--       --      http://web.archive.org/web/20040720052349/http://download.nvidia.com/developer/cg/Cg_Specification.pdf
--       High_Level_Shading_Language,
--       -- 2003 Microsoft
--       --      http://web.archive.org/web/20130701061644/http://msdn.microsoft.com/en-us/library/windows/desktop/bb509638(v=vs.85).aspx
--       OpenGL_Shading_Language,
--       -- 2004 OpenGL Architecture Review Board
--       --      http://web.archive.org/web/20130807130424/http://www.opengl.org/registry/doc/GLSLangSpec.4.40.diff.pdf
--       Playstation_Shading_Languge);
--       -- ???? Sony
--       --      http://web.archive.org/web/20130827033837/http://www.examiner.com/article/here-are-most-of-the-technical-specifications-for-the-playstation-4
--     type Record_Shader    (Path : String_2) is new Ada.Finalization.Controlled with private;
--     type Record_Texture   (Path : String_2) is new Ada.Finalization.Controlled with private;
--     type Record_Specifics (API : Enumerated_API := OpenGL_API) is record
--         Shading_Language                 : Enumerated_Shading_Language := OpenGL_Shading_Language;
--         Version                          : Float_4_Real                := 0.0;
--         Frequency                        : Integer_4_Natural           := 0;
--         Maximum_Texture_Size             : Integer_4_Natural           := 0;
--         Has_Multitexture                 : Boolean                     := False;
--         Has_Direct_State_Access          : Boolean                     := False;
--         Has_Texture_Compression          : Boolean                     := False;
--         Has_Anisotropic_Filter           : Boolean                     := False;
--         Has_Texture_Level_Of_Detail_Bias : Boolean                     := False;
--         Has_Seamless_Cube_Map            : Boolean                     := False;
--         Has_RGB_Color_Framebuffer        : Boolean                     := False;
--         Has_Vertex_Buffer_Object         : Boolean                     := False;
--         Has_Map_Buffer_Range             : Boolean                     := False;
--         Has_Vertex_Array_Object          : Boolean                     := False;
--         Has_Draw_Elements_Base_Vertex    : Boolean                     := False;
--         Has_Uniform_Buffer               : Boolean                     := False;
--         Has_Two_Sided_Stencil            : Boolean                     := False;
--         Has_Depth_Bounds_Test            : Boolean                     := False;
--         Has_Sync                         : Boolean                     := False;
--         Has_Timer_Query                  : Boolean                     := False;
--         Has_Occlusion_Query              : Boolean                     := False;
--         Has_Swap_Control_Tear            : Boolean                     := False;
--         Has_Stereo_Pixel_Format          : Boolean                     := False;
--         case API is
--           when OpenGL_API   => null;
--           when Direct3D_API => null;
--           when GCM_API      => null;
--         end case;
--       end record;


--    -- Many record fields should be removed since they have nothing to do with the backend. These higher levels should be defined in Neo.World
 

-- typedef struct {
--   int   stayTime;   // msec for no change
--   int   fadeTime;   // msec to fade vertex colors over
--   float start[4];   // vertex color at spawn (possibly out of 0.0 - 1.0 range, will clamp after calc)
--   float end[4];     // vertex color at fade-out (possibly out of 0.0 - 1.0 range, will clamp after calc)
-- } decalInfo_t;
--     type Record_Stage(Is_New : Boolean := True) is record
--         case Is_New is
--           when True => 
--             vertexProgram : ;int         
--             numVertexParms : ;int         
--             vertexParmsint  :         [MAX_VERTEX_PARMS][4]; -- evaluated register indexes
--             fragmentProgram : ;int         
--             glslProgram : ;int         
--             numFragmentProgramImages : ;int         
--             fragmentProgramImages : [MAX_FRAGMENT_IMAGES];idImage *     
--         --   when False =>
--         --     conditionRegister    : ;int           -- if registers[conditionRegister] == 0, skip stage
--         --     lighting             : ;stageLighting_t        -- determines which passes interact with lights
--         --     drawStateBits        : ;int64        
--         --     color                : ;colorStage_t    
--         --     hasAlphaTest         : ;bool        
--         --     alphaTestRegister    : ;int         
--         --     texture              : ;textureStage_t    
--         --     vertexColor          : ;stageVertexColor_t  
--         --     ignoreAlphaTest      : ;bool          -- this stage should act as translucent, even if the surface is alpha tested
--         --     privatePolygonOffset : ;float        -- a per-stage polygon offset
--         --     newStage             : ;newShaderStage_t  *      -- vertex / fragment program based stage
--         -- end case;
--       end record;
--     type Record_Material(Kind : Enumerated_Material; Normal, Diffuse, Specular : Record_Graphic := Neo.File.Image.Create(BLACK_COLOR)) is record
--         Description     : String_2_Unbounded;
--         No_Fog          :
--         Spectrum        :
--         Polygon_Offset  :
--         Decal           :
--         entityGui       : int               -- draw a gui with the idUserInterface from the renderEntity_t non zero will draw gui, gui2, or gui3 from renderEnitty_t
--         gui             : ;mutable idUserInterface *     -- non-custom guis are shared by all users of a material
--         noFog           : ;bool                -- surface does not create fog interactions
--         spectrum        : ; int             -- for invisible writing, used for both lights and surfaces
--         polygonOffset   : ;float       
--         contentFlags    : ;int            -- content flags
--         surfaceFlags    : ;int            -- surface flags  
--         materialFlags   : ;mutable int         -- material flags
--         decalInfo       : ;decalInfo_t     
--         sort            : ;mutable float          -- lower numbered shaders draw before higher numbered
--         stereoEye       : ;int         
--         deform          : ;deform_t      
--         deformRegisters : [4] : ;int            -- numeric parameter for deforms
--         deformDecl      : ;const idDecl    *      -- for surface emitted particle deforms and tables
--         texGenRegisters : [MAX_TEXGEN_REGISTERS] : ;int           -- for wobbleSky
--         coverage        : ;materialCoverage_t  
--         cullType        : ;cullType_t           -- CT_FRONT_SIDED, CT_BACK_SIDED, or CT_TWO_SIDED
--         shouldCrteBacks : ;bool        
--         fogLight        : ;bool        
--         blendLight          : ;bool        
--         ambientLight        : ;bool        
--         unsmoothedTangents  : ;bool        
--         hasSubview          : ;bool             -- mirror, remote render, etc
--         allowOverlays       : ;bool        
--         numOps              : ;int         
--         ops                 : ;expOp_t *             -- evaluate to make expressionRegisters         
--         numRegisters        : ;int                                              --
--         expressionRegisters : ;float *       
--         constantRegisters   : ;float *         -- NULL if ops ever reference globalParms or entityParms
--         numStages           : ;int         
--         numAmbientStages    : ;int                                         
--         stages              : ;shaderStage_t *   
--         pd                  : ;struct mtrParsingData_s *      -- only used during parsing
--         surfaceArea         : ;float           -- only for listSurfaceAreas
--         -- we defer loading of the editor image until it is asked for, so the game doesn't load up all the invisible and uncompressed images. If editorImage is NULL, it will atempt to load editorImageName, and set editorImage to that or defaultImage
--         editorAlpha         : ;float       
--         suppressInSubview   : ;bool        
--         portalSky           : ;bool        
--         refCount            : ;int         
--         case Kind is
--           when Light_Material => lightFalloffImage : idImage *;  -- only for light shaders
--         end case;
--       end record;
--     type Record_Surface is record
--         Geometry       : Record_Mesh;
--         Indexes        : triIndex_t
--         Ambient        : vertCacheHandle_t
--         Shadows        : vertCacheHandle_t
--         Joints         : vertCacheHandle_t
--         Space          : viewEntity_t 
--         Material       : idMaterial *
--         -- GL Extra
--         Sort           : Float_4_Real;
--         Registers      : const float  *
--         Scissor        : idScreenRect 
--         Render_Z_Fail  : int   
--         Shadoow_Volume : shadowVolumeState_t
--         --  drawSurf_t *      nextOnLight;    -- viewLight chains  drawSurf_t **     linkChain;      -- defer linking to lights to a serial section to avoid a mutex
--       end record;
--     type Record_Light is record
--         Scissor                  : idScreenRect := ;
--         Do_Remove                :  := ;
--         Shadow_Only              : shadowOnlyEntity_t * := ;
--         Interation_State         : byte *  := ;
--         Origin                   : idVec3 := ;
--         Project                  : array(1..4) idPlane := ;
--         Fog                      : idPlane := ;
--         Inverse_Base_Project     : idRenderMatrix := ;
--         Shader                   : const idMaterial * := ;
--         Registers                : const float *  := ;
--         Fall_Off                 : idImage *  := ;
--         Shadows                  : drawSurf_t *  := ;
--         Interactions             : drawSurf_t *  := ;
--         Translucent_Interactions : drawSurf_t *  := ;
--         Pre_Light_Shadow_Volumes : preLightShadowVolumeParms_t * := ;
--       end record;
--     type Record_Entity is record
--         Scissor             : idScreenRect := ;
--         Is_GUI              : bool  := ;
--         Do_Skip_Motion_Blur : bool  := ;
--         Weapon_Depth_Hack   : bool  := ;
--         Model_Depth_Hack    : := ;
--         Model               : array(1..16)float   := ;
--         View                : array(1..16) float   := ;
--         MVP                 : idRenderMatrix  := ;
--         Surfaces            : drawSurf_t *  := ;
--         Shadow_Volumes      : dynamicShadowVolumeParms_t *  staticShadowVolumeParms_t *  := ;
--       end record;
--     type Record_View is record
--         Origin          : idVec3 := ; -- Used to find the portalArea that view flooding will take place from. for a normal view, the initialViewOrigin will be renderView.viewOrg, but a mirror may put the projection origin outside of any valid area, or in an unconnected area of the map, so the view area must be based on a point just off the surface of the mirror / subview. It may be possible to get a failed portal pass if the plane of the/ mirror intersects a portal, and the initialViewAreaOrigin is on a different side than the renderView.viewOrg is.
--         Is_Subview      : bool := ; -- true if this view is not the main view
--         Is_Mirror       : bool := ; -- the portal is a mirror, invert the face culling
--         Is_XRay         : bool := ;
--         Is_Editor       : bool := ;
--         Is_GUI          : bool := ;
--         Clip_Planes     : Integer := ; -- mirrors will often use a single clip plane in world space, the positive side of the plane is the visible side
--         Port            : idScreenRect := ;-- in real pixels and proper Y flip
--         Scissor         : idScreenRect := ;-- for scissor clipping, local inside renderView viewport subviews may only be rendering part of the main view these are real physical pixel values, possibly scaled and offset from the renderView x/y/width/height
--         Super           : := ;
--         Subsurface      : Record_Surface := ;
--         Surfaces        : drawSurf_t ** := ;
--         Lights          : viewLight_t *  := ; -- check to see if a given view consists solely of 2D rendering, which we can optimize in certain ways. A 2D view will not have any viewEntities
--         Entities        : viewEntity_t *  := ;
--         Frustum         : Array_Record_Plane(1..6); := ; -- positive sides face outward, [4] is the front clip plane
--         Area            : Integer_4_Signed; := ;
--         Connected_Areas : Boolean  := ;--  An array in frame temporary memory that lists if an area can be reached without crossing a closed door.  This is used to avoid drawing interactions when the light is behind a closed door.
--       end record;
--     type Record_Property is record
--         Graphic : Record_Graphic := ;
--         Color   : Record_Pixel := ;
--         Data    : Array_Vector_4(1..2) := ;
--       end record;
--     type Record_Interaction is record -- complex light / surface interactions are broken up into multiple passes of a simple interaction shader
--         Properties    : Array_Record_Property(Enumerated_Property'range) := (others => <>);
--         Ambient_Light : Integer_4_Signed := ;
--       end record;
--     type Access_Record_Specifics is access all Record_Specifics;
--     type Array_API_Specifics is array (Enumerated_API'range) of Access_Record_Specifics;
--     procedure Test;
--     procedure Draw         (View : in Record_View; Card : in Integer_4_Positive := 1);
--     procedure Post_Process                        (Card : in Integer_4_Positive := 1);
--     function Is_Drawing                           (Card : in Integer_4_Positive := 1) return Boolean; -- If the graphics are drawing no other operations can be done, Inturrupted will be raised
--     function Get_Specifics                                                            return Array_API_Specifics;
--     function Get_Frame                                                                return Record_Graphic;
--     SPECIFICS       : constant Array_API_Specifics := Get_Specifics;
--     VARIABLE_PREFIX : constant String_2 := "R_";
--     package API                        is new Variable (VARIABLE_PREFIX & "API",           "Hide the mouse cursor: "),
--     package Warp                       is new Variable (VARIABLE_PREFIX & "Warp",          "Use the optical warping renderprog instead of stereoDeGhost: "),"0"
--     package Stereo_Warp_Power          is new Variable (VARIABLE_PREFIX & "WarpPower",     "Amount of pre-distortion: "),"1.45"
--     package Stereo_Warp_X_Center       is new Variable (VARIABLE_PREFIX & "WarpCenterX",   "Center for left eye, right eye will be 1.0: "), "0.5"
--     package Stereo_Warp_X_Center       is new Variable (VARIABLE_PREFIX & "WarpCenterY",   "Center for both eyes: "), "0.5"
--     package Stereo_Warp_Z              is new Variable (VARIABLE_PREFIX & "WarpZ",         "Development parm: "), "0"
--     package Stereo_Warp_W              is new Variable (VARIABLE_PREFIX & "WarpW",         "Development parm: "), "0"
--     package Stereo_Warp_Fraction       is new Variable (VARIABLE_PREFIX & "WarpFraction",  "Fraction of half-width the through-lens view covers: "), "1.0"
--     package Do_Sync_Frames             is new Variable (VARIABLE_PREFIX & "SyncFrames",    "Don't let the GPU buffer execution past swapbuffers: "), True);
--     package Stereo_3D                  is new Variable (VARIABLE_PREFIX & "Stereo3D",      "")
--     package Polygon_Offset_Factor      is new Variable (VARIABLE_PREFIX & "PolyFactor",    ""
--     package Polygon_Offset_Units       is new Variable (VARIABLE_PREFIX & "PolyUnits",     ""
--     package Texture_Anisotropy         is new Variable (VARIABLE_PREFIX & "Anisotropy",    ""
--     package Texture_Detail_Bias        is new Variable (VARIABLE_PREFIX & "Bias",          ""
--     package Texture_Minimum_Filter     is new Variable (VARIABLE_PREFIX & "MinFilter",     ""
--     package Texture_Maximum_Filter     is new Variable (VARIABLE_PREFIX & "MaxFilter",     ""
--     package Texture_MIP_Filter         is new Variable (VARIABLE_PREFIX & "MIPFilter",     ""),
--     package Do_State_Cache             is new Variable (VARIABLE_PREFIX & "Cache",         ""
--     package Do_Lazy_Bind_Programs      is new Variable (VARIABLE_PREFIX & "LazyProg",      ""
--     package Do_Lazy_Bind_Parameters    is new Variable (VARIABLE_PREFIX & "LazyParam",     ""
--     package Do_Lazy_Bind_Textures      is new Variable (VARIABLE_PREFIX & "LazyTex",       ""
--     package Do_Strip_Fragment_Branches is new Variable (VARIABLE_PREFIX & "StripBranches", "Strip fragment branches"),
--     package Do_Skip_Detail_Triangles   is new Variable (VARIABLE_PREFIX & "SkipdTri",      "Skip detail triangles"),
--     package Do_Use_Single_Trinagle     is new Variable (VARIABLE_PREFIX & "SingleTri",     "");
--     package Stereo_Depth               is new Variable (VARIABLE_PREFIX & "StereoDepth",   ""), Is_Logged        => False, Is_User_Settable => False);
--     package Blend                      is new Variable (VARIABLE_PREFIX & "Blend",         "" False, False);
--     package Blend_Operation            is new Variable (VARIABLE_PREFIX & "BlendOp",       "");
--     package Stencil                    is new Variable (VARIABLE_PREFIX & "Stencil",       "");
--     package Stencil_Operation          is new Variable (VARIABLE_PREFIX & "StencilOp",     "");
--     package Stencil_Function           is new Variable (VARIABLE_PREFIX & "StencilFun",    "");
--     package Depth_Function             is new Variable (VARIABLE_PREFIX & "DepthFun",      "");
--     package Alpha_Test_Function        is new Variable (VARIABLE_PREFIX & "AlphaTest",     "");
--     package Mask                       is new Variable (VARIABLE_PREFIX & "Mask",          "");
-- private
--     MAXIMUM_CLIP_PLANES : constant Integer_4_Positive := 1;        -- we may expand this to six for some subview issues
--     MAXIMUM_NUMBER_OF_OCCLUSION_QUERIES : constant Integer_4_Positive := 16#0000_1000#;
--     type Enumerated_Stencil           is (Reference_Shift_Stencil,     Reference_Bits_Stencil,       Mask_Shift_Stencil);
--     type Enumerated_Stereo_Depth      is (No_Depth,                    Near_Depth,                   Middle_Depth,                      Far_Depth);
--     type Enumerated_Depth             is (Less_Depth,                  Always_Depth,                 Greater_Depth,                     Equal_Depth);
--     type Enumerated_Blend_Operation   is (Add_Blend_Operation,         Subtract_Blend_Operation,     Minimum_Blend_Operation,           Maximum_Blend_Operation);
--     type Enumerated_Stencil_Operation is (Keep_Stencil_Operation,      Zero_Stencil_Operation,       Replace_Stencil_Operation,         Increment_Stencil_Operation,
--                                           Decrement_Stencil_Operation, Invert_Stencil_Operation,     Increment_Wrap_Stencil_Operation,  Decrement_Wrap_Stencil_Operation);
--     type Enumerated_Blend             is (Zero_Blend,                  One_Blend,                    Destination_Color_Blend,           One_Minus_Destination_Color_Blend,
--                                           Source_Alpha_Blend,          One_Minus_Source_Alpha_Blend, Destination_Alpha_Blend,           One_Minus_Destination_Alpha_Blend);
--     type Enumerated_Stereo_3D         is (No_Stereo_3D,                Side_By_Side_Stereo_3D,       Side_By_Side_Compressed_Stereo_3D, Top_And_Bottom_Compressed_Stereo_3D,
--                                           Interlaced_Stereo_3D,        Quad_Buffer_Stereo_3D,        HDMI_720_Stereo_3D);
--     type Enumerated_Stencil           is (Always_Stencil,              Not_Equal_Stencil,            Less_Than_Or_Equal_To_Stencil,     Greater_Than_Stencil,
--                                           Equal_Stencil,               Never_Stencil,                Less_Stencil);
--     procedure Check_Exceptions;
--     procedure Begin_Depth_Pass(Screen : in Record_Rectangle);
--     procedure End_Depth_Pass;
--     function Get_Specifics return Record_Specifics;
--     function Get_Depth_Pass return Record_Rectangle;
--     function Get_Depth_Pass_Rectangle(
--     procedure Select_Texture(Texture : in Record_Texture);
--     procedure Color(Color : in Record_Color := COLOR_WHITE);
--     procedure Depth_Bounds_Test(Z_Minimum : in Float_4_Real; Z_Maximum : in Float_4_Real); with Pre => Z_Minimum < Z_Maximum;
--     procedure Polygon_Offset( Scale : in Float_4_Real; Bias  : in Float_4_Real);
--     procedure Clear(Do_Clear_Color : in Boolean; Do_Clear_Depth : in Boolean; Stencil_Value : in Integer_1_Unsigned; Color : in Record_COlor);
--     procedure Viewport(X, Y, Width, Height : in Integer_4_Signed);
--     procedure Clear(Do_Clear_Color, Do_Clear_Color, Do_Clear_Color : in Boolean; Stencil_Value  : in Integer_1_Unsigned; Pixel : in Record_);
--     procedure Cull(Kind : in Enumerated_Cull);
--     procedure Scissor(Rectangle : in Record_Rectangle);
--     procedure Upload_Subimage(mipLevel, x, y, z, width, height, const void * pic, int pixelPitch) with miplevel < opts.numlevels;
--     package OpenGL is
--       end OpenGL;
--     package Direct3D is
--       end Direct3D;
--     package GCMis
--       end GCM;
  end Neo.System.Graphics;
