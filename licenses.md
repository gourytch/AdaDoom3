License
-------
Unless otherwise noted in the files section, all code is GNU Public Licence version 3.
http://www.gnu.org/licenses/gpl-3.0.txt

    Doom 3 BFG Edition GPL Source Code
    Copyright (C) 1993-2012 id Software LLC, a ZeniMax Media company. 

    This file is part of the Doom 3 BFG Edition GPL Source Code ("Doom 3 BFG Edition Source Code").  

    Doom 3 BFG Edition Source Code is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Doom 3 BFG Edition Source Code is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Doom 3 BFG Edition Source Code.  If not, see <http://www.gnu.org/licenses/>.

    In addition, the Doom 3 BFG Edition Source Code is also subject to certain additional terms. You should have received a copy
    of these additional terms immediately following the terms and conditions of the GNU General Public License which accompanied
    the Doom 3 BFG Edition Source Code.  If not, please request a copy in writing from id Software at the address below.

    If you have questions concerning this license or the applicable additional terms, you may contact in writing
    id Software LLC, c/o ZeniMax Media Inc., Suite 120, Rockville, Maryland 20850 USA.

Files
-----

> neo-file-image-bmp.adb, neo-file-image-ppx.adb

    Lumen -- A simple graphical user interface library based on OpenGL

    Chip Richards, NiEstu, Phoenix AZ, Spring 2010

    Lumen would not be possible without the support and contributions of a cast
    of thousands, including and primarily Rod Kay.

    This code is covered by the ISC License:

    Copyright © 2010, NiEstu

    Permission to use, copy, modify, and/or distribute this software for any
    purpose with or without fee is hereby granted, provided that the above
    copyright notice and this permission notice appear in all copies.

    The software is provided "as is" and the author disclaims all warranties
    with regard to this software including all implied warranties of
    merchantability and fitness. In no event shall the author be liable for any
    special, direct, indirect, or consequential damages or any damages
    whatsoever resulting from loss of use, data or profits, whether in an
    action of contract, negligence or other tortious action, arising out of or
    in connection with the use or performance of this software.

> neo-file-image-png.adb, neo-file-image-gif.adb, neo-file-image-tga.adb, neo-file-image-jpeg.adb

    ---------------------------------
    -- GID - Generic Image Decoder --
    ---------------------------------

    Purpose:

      The Generic Image Decoder is a package for decoding a broad
      variety of image formats, from any data stream, to any kind
      of medium, be it an in-memory bitmap, a GUI object,
      some other stream, arrays of floating-point initial data
      for scientific calculations, a browser element, a device,...
      Animations are supported.

      The code is unconditionally portable, independent of the
      choice of operating system, processor, endianess and compiler.

    Image types currently supported:

      BMP, GIF, JPEG, PNG, TGA

    Credits:

      - André van Splunter: GIF's LZW decoder
      - Martin J. Fiedler: most of the JPEG decoder (from NanoJPEG)
      - Tom Moran: various considerations
      - Bob Sutton: contribs to BMP


    Copyright (c) Gautier de Montmollin 2010..2012

     Permission is hereby granted, free of charge, to any person obtaining a copy
     of this software and associated documentation files (the "Software"), to deal
     in the Software without restriction, including without limitation the rights
     to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
     copies of the Software, and to permit persons to whom the Software is
     furnished to do so, subject to the following conditions:

     The above copyright notice and this permission notice shall be included in
     all copies or substantial portions of the Software.

     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
     IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
     AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
     LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
     OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
     THE SOFTWARE.

    NB: this is the MIT License, as found 2-May-2010 on the site
    http://www.opensource.org/licenses/mit-license.php