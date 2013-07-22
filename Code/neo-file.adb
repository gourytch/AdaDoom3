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
package body Neo.File
  is
  --------------------------
  -- Get_Possible_Formats --
  --------------------------
    procedure Get_Possible_Formats(
      Path    : in String_2;
      Formats : in Array_Record_Format)
      return Array_Integer_4_Signed
      is
      type Vector_Enumerated_Format
        is new Ada.Containers.Vector;
      Header    : String_1(1..8) := (others => NULL_CHARACTER_1);
      Extension : String_2       := Get_Extension(Path);
      Matching_Formats   : Vector_Enumerated_Format;
      begin
        for I in FORMATS'range loop
          if FORMATS(I).Extensions /= null then
            for J in FORMATS(I).Extensions'range loop
              exit when To_String_2_Unbounded(FORMATS(I).Extensions(J)) = To_String_2_Unbounded(Extension);
            end loop;
          end if;
          if I = FORMATS'last then
            Put_Debug_Line(Localize(WARN_ITEM_EXTENSION_NOT_KNOWN));
          end if;
        end loop;
        if 
        String_1'read(image.stream, Signature);
        for I in FORMATS'range loop
          if FORMATS(I).Signatures = null then
            Matching_Formats.Add_Back(I);
          else
            for J in FORMATS(I).Signatures'range loop
              if To_String_2_Unbounded(FORMATS(I).Signatures(J)) = To_String_2_Unbounded(Signature) then
                Matching_Formats.Add_Front(I);
                exit;
              end if;
            end loop;
          end if;
        end loop;
        if Size(Matching_Formats) = 0 then
          raise Unknown_Format;
        end if;
      end Get_Possible_Formats;

/*
   CRC-32
   Copyright (C) 1995-1998 Mark Adler
*/

#define CRC32_INIT_VALUE  0xffffffffL
#define CRC32_XOR_VALUE   0xffffffffL

#ifdef CREATE_CRC_TABLE

static unsigned long crctable[256];

/*
   Generate a table for a byte-wise 32-bit CRC calculation on the polynomial:
   x^32+x^26+x^23+x^22+x^16+x^12+x^11+x^10+x^8+x^7+x^5+x^4+x^2+x^1+x^0.

   Polynomials over GF(2) are represented in binary, one bit per coefficient,
   with the lowest powers in the most significant bit.  Then adding polynomials
   is just exclusive-or, and multiplying a polynomial by x is a right shift by
   one.  If we call the above polynomial p, and represent a byte as the
   polynomial q, also with the lowest power in the most significant bit (so the
   byte 0xb1 is the polynomial x^7+x^3+x^1+x^0), then the CRC is (q*x^32) mod p,
   where a mod b means the remainder after dividing a by b.

   This calculation is done using the shift-register method of multiplying and
   taking the remainder.  The register is initialized to zero, and for each
   incoming bit, x^32 is added mod p to the register if the bit is a one (where
   x^32 mod p is p+x^32 = x^26+...+x^0), and the register is multiplied mod p by
   x (which is shifting right by one and adding x^32 mod p if the bit shifted
   out is a one).  We start with the highest power (least significant bit) of
   q and repeat for all eight bits of q.

   The table is simply the CRC of all possible eight bit values. This is all
   the information needed to generate CRC's on data a byte at a time for all
   combinations of CRC register values and incoming bytes.
*/

void make_crc_table( void ) {
  int i, j;
  unsigned long c, poly;
  /* terms of polynomial defining this crc (except x^32): */
  static const byte p[] = {0,1,2,4,5,7,8,10,11,12,16,22,23,26};

  /* make exclusive-or pattern from polynomial (0xedb88320L) */
  poly = 0L;
  for ( i = 0; i < sizeof( p ) / sizeof( byte ); i++ ) {
    poly |= 1L << ( 31 - p[i] );
  }

  for ( i = 0; i < 256; i++ ) {
    c = (unsigned long)i;
    for ( j = 0; j < 8; j++ ) {
      c = ( c & 1 ) ? poly ^ ( c >> 1 ) : ( c >> 1 );
    }
    crctable[i] = c;
  }
}

#else

/*
  Table of CRC-32's of all single-byte values (made by make_crc_table)
*/
static unsigned long crctable[256] = {
  0x00000000L, 0x77073096L, 0xee0e612cL, 0x990951baL,
  0x076dc419L, 0x706af48fL, 0xe963a535L, 0x9e6495a3L,
  0x0edb8832L, 0x79dcb8a4L, 0xe0d5e91eL, 0x97d2d988L,
  0x09b64c2bL, 0x7eb17cbdL, 0xe7b82d07L, 0x90bf1d91L,
  0x1db71064L, 0x6ab020f2L, 0xf3b97148L, 0x84be41deL,
  0x1adad47dL, 0x6ddde4ebL, 0xf4d4b551L, 0x83d385c7L,
  0x136c9856L, 0x646ba8c0L, 0xfd62f97aL, 0x8a65c9ecL,
  0x14015c4fL, 0x63066cd9L, 0xfa0f3d63L, 0x8d080df5L,
  0x3b6e20c8L, 0x4c69105eL, 0xd56041e4L, 0xa2677172L,
  0x3c03e4d1L, 0x4b04d447L, 0xd20d85fdL, 0xa50ab56bL,
  0x35b5a8faL, 0x42b2986cL, 0xdbbbc9d6L, 0xacbcf940L,
  0x32d86ce3L, 0x45df5c75L, 0xdcd60dcfL, 0xabd13d59L,
  0x26d930acL, 0x51de003aL, 0xc8d75180L, 0xbfd06116L,
  0x21b4f4b5L, 0x56b3c423L, 0xcfba9599L, 0xb8bda50fL,
  0x2802b89eL, 0x5f058808L, 0xc60cd9b2L, 0xb10be924L,
  0x2f6f7c87L, 0x58684c11L, 0xc1611dabL, 0xb6662d3dL,
  0x76dc4190L, 0x01db7106L, 0x98d220bcL, 0xefd5102aL,
  0x71b18589L, 0x06b6b51fL, 0x9fbfe4a5L, 0xe8b8d433L,
  0x7807c9a2L, 0x0f00f934L, 0x9609a88eL, 0xe10e9818L,
  0x7f6a0dbbL, 0x086d3d2dL, 0x91646c97L, 0xe6635c01L,
  0x6b6b51f4L, 0x1c6c6162L, 0x856530d8L, 0xf262004eL,
  0x6c0695edL, 0x1b01a57bL, 0x8208f4c1L, 0xf50fc457L,
  0x65b0d9c6L, 0x12b7e950L, 0x8bbeb8eaL, 0xfcb9887cL,
  0x62dd1ddfL, 0x15da2d49L, 0x8cd37cf3L, 0xfbd44c65L,
  0x4db26158L, 0x3ab551ceL, 0xa3bc0074L, 0xd4bb30e2L,
  0x4adfa541L, 0x3dd895d7L, 0xa4d1c46dL, 0xd3d6f4fbL,
  0x4369e96aL, 0x346ed9fcL, 0xad678846L, 0xda60b8d0L,
  0x44042d73L, 0x33031de5L, 0xaa0a4c5fL, 0xdd0d7cc9L,
  0x5005713cL, 0x270241aaL, 0xbe0b1010L, 0xc90c2086L,
  0x5768b525L, 0x206f85b3L, 0xb966d409L, 0xce61e49fL,
  0x5edef90eL, 0x29d9c998L, 0xb0d09822L, 0xc7d7a8b4L,
  0x59b33d17L, 0x2eb40d81L, 0xb7bd5c3bL, 0xc0ba6cadL,
  0xedb88320L, 0x9abfb3b6L, 0x03b6e20cL, 0x74b1d29aL,
  0xead54739L, 0x9dd277afL, 0x04db2615L, 0x73dc1683L,
  0xe3630b12L, 0x94643b84L, 0x0d6d6a3eL, 0x7a6a5aa8L,
  0xe40ecf0bL, 0x9309ff9dL, 0x0a00ae27L, 0x7d079eb1L,
  0xf00f9344L, 0x8708a3d2L, 0x1e01f268L, 0x6906c2feL,
  0xf762575dL, 0x806567cbL, 0x196c3671L, 0x6e6b06e7L,
  0xfed41b76L, 0x89d32be0L, 0x10da7a5aL, 0x67dd4accL,
  0xf9b9df6fL, 0x8ebeeff9L, 0x17b7be43L, 0x60b08ed5L,
  0xd6d6a3e8L, 0xa1d1937eL, 0x38d8c2c4L, 0x4fdff252L,
  0xd1bb67f1L, 0xa6bc5767L, 0x3fb506ddL, 0x48b2364bL,
  0xd80d2bdaL, 0xaf0a1b4cL, 0x36034af6L, 0x41047a60L,
  0xdf60efc3L, 0xa867df55L, 0x316e8eefL, 0x4669be79L,
  0xcb61b38cL, 0xbc66831aL, 0x256fd2a0L, 0x5268e236L,
  0xcc0c7795L, 0xbb0b4703L, 0x220216b9L, 0x5505262fL,
  0xc5ba3bbeL, 0xb2bd0b28L, 0x2bb45a92L, 0x5cb36a04L,
  0xc2d7ffa7L, 0xb5d0cf31L, 0x2cd99e8bL, 0x5bdeae1dL,
  0x9b64c2b0L, 0xec63f226L, 0x756aa39cL, 0x026d930aL,
  0x9c0906a9L, 0xeb0e363fL, 0x72076785L, 0x05005713L,
  0x95bf4a82L, 0xe2b87a14L, 0x7bb12baeL, 0x0cb61b38L,
  0x92d28e9bL, 0xe5d5be0dL, 0x7cdcefb7L, 0x0bdbdf21L,
  0x86d3d2d4L, 0xf1d4e242L, 0x68ddb3f8L, 0x1fda836eL,
  0x81be16cdL, 0xf6b9265bL, 0x6fb077e1L, 0x18b74777L,
  0x88085ae6L, 0xff0f6a70L, 0x66063bcaL, 0x11010b5cL,
  0x8f659effL, 0xf862ae69L, 0x616bffd3L, 0x166ccf45L,
  0xa00ae278L, 0xd70dd2eeL, 0x4e048354L, 0x3903b3c2L,
  0xa7672661L, 0xd06016f7L, 0x4969474dL, 0x3e6e77dbL,
  0xaed16a4aL, 0xd9d65adcL, 0x40df0b66L, 0x37d83bf0L,
  0xa9bcae53L, 0xdebb9ec5L, 0x47b2cf7fL, 0x30b5ffe9L,
  0xbdbdf21cL, 0xcabac28aL, 0x53b39330L, 0x24b4a3a6L,
  0xbad03605L, 0xcdd70693L, 0x54de5729L, 0x23d967bfL,
  0xb3667a2eL, 0xc4614ab8L, 0x5d681b02L, 0x2a6f2b94L,
  0xb40bbe37L, 0xc30c8ea1L, 0x5a05df1bL, 0x2d02ef8dL
};

#endif

void CRC32_InitChecksum( unsigned long &crcvalue ) {
  crcvalue = CRC32_INIT_VALUE;
}

void CRC32_Update( unsigned long &crcvalue, const byte data ) {
  crcvalue = crctable[ ( crcvalue ^ data ) & 0xff ] ^ ( crcvalue >> 8 );
}

void CRC32_UpdateChecksum( unsigned long &crcvalue, const void *data, int length ) {
  unsigned long crc;
  const unsigned char *buf = (const unsigned char *) data;

  crc = crcvalue;
  while( length-- ) {
    crc = crctable[ ( crc ^ ( *buf++ ) ) & 0xff ] ^ ( crc >> 8 );
  }
  crcvalue = crc;
}

void CRC32_FinishChecksum( unsigned long &crcvalue ) {
  crcvalue ^= CRC32_XOR_VALUE;
}

unsigned long CRC32_BlockChecksum( const void *data, int length ) {
  unsigned long crc;

  CRC32_InitChecksum( crc );
  CRC32_UpdateChecksum( crc, data, length );
  CRC32_FinishChecksum( crc );
  return crc;
}

#pragma hdrstop
#include "../precompiled.h"

/*
   RSA Data Security, Inc., MD4 message-digest algorithm. (RFC1320)
*/

/*

Copyright (C) 1991-2, RSA Data Security, Inc. Created 1991. All
rights reserved.

License to copy and use this software is granted provided that it
is identified as the "RSA Data Security, Inc. MD4 Message-Digest
Algorithm" in all material mentioning or referencing this software
or this function.

License is also granted to make and use derivative works provided
that such works are identified as "derived from the RSA Data
Security, Inc. MD4 Message-Digest Algorithm" in all material
mentioning or referencing the derived work.

RSA Data Security, Inc. makes no representations concerning either
the merchantability of this software or the suitability of this
software for any particular purpose. It is provided "as is"
without express or implied warranty of any kind.

These notices must be retained in any copies of any part of this
documentation and/or software.

*/

/* POINTER defines a generic pointer type */
typedef unsigned char *POINTER;

/* UINT2 defines a two byte word */
typedef unsigned short int UINT2;

/* UINT4 defines a four byte word */
typedef unsigned long int UINT4;

/* MD4 context. */
typedef struct {
  UINT4 state[4];       /* state (ABCD) */
  UINT4 count[2];       /* number of bits, modulo 2^64 (lsb first) */
  unsigned char buffer[64];   /* input buffer */
} MD4_CTX;

/* Constants for MD4Transform routine.  */
#define S11 3
#define S12 7
#define S13 11
#define S14 19
#define S21 3
#define S22 5
#define S23 9
#define S24 13
#define S31 3
#define S32 9
#define S33 11
#define S34 15

static unsigned char PADDING[64] = {
0x80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};

/* F, G and H are basic MD4 functions. */
#define F(x, y, z) (((x) & (y)) | ((~x) & (z)))
#define G(x, y, z) (((x) & (y)) | ((x) & (z)) | ((y) & (z)))
#define H(x, y, z) ((x) ^ (y) ^ (z))

/* ROTATE_LEFT rotates x left n bits. */
#define ROTATE_LEFT(x, n) (((x) << (n)) | ((x) >> (32-(n))))

/* FF, GG and HH are transformations for rounds 1, 2 and 3 */
/* Rotation is separate from addition to prevent recomputation */
#define FF(a, b, c, d, x, s) {(a) += F ((b), (c), (d)) + (x); (a) = ROTATE_LEFT ((a), (s));}

#define GG(a, b, c, d, x, s) {(a) += G ((b), (c), (d)) + (x) + (UINT4)0x5a827999; (a) = ROTATE_LEFT ((a), (s));}

#define HH(a, b, c, d, x, s) {(a) += H ((b), (c), (d)) + (x) + (UINT4)0x6ed9eba1; (a) = ROTATE_LEFT ((a), (s));}

/* Encodes input (UINT4) into output (unsigned char). Assumes len is a multiple of 4. */
static void Encode( unsigned char *output, UINT4 *input, unsigned int len ) {
  unsigned int i, j;

  for ( i = 0, j = 0; j < len; i++, j += 4 ) {
    output[j] = (unsigned char)(input[i] & 0xff);
    output[j+1] = (unsigned char)((input[i] >> 8) & 0xff);
    output[j+2] = (unsigned char)((input[i] >> 16) & 0xff);
    output[j+3] = (unsigned char)((input[i] >> 24) & 0xff);
  }
}

/* Decodes input (unsigned char) into output (UINT4). Assumes len is a multiple of 4. */
static void Decode( UINT4 *output, const unsigned char *input, unsigned int len ) {
  unsigned int i, j;

  for ( i = 0, j = 0; j < len; i++, j += 4 ) {
    output[i] = ((UINT4)input[j]) | (((UINT4)input[j+1]) << 8) | (((UINT4)input[j+2]) << 16) | (((UINT4)input[j+3]) << 24);
  }
}

/* MD4 basic transformation. Transforms state based on block. */
static void MD4_Transform( UINT4 state[4], const unsigned char block[64] ) {
  UINT4 a = state[0], b = state[1], c = state[2], d = state[3], x[16];

  Decode (x, block, 64);

  /* Round 1 */
  FF (a, b, c, d, x[ 0], S11);      /* 1 */
  FF (d, a, b, c, x[ 1], S12);      /* 2 */
  FF (c, d, a, b, x[ 2], S13);      /* 3 */
  FF (b, c, d, a, x[ 3], S14);      /* 4 */
  FF (a, b, c, d, x[ 4], S11);      /* 5 */
  FF (d, a, b, c, x[ 5], S12);      /* 6 */
  FF (c, d, a, b, x[ 6], S13);      /* 7 */
  FF (b, c, d, a, x[ 7], S14);      /* 8 */
  FF (a, b, c, d, x[ 8], S11);      /* 9 */
  FF (d, a, b, c, x[ 9], S12);      /* 10 */
  FF (c, d, a, b, x[10], S13);      /* 11 */
  FF (b, c, d, a, x[11], S14);      /* 12 */
  FF (a, b, c, d, x[12], S11);      /* 13 */
  FF (d, a, b, c, x[13], S12);      /* 14 */
  FF (c, d, a, b, x[14], S13);      /* 15 */
  FF (b, c, d, a, x[15], S14);      /* 16 */

  /* Round 2 */
  GG (a, b, c, d, x[ 0], S21);      /* 17 */
  GG (d, a, b, c, x[ 4], S22);      /* 18 */
  GG (c, d, a, b, x[ 8], S23);      /* 19 */
  GG (b, c, d, a, x[12], S24);      /* 20 */
  GG (a, b, c, d, x[ 1], S21);      /* 21 */
  GG (d, a, b, c, x[ 5], S22);      /* 22 */
  GG (c, d, a, b, x[ 9], S23);      /* 23 */
  GG (b, c, d, a, x[13], S24);      /* 24 */
  GG (a, b, c, d, x[ 2], S21);      /* 25 */
  GG (d, a, b, c, x[ 6], S22);      /* 26 */
  GG (c, d, a, b, x[10], S23);      /* 27 */
  GG (b, c, d, a, x[14], S24);      /* 28 */
  GG (a, b, c, d, x[ 3], S21);      /* 29 */
  GG (d, a, b, c, x[ 7], S22);      /* 30 */
  GG (c, d, a, b, x[11], S23);      /* 31 */
  GG (b, c, d, a, x[15], S24);      /* 32 */

  /* Round 3 */
  HH (a, b, c, d, x[ 0], S31);      /* 33 */
  HH (d, a, b, c, x[ 8], S32);      /* 34 */
  HH (c, d, a, b, x[ 4], S33);      /* 35 */
  HH (b, c, d, a, x[12], S34);      /* 36 */
  HH (a, b, c, d, x[ 2], S31);      /* 37 */
  HH (d, a, b, c, x[10], S32);      /* 38 */
  HH (c, d, a, b, x[ 6], S33);      /* 39 */
  HH (b, c, d, a, x[14], S34);      /* 40 */
  HH (a, b, c, d, x[ 1], S31);      /* 41 */
  HH (d, a, b, c, x[ 9], S32);      /* 42 */
  HH (c, d, a, b, x[ 5], S33);      /* 43 */
  HH (b, c, d, a, x[13], S34);      /* 44 */
  HH (a, b, c, d, x[ 3], S31);      /* 45 */
  HH (d, a, b, c, x[11], S32);      /* 46 */
  HH (c, d, a, b, x[ 7], S33);      /* 47 */
  HH (b, c, d, a, x[15], S34);      /* 48 */

  state[0] += a;
  state[1] += b;
  state[2] += c;
  state[3] += d;

  /* Zeroize sensitive information.*/
  memset ((POINTER)x, 0, sizeof (x));
}

/* MD4 initialization. Begins an MD4 operation, writing a new context. */
void MD4_Init( MD4_CTX *context ) {
  context->count[0] = context->count[1] = 0;

  /* Load magic initialization constants.*/
  context->state[0] = 0x67452301;
  context->state[1] = 0xefcdab89;
  context->state[2] = 0x98badcfe;
  context->state[3] = 0x10325476;
}

/* MD4 block update operation. Continues an MD4 message-digest operation, processing another message block, and updating the context. */
void MD4_Update( MD4_CTX *context, const unsigned char *input, unsigned int inputLen ) {
  unsigned int i, index, partLen;

  /* Compute number of bytes mod 64 */
  index = (unsigned int)((context->count[0] >> 3) & 0x3F);

  /* Update number of bits */
  if ((context->count[0] += ((UINT4)inputLen << 3))< ((UINT4)inputLen << 3)) {
    context->count[1]++;
  }

  context->count[1] += ((UINT4)inputLen >> 29);

  partLen = 64 - index;

  /* Transform as many times as possible.*/
  if ( inputLen >= partLen ) {
    memcpy((POINTER)&context->buffer[index], (POINTER)input, partLen);
    MD4_Transform (context->state, context->buffer);

    for ( i = partLen; i + 63 < inputLen; i += 64 ) {
      MD4_Transform (context->state, &input[i]);
    }

    index = 0;
  } else {
    i = 0;
  }

  /* Buffer remaining input */
  memcpy ((POINTER)&context->buffer[index], (POINTER)&input[i], inputLen-i);
}

/* MD4 finalization. Ends an MD4 message-digest operation, writing the message digest and zeroizing the context. */
void MD4_Final( MD4_CTX *context, unsigned char digest[16] ) {
  unsigned char bits[8];
  unsigned int index, padLen;

  /* Save number of bits */
  Encode( bits, context->count, 8 );

  /* Pad out to 56 mod 64.*/
  index = (unsigned int)((context->count[0] >> 3) & 0x3f);
  padLen = (index < 56) ? (56 - index) : (120 - index);
  MD4_Update (context, PADDING, padLen);

  /* Append length (before padding) */
  MD4_Update( context, bits, 8 );
  
  /* Store state in digest */
  Encode( digest, context->state, 16 );

  /* Zeroize sensitive information.*/
  memset ((POINTER)context, 0, sizeof (*context));
}

/*
===============
MD4_BlockChecksum
===============
*/
unsigned long MD4_BlockChecksum( const void *data, int length ) {
  unsigned long digest[4];
  unsigned long val;
  MD4_CTX     ctx;

  MD4_Init( &ctx );
  MD4_Update( &ctx, (unsigned char *)data, length );
  MD4_Final( &ctx, (unsigned char *)digest );

  val = digest[0] ^ digest[1] ^ digest[2] ^ digest[3];

  return val;
}

/*
================================================================================================
Contains the MD5BlockChecksum implementation.
================================================================================================
*/

// POINTER defines a generic pointer type
typedef unsigned char *POINTER;

// UINT2 defines a two byte word
typedef unsigned short int UINT2;

// UINT4 defines a four byte word
typedef unsigned int UINT4;

//------------------------
// The four core functions - F1 is optimized somewhat
// JDC: I wouldn't have condoned the change in something as sensitive as a hash function,
// but it looks ok and a random test function checked it out.
//------------------------
// #define F1(x, y, z) (x & y | ~x & z)
#define F1(x, y, z) (z ^ (x & (y ^ z)))
#define F2(x, y, z) F1(z, x, y)
#define F3(x, y, z) (x ^ y ^ z)
#define F4(x, y, z) (y ^ (x | ~z))

// This is the central step in the MD5 algorithm.
#define MD5STEP(f, w, x, y, z, data, s) ( w += f(x, y, z) + (data),  w = w<<s | w>>(32-s),  w += x )

static unsigned char PADDING[64] = {
0x80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};

/*
========================
Encode

Encodes input (UINT4) into output (unsigned char). Assumes len is a multiple of 4.
========================
*/
static void Encode( unsigned char *output, UINT4 *input, unsigned int len ) {
  unsigned int i, j;

  for ( i = 0, j = 0; j < len; i++, j += 4 ) {
    output[j] = (unsigned char)(input[i] & 0xff);
    output[j+1] = (unsigned char)((input[i] >> 8) & 0xff);
    output[j+2] = (unsigned char)((input[i] >> 16) & 0xff);
    output[j+3] = (unsigned char)((input[i] >> 24) & 0xff);
  }
}

/*
========================
Decode

Decodes input (unsigned char) into output (UINT4). Assumes len is a multiple of 4.
========================
*/
static void Decode( UINT4 *output, const unsigned char *input, unsigned int len ) {
  unsigned int i, j;

  for ( i = 0, j = 0; j < len; i++, j += 4 ) {
    output[i] = ((UINT4)input[j]) | (((UINT4)input[j+1]) << 8) | (((UINT4)input[j+2]) << 16) | (((UINT4)input[j+3]) << 24);
  }
}

/*
========================
MD5_Transform

The core of the MD5 algorithm, this alters an existing MD5 hash to reflect the addition of 16 
longwords of new data. MD5Update blocks the data and converts bytes into longwords for this 
routine.
========================
*/
void MD5_Transform( unsigned int state[4], const unsigned char block[64] ) {
  unsigned int a, b, c, d, x[16];

  a = state[0];
  b = state[1];
  c = state[2];
  d = state[3];

  Decode( x, block, 64 );

  MD5STEP( F1, a, b, c, d, x[ 0] + 0xd76aa478,  7 );
  MD5STEP( F1, d, a, b, c, x[ 1] + 0xe8c7b756, 12 );
  MD5STEP( F1, c, d, a, b, x[ 2] + 0x242070db, 17 );
  MD5STEP( F1, b, c, d, a, x[ 3] + 0xc1bdceee, 22 );
  MD5STEP( F1, a, b, c, d, x[ 4] + 0xf57c0faf,  7 );
  MD5STEP( F1, d, a, b, c, x[ 5] + 0x4787c62a, 12 );
  MD5STEP( F1, c, d, a, b, x[ 6] + 0xa8304613, 17 );
  MD5STEP( F1, b, c, d, a, x[ 7] + 0xfd469501, 22 );
  MD5STEP( F1, a, b, c, d, x[ 8] + 0x698098d8,  7 );
  MD5STEP( F1, d, a, b, c, x[ 9] + 0x8b44f7af, 12 );
  MD5STEP( F1, c, d, a, b, x[10] + 0xffff5bb1, 17 );
  MD5STEP( F1, b, c, d, a, x[11] + 0x895cd7be, 22 );
  MD5STEP( F1, a, b, c, d, x[12] + 0x6b901122,  7 );
  MD5STEP( F1, d, a, b, c, x[13] + 0xfd987193, 12 );
  MD5STEP( F1, c, d, a, b, x[14] + 0xa679438e, 17 );
  MD5STEP( F1, b, c, d, a, x[15] + 0x49b40821, 22 );

  MD5STEP( F2, a, b, c, d, x[ 1] + 0xf61e2562,  5 );
  MD5STEP( F2, d, a, b, c, x[ 6] + 0xc040b340,  9 );
  MD5STEP( F2, c, d, a, b, x[11] + 0x265e5a51, 14 );
  MD5STEP( F2, b, c, d, a, x[ 0] + 0xe9b6c7aa, 20 );
  MD5STEP( F2, a, b, c, d, x[ 5] + 0xd62f105d,  5 );
  MD5STEP( F2, d, a, b, c, x[10] + 0x02441453,  9 );
  MD5STEP( F2, c, d, a, b, x[15] + 0xd8a1e681, 14 );
  MD5STEP( F2, b, c, d, a, x[ 4] + 0xe7d3fbc8, 20 );
  MD5STEP( F2, a, b, c, d, x[ 9] + 0x21e1cde6,  5 );
  MD5STEP( F2, d, a, b, c, x[14] + 0xc33707d6,  9 );
  MD5STEP( F2, c, d, a, b, x[ 3] + 0xf4d50d87, 14 );
  MD5STEP( F2, b, c, d, a, x[ 8] + 0x455a14ed, 20 );
  MD5STEP( F2, a, b, c, d, x[13] + 0xa9e3e905,  5 );
  MD5STEP( F2, d, a, b, c, x[ 2] + 0xfcefa3f8,  9 );
  MD5STEP( F2, c, d, a, b, x[ 7] + 0x676f02d9, 14 );
  MD5STEP( F2, b, c, d, a, x[12] + 0x8d2a4c8a, 20 );

  MD5STEP( F3, a, b, c, d, x[ 5] + 0xfffa3942,  4 );
  MD5STEP( F3, d, a, b, c, x[ 8] + 0x8771f681, 11 );
  MD5STEP( F3, c, d, a, b, x[11] + 0x6d9d6122, 16 );
  MD5STEP( F3, b, c, d, a, x[14] + 0xfde5380c, 23 );
  MD5STEP( F3, a, b, c, d, x[ 1] + 0xa4beea44,  4 );
  MD5STEP( F3, d, a, b, c, x[ 4] + 0x4bdecfa9, 11 );
  MD5STEP( F3, c, d, a, b, x[ 7] + 0xf6bb4b60, 16 );
  MD5STEP( F3, b, c, d, a, x[10] + 0xbebfbc70, 23 );
  MD5STEP( F3, a, b, c, d, x[13] + 0x289b7ec6,  4 );
  MD5STEP( F3, d, a, b, c, x[ 0] + 0xeaa127fa, 11 );
  MD5STEP( F3, c, d, a, b, x[ 3] + 0xd4ef3085, 16 );
  MD5STEP( F3, b, c, d, a, x[ 6] + 0x04881d05, 23 );
  MD5STEP( F3, a, b, c, d, x[ 9] + 0xd9d4d039,  4 );
  MD5STEP( F3, d, a, b, c, x[12] + 0xe6db99e5, 11 );
  MD5STEP( F3, c, d, a, b, x[15] + 0x1fa27cf8, 16 );
  MD5STEP( F3, b, c, d, a, x[ 2] + 0xc4ac5665, 23 );

  MD5STEP( F4, a, b, c, d, x[ 0] + 0xf4292244,  6 );
  MD5STEP( F4, d, a, b, c, x[ 7] + 0x432aff97, 10 );
  MD5STEP( F4, c, d, a, b, x[14] + 0xab9423a7, 15 );
  MD5STEP( F4, b, c, d, a, x[ 5] + 0xfc93a039, 21 );
  MD5STEP( F4, a, b, c, d, x[12] + 0x655b59c3,  6 );
  MD5STEP( F4, d, a, b, c, x[ 3] + 0x8f0ccc92, 10 );
  MD5STEP( F4, c, d, a, b, x[10] + 0xffeff47d, 15 );
  MD5STEP( F4, b, c, d, a, x[ 1] + 0x85845dd1, 21 );
  MD5STEP( F4, a, b, c, d, x[ 8] + 0x6fa87e4f,  6 );
  MD5STEP( F4, d, a, b, c, x[15] + 0xfe2ce6e0, 10 );
  MD5STEP( F4, c, d, a, b, x[ 6] + 0xa3014314, 15 );
  MD5STEP( F4, b, c, d, a, x[13] + 0x4e0811a1, 21 );
  MD5STEP( F4, a, b, c, d, x[ 4] + 0xf7537e82,  6 );
  MD5STEP( F4, d, a, b, c, x[11] + 0xbd3af235, 10 );
  MD5STEP( F4, c, d, a, b, x[ 2] + 0x2ad7d2bb, 15 );
  MD5STEP( F4, b, c, d, a, x[ 9] + 0xeb86d391, 21 );

  state[0] += a;
  state[1] += b;
  state[2] += c;
  state[3] += d;

  // Zeroize sensitive information.
  memset( (POINTER)x, 0, sizeof( x ) );
}

/*
========================
MD5_Init

MD5 initialization. Begins an MD5 operation, writing a new context.
========================
*/
void MD5_Init( MD5_CTX *ctx ) {
  ctx->state[0] = 0x67452301;
  ctx->state[1] = 0xefcdab89;
  ctx->state[2] = 0x98badcfe;
  ctx->state[3] = 0x10325476;

  ctx->bits[0] = 0;
  ctx->bits[1] = 0;
}

/*
========================
MD5_Update

MD5 block update operation. Continues an MD5 message-digest operation, processing another 
message block, and updating the context.
========================
*/
void MD5_Update( MD5_CTX *context, unsigned char const *input, size_t inputLen ) {
  unsigned int i, index, partLen;

  // Compute number of bytes mod 64
  index = (unsigned int)((context->bits[0] >> 3) & 0x3F);

  // Update number of bits
  if ((context->bits[0] += ((UINT4)inputLen << 3))< ((UINT4)inputLen << 3)) {
    context->bits[1]++;
  }

  context->bits[1] += ((UINT4)inputLen >> 29);

  partLen = 64 - index;

  // Transform as many times as possible.
  if ( inputLen >= partLen ) {
    memcpy( (POINTER)&context->in[index], (POINTER)input, partLen );
    MD5_Transform( context->state, context->in );

    for ( i = partLen; i + 63 < inputLen; i += 64 ) {
      MD5_Transform( context->state, &input[i] );
    }

    index = 0;
  } else {
    i = 0;
  }

  // Buffer remaining input
  memcpy( (POINTER)&context->in[index], (POINTER)&input[i], inputLen-i );
}

/*
========================
MD5_Final

MD5 finalization. Ends an MD5 message-digest operation, writing the message digest and 
zero-izing the context.
========================
*/
void MD5_Final( MD5_CTX *context, unsigned char digest[16] ) {
  unsigned char bits[8];
  unsigned int index, padLen;

  // Save number of bits
  Encode( bits, context->bits, 8 );

  // Pad out to 56 mod 64.
  index = (unsigned int)((context->bits[0] >> 3) & 0x3f);
  padLen = (index < 56) ? (56 - index) : (120 - index);
  MD5_Update( context, PADDING, padLen );

  // Append length (before padding)
  MD5_Update( context, bits, 8 );
  
  // Store state in digest
  Encode( digest, context->state, 16 );

  // Zeroize sensitive information.
  memset( (POINTER)context, 0, sizeof( *context ) );
}

/*
========================
MD5_BlockChecksum
========================
*/

unsigned int MD5_BlockChecksum( const void *data, size_t length ) {
  unsigned char digest[16];
  unsigned int  val;
  MD5_CTX     ctx;

  MD5_Init( &ctx );
  MD5_Update( &ctx, (unsigned char *)data, length );
  MD5_Final( &ctx, (unsigned char *)digest );

  // Handle it manually to be endian-safe since we don't have access to idSwap.
  val = ( digest[3] << 24 | digest[2] << 16 | digest[1] << 8 | digest[0] ) ^ 
      ( digest[7] << 24 | digest[6] << 16 | digest[5] << 8 | digest[4] ) ^
      ( digest[11] << 24 | digest[10] << 16 | digest[9] << 8 | digest[8] ) ^
      ( digest[15] << 24 | digest[14] << 16 | digest[13] << 8 | digest[12] );

  return val;
}

  end Neo.File;