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

    procedure Initialize; -- Calculate tables
    function Inverse_Square_Root(
      Number                  : in Float_4_Real;
      Do_Use_16_Bit_Precision : in Boolean := False)
      return Float_4_Real;
    function Square_Root(
      Number                  : in Float_4_Real;
      Do_Use_16_Bit_Precision : in Boolean := False)
      return Float_4_Real;
    function Sine(
      Angle                   : in Float_4_Real;
      Do_Use_16_Bit_Precision : in Boolean := False)
      return Float_4_Real;
    function Cosine(
      Angle                   : in Float_4_Real;
      Do_Use_16_Bit_Precision : in Boolean := False)
      return Float_4_Real;
    procedure Sine_And_Cosine(
      Angle                   : in     Float_4_Real;
      Sine_Result             : in out Float_4_Real;
      Cosine_Result           : in out Float_4_Real;
      Do_Use_16_Bit_Precision : in     Boolean := False);
    function Tangent(
      Angle                   : in Float_4_Real;
      Do_Use_16_Bit_Precision : in Boolean := False)
      return Float_4_Real;
    function Arcsine(
      Angle                   : in Float_4_Real;
      Do_Use_16_Bit_Precision : in Boolean := False)
      return Float_4_Real;
    function Arccosine(
      Angle                   : in Float_4_Real;
      Do_Use_16_Bit_Precision : in Boolean := False)
      return Float_4_Real;
    function Arctangent(
      Angle                   : in Float_4_Real;
      Do_Use_16_Bit_Precision : in Boolean := False)
      return Float_4_Real;
    function Raise_To_Power(
      Number                  : in Float_4_Real;
      Power                   : in Float_4_Real;
      Do_Use_16_Bit_Precision : in Boolean := False)
      return Float_4_Real;
    function Natural_Base_To_Power(
      Power                   : in Float_4_Real;
      Do_Use_16_Bit_Precision : in Boolean := False)
      return Float_4_Real;
    function Natural_Logarithm(
      Number                  : in Float_4_Real;
      Do_Use_16_Bit_Precision : in Boolean := False)
      return Float_4_Real;
    function Integral_To_Power(
      Integral : in Integer_4_Signed;
      Power    : in Integer_4_Signed)
      return Integer_4_Signed;
    function Integral_Base_Two_Logarithm(
      Number : in Float_4_Real)
      return Integer_4_Signed;
    function Integral_Base_Two_Logarithm(
      Number : in Integer_4_Signed)
      return Integer_4_Signed;
    function Get_Minimum_Number_Of_Bits_For_Ceiling(
      Number : in Float_4_Real)
      return Integer_4_Signed;
    function Get_Minimum_Number_Of_Bits(
      Number : in Integer_4_Signed)
      return Integer_4_Signed;
    function Is_Power_Of_Two(
      Number : in Integer_4_Signed)
      return Boolean;
    function Get_Number_Of_Bits(
      Number : in Integer_4_Signed;
      Value  : in Boolean := True)
      return Integer_4_Signed;
    function Reverse_Bits(
      Number : in Integer_4_Signed)
      return Integer_4_Signed;
    function Absolute_Value(
      Number : in Integer_4_Signed)
      return Integer_4_Natural;
    function Absolute_Value(
      Number : in Float_4_Real)
      return Float_4_Natural;
    function Round_To_Floor(
      Number : in Float_4_Real)
      return Float_4_Real;
    function Round_To_Ceiling(
      Number : in Float_4_Real)
      return Float_4_Real;
  static int          MaskForFloatSign( float f );-- returns 0x00000000 if x >= 0.0f and returns 0xFFFFFFFF if x <= -0.0f
  static int          MaskForIntegerSign( int i );-- returns 0x00000000 if x >= 0 and returns 0xFFFFFFFF if x < 0
  static int          FloorPowerOfTwo( int x ); -- round x down to the nearest power of 2
  static int          CeilPowerOfTwo( int x );  -- round x up to the nearest power of 2
  static int          BitCount( int x );      -- returns the number of 1 bits in x
  static int          BitReverse( int x );    -- returns the bit reverse of x
  static int          Abs( int x );       -- returns the absolute value of the integer value (for reference only)
  static float        Fabs( float f );      -- returns the absolute value of the floating point value
  static float        Floor( float f );     -- returns the largest integer that is less than or equal to the given value
  static float        Ceil( float f );      -- returns the smallest integer that is greater than or equal to the given value
  static float        Rint( float f );      -- returns the nearest integer
  static float        Frac( float f );      -- f - Floor( f )
  static int          Ftoi( float f );      -- float to int conversion
  static char         Ftoi8( float f );     -- float to char conversion
  static short        Ftoi16( float f );      -- float to short conversion
  static unsigned short   Ftoui16( float f );     -- float to unsigned short conversion
  static byte         Ftob( float f );      -- float to byte conversion, the result is clamped to the range [0-255]
  static signed char      ClampChar( int i );
  static signed short     ClampShort( int i );
  static int          ClampInt( int min, int max, int value );
  static float        ClampFloat( float min, float max, float value );
  static float        AngleNormalize360( float angle );
  static float        AngleNormalize180( float angle );
  static float        AngleDelta( float angle1, float angle2 );
  static int          FloatToBits( float f, int exponentBits, int mantissaBits );
  static float        BitsToFloat( int i, int exponentBits, int mantissaBits );
  static int          FloatHash( const float *array, const int numFloats );
  static float        LerpToWithScale( const float cur, const float dest, const float scale );