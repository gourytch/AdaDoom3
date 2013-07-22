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
package Neo.Command.System.Processor.Math.Graphics
  is
  ------------------
  -- Enumerations --
  ------------------
    type Enumerated_Interface
      is(
      OpenGL_Interface,
      --
      -- 1992 Silicon Graphics, Khronos Group
      --      http://web.archive.org/liveweb/http://www.opengl.org/registry/doc/glspec43.core.20130214.pdf
      --
      Direct3D_Interface,
      --
      -- 1995 Microsoft
      --      http://web.archive.org/web/20120819174252/http://msdn.microsoft.com/en-US/library/hh309466(v=vs.85).aspx
      --
      GCM_Interface);
      --
      -- 2006 Sony
      --      http://web.archive.org/liveweb/http://research.ncl.ac.uk/game/mastersdegree/workshops/ps3introductiontogcm/
      --
  ---------------
  -- Constants --
  ---------------
    MAXIMUM_NUMBER_OF_OCCLUSION_QUERIES : constant Integer_4_Positive := 16#0000_1000#;
  -------------
  -- Records --
  -------------
    type Record_State
      is record
        Queries_Wait_Time : Duration          := 0;
        Queries_Issued    : Integer_4_Natural := 0;
        Queries_Passed    : Integer_4_Natural := 0;
        Queries_Too_Old   : Integer_4_Natural := 0;
        Programs_Bound    : Integer_4_Natural := 0;
        Draw_Elements     : Integer_4_Natural := 0;
        Draw_Indices      : Integer_4_Natural := 0;
        Draw_Vertices     : Integer_4_Natural := 0;
      end record;
  --------------
  -- Packages --
  --------------
    package Item_Real
      is new Item(Variable_Real, NULL_VARIABLE_REAL);
  -------------
  -- Renames --
  -------------
    subtype Variable_Boolean
      is Item_Boolean.Tagged_Protected_Type_To_Vary;
  ---------------
  -- Variables --
  ---------------
    Polygon_Offset_Factor        : Variable_Real;
    Polygon_Offset_Units         : Variable_Real;
    Texture_Anisotropy           : Variable_Real;
    Texture_Level_Of_Detail_Bias : Variable_Real;
    Texture_Minimum_Filter       : Variable_Integer;
    Texture_Maximum_Filter       : Variable_Integer;
    Texture_MIP_Filter           : Variable_Integer;
    Do_Disable_State_Caching     : Variable_Boolean;
    Do_Lazy_Bind_Programs        : Variable_Boolean;
    Do_Lazy_Bind_Parameters      : Variable_Boolean;
    Do_Lazy_Bind_Textures        : Variable_Boolean;
    Do_Strip_Fragment_Branches   : Variable_Boolean;
    Do_Skip_Detail_Triangles     : Variable_Boolean;
    Do_Use_Single_Trinagle       : Variable_Boolean;
  -----------------
  -- Subprograms --
  -----------------
    procedure Initalize
    procedure Start_Depth_Pass(
      )
    procedure Finish_Depth_Pass(
      );
    function Get_Depth_Pass_Rectangle(
    procedure Check_Errors;
    procedure Select_Texture(
      Unit : in Integer_4_Signed);
    procedure Color(
      Red   : in Float_4_Real;
      Green : in Float_4_Real;
      Blue  : in Float_4_Real;
      Alpha : in Float_4_Real := 1.0);
    procedure Depth_Bounds_Test(
      Z_Minimum : in Float_4_Real;
      Z_Maximum : in Float_4_Real);
    procedure Polygon_Offset(
      Scale : in Float_4_Real;
      Bias  : in Float_4_Real);
    procedure Clear(
      Do_Clear_Color : in Boolean;
      Do_Clear_Depth : in Boolean;
      Stencil_Value  : in Integer_1_Unsigned;
      Red            : in Float_4_Real;
      Green          : in Float_4_Real;
      Blue           : in Float_4_Real;
      Alpha          : in Float_4_Real);
    procedure Viewport(
      X      : in Integer_4_Signed;
      Y      : in Integer_4_Signed;
      Width  : in Integer_4_Signed;
      Height : in Integer_4_Signed);
    procedure

void                 GL_StartDepthPass( const idScreenRect & rect );
void                 GL_FinishDepthPass();
void                 GL_GetDepthPassRect( idScreenRect & rect );
void                 GL_SetDefaultState();
void                 GL_State( uint64 stateVector, bool forceGlState = false );
uint64               GL_GetCurrentState();
uint64               GL_GetCurrentStateMinusStencil();
void                 GL_Cull( int cullType );
void                 GL_Scissor( int x /* left*/, int y /* bottom */, int w, int h );
void                 GL_Viewport( int x /* left */, int y /* bottom */, int w, int h );
void                 GL_Clear( bool color, bool depth, bool stencil, byte stencilValue, float r, float g, float b, float a );
void                 GL_PolygonOffset( float scale, float bias );
void                 GL_DepthBoundsTest( const float zmin, const float zmax );
void                 GL_SelectTexture( int unit );
void                 GL_CheckErrors();