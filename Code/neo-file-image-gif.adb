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
separate(Neo.File.Image)
package body GIF
  is
  ----------
  -- Load --
  ----------
    overriding function Load(
      Tag         : in Archetype.Tag;
      Path        : in String_2;
      Start_Frame : in Integer_4_Positive := 1;
      For_Frames  : in Integer_4_Natural  := 0)
      return Array_Record_Graphic
      is
      begin
        raise Unimplemented_Feature;
      end Load;
  ----------
  -- Save --
  ----------
    overriding procedure Save(
      Tag     : in Archetype.Tag;
      Path    : in String_2;
      Graphic : in Array_Record_Graphic)
      is
      begin
        raise Unimplemented_Feature;
      end Save;
  end GIF;
  -- ------------------
  -- -- Enumerations --
  -- ------------------
    -- type Enumerated_Marker
      -- is(
      -- Specifics_Marker,
      -- Frame_Marker,
      -- Extensions_Marker);
    -- for Enumerated_Marker'image
      -- is(
      -- Start_Marker      => ',',
      -- Extensions_Marker => '!',
      -- End_Marker        => ';');
    -- type Enumerated_Extension_Marker
      -- is(
      -- Graphic_Control_Extension_Marker);
    -- for Enumerated_Extension_Marker
      -- is(
      -- Graphic_Control_Extension_Marker => 'ù');
  -- ----------------
  -- -- Variables --
  -- ---------------
    -- subtype Code_size_range
      -- is Natural range 2..12;
    -- subtype Color_type
      -- is U8;
    -- CurrSize     : Code_size_range;
    -- local        : Image_descriptor;
    -- Descriptor   : GIFDescriptor;
    -- X, tlX, brX  : Natural;
    -- Y, tlY, brY  : Natural;
    -- Transp_color : Color_type := 0;
    -- block_size   : Natural    := 0;
    -- block_read   : Natural    := 0;
    -- bits_in      : U8         := 8;
    -- bits_buf     : U8;
  -- -----------------
  -- -- Subprograms --
  -- -----------------
    -- function Read_Byte return U8 is
    -- pragma Inline(Read_Byte);
      -- b: U8;
      -- use Ada.Streams;
    -- begin
      -- if block_read >= block_size then
        -- Get_Byte(image.buffer, b);
        -- block_size:= Natural(b);
        -- block_read:= 0;
      -- end if;
      -- Get_Byte(image.buffer, b);
      -- block_read:= block_read + 1;
      -- return b;
    -- end Read_Byte;
    -- function Read_Code return Natural is
      -- bit_mask: Natural:= 1;
      -- code: Natural:= 0;
    -- begin
      -- for Counter  in reverse  0..CurrSize - 1  loop
        -- bits_in:= bits_in + 1;
        -- if bits_in = 9 then
          -- bits_buf:= Read_Byte;
          -- bits_in := 1;
        -- end if;
        -- -- Add the current bit to the code
        -- if (bits_buf  and  1) > 0 then
          -- code:= code + bit_mask;
        -- end if;
        -- bit_mask := bit_mask * 2;
        -- bits_buf := bits_buf / 2;
      -- end loop;
      -- return code;
    -- end Read_Code;
  -- procedure Read_Intel_x86_number(
    -- from : in out Input_buffer;
    -- n    :    out Number)
    -- is
    -- b: U8;
    -- m: Number:= 1;
    -- begin
      -- for I in 1..Number'Size / Byte'size loop
        -- GID.Buffering.Get_Byte(from, b);
        -- n:= n + m * Number(b);
        -- m:= m * 256;
      -- end loop;
    -- end Read_Intel_x86_number;
  -- procedure Read_Intel is new Read_Intel_x86_number( U16 );
  -- ----------
  -- -- Save --
  -- ----------
    -- overriding procedure Save(
      -- Tag     : in Example.Tag;
      -- Path    : in String_2;
      -- Graphic : in Array_Record_Graphic)
      -- is
      -- begin
        -- raise Unimplemented_Feature;
      -- end Save;
  -- ----------
  -- -- Load --
  -- ----------
    -- overriding function Load(
      -- Tag         : in Example.Tag;
      -- Path        : in String_2;
      -- Start_Frame : in Integer_4_Positive := 1;
      -- For_Frames  : in Integer_4_Natural  := 0)
      -- return Array_Record_Graphic
      -- is
      -- ImageLeft   : U16;
      -- ImageTop    : U16;
      -- ImageWidth  : U16;
      -- ImageHeight : U16;
      -- Depth       : U8;
      -- Graphics    : Vector_Graphic;
      -- temp, temp2, label: U8;
      -- delay_frame: U16;
      -- c: Character;
      -- frame_interlaced: Boolean;
      -- frame_transparency: Boolean:= False;
      -- local_palette  : Boolean;
      -- --
      -- separator :  Character ;
      -- -- Colour information
      -- new_num_of_colours : Natural;
      -- pixel_mask : U32;
      -- BitsPerPixel  : Natural;
      -- begin
        -- loop
          -- Integer_1_Unsigned'read(image.buffer, temp);
          -- case Enumerated_Marker'Val(Marker) is
            -- when End_Marker =>
              -- Graphic.Duration_Until_Next := 0.0;
              -- return To_Array(Graphics);
            -- when Extensions_Marker =>
              -- Integer_1_Unsigned'read(image.buffer, Marker);
              -- case Marker is
                -- when Graphic_Control_Extension_Marker =>
                  -- Integer_1_Unsigned'read(image.buffer, Marker);
                  -- if Marker /= 4 then
                    -- raise Currupt;
                  -- end if;
                  -- Integer_1_Unsigned'read(image.buffer, frame_transparency);
                  -- Skip(image.buffer, 1);
                  -- Integer_1_Unsigned'read(image.buffer, Delay_Frame);
                  -- Integer_1_Unsigned'read(image.buffer, Transp_color);
                  -- Skip(image.buffer, 1);
                  -- frame_transparency  := 1 = (frame_transparency and 1);
                  -- Duration_Until_Next := Duration_Until_Next + Day_Duration(To__Order_Byte_(Delay_Frame)) / 100.0;
                  -- Transp_color        := Color_Type(Transp_color);
                -- when others =>
                  -- loop
                    -- Integer_1_Unsigned'read(image.buffer, Marker);
                    -- exit when Marker = 0;
                    -- Skip(image.buffer, Marker);
                  -- end loop;
              -- end case;
            -- when Start_Marker =>
              -- Integer_1_Unsigned'read(image.buffer, Descriptor.ImageLeft);
              -- Integer_1_Unsigned'read(image.buffer, Descriptor.ImageTop);
              -- Integer_1_Unsigned'read(image.buffer, Descriptor.ImageWidth);
              -- Integer_1_Unsigned'read(image.buffer, Descriptor.ImageHeight);
              -- Integer_1_Unsigned'read(image.buffer, Descriptor.Depth);
              -- tlX := Natural(Descriptor.ImageLeft);
              -- tlY := Natural(Descriptor.ImageTop);
              -- brX := tlX + Natural(Descriptor.ImageWidth);
              -- brY := tlY + Natural(Descriptor.ImageHeight);
              -- ------
              -- Build:
              -- ------
                -- declare
                -- Interlace_pass : Natural range 1..4:= 1;
                -- Span           : Natural:= 7;
                -- Prefix       : array ( 0..4096 ) of Natural:= (others => 0);
                -- Suffix       : array ( 0..4096 ) of Natural:= (others => 0);
                -- Stack        : array ( 0..1024 ) of Natural;
                -- ClearCode    : constant Natural:= 2 ** CurrSize;
                -- EndingCode   : constant Natural:= ClearCode + 1;
                -- FirstFree    : constant Natural:= ClearCode + 2; -
                -- Slot         : Natural:= FirstFree;
                -- InitCodeSize : constant Code_size_range:= CurrSize + 1;
                -- TopSlot      : Natural:= 2 ** InitCodeSize;
                -- Code         : Natural;
                -- StackPtr     : Integer:= 0;
                -- Fc           : Integer:= 0;
                -- Oc           : Integer:= 0;
                -- C            : Integer;
                -- BadCodeCount : Natural:= 0;
                -- frame_interlaced := (Descriptor.Depth and 64) = 64;
                -- local_palette    := (Descriptor.Depth and 128) = 128;
                -- local.format     := GIF;
                -- local.stream     := image.stream;
                -- local.buffer     := image.buffer;
                -- begin
                  -- if local_palette then
                    -- BitsPerPixel := 1 + Natural(Descriptor.Depth and 7);
                    -- New_num_of_colour s:= 2 ** BitsPerPixel;
                    -- local.palette:= new Color_table(0..New_num_of_colours-1);
                    -- Color_tables.Load_palette(local);
                    -- image.buffer:= local.buffer;
                  -- elsif image.palette = null then
                    -- raise error_in_image_data;
                  -- else
                    -- New_num_of_colours := 2**image.subformat_id;
                    -- local.palette:= new Color_table'(image.palette.all);
                  -- end if;
                  -- Pixel_mask:= U32(New_num_of_colours - 1);
                  -- Get_Byte(image.buffer, temp );
                  -- if Natural(temp) not in Code_size_range then
                    -- raise Currupt with "wrong LZW code size (must be in 2..12), is" & U8'Image(temp);
                  -- end if;
                  -- Set_X_Y(
                    -- := Natural(temp);
                    -- := Natural(Descriptor.ImageLeft);
                    -- := Natural(Descriptor.ImageTop);
                    -- X, image.height - Y - 1);
                  -- if new_num_of_colours < 256 then
                    -- declare
                      -- procedure GIF_Decode_general is
                        -- new GIF_Decode(frame_interlaced, frame_transparency, pixel_mask);
                    -- begin
                      -- GIF_Decode_general;
                    -- end;
                  -- else
                    -- if frame_interlaced then
                      -- if frame_transparency then
                        -- GIF_Decode_interlaced_transparent_8;
                      -- else
                        -- GIF_Decode_interlaced_opaque_8;
                      -- end if;
                    -- else
                      -- if frame_transparency then
                        -- GIF_Decode_straight_transparent_8;
                      -- else
                        -- GIF_Decode_straight_opaque_8;
                      -- end if;
                    -- end if;
                  -- end if;
                  -- if transparency and then b = Transp_color then
                    -- Put_Pixel(0,0,0, 0);
                    -- return;
                  -- end if;
                  -- Put_Pixel(
                    -- 16#101# * Primary_color_range(local.palette(Integer(b)).red),
                    -- 16#101# * Primary_color_range(local.palette(Integer(b)).green),
                    -- 16#101# * Primary_color_range(local.palette(Integer(b)).blue),
                    -- -- 16#101# because max intensity FF goes to FFFF
                    -- 65_535);
                  -- CurrSize := InitCodeSize;
                  -- C := Read_Code;
                  -- while C /= EndingCode loop
                    -- if C = ClearCode then
                      -- CurrSize := InitCodeSize;
                      -- Slot     := FirstFree;
                      -- TopSlot  := 2 ** CurrSize;
                      -- C := Read_Code;
                      -- while C = ClearCode loop
                        -- C := Read_Code;
                      -- end loop;
                      -- exit when C = EndingCode;
                      -- if C >= Slot then
                        -- C := 0;
                      -- end if;
                      -- Oc := C;
                      -- Fc := C;
                    -- else
                      -- Code := C;
                      -- if Code >= Slot then
                        -- if Code > Slot then
                          -- BadCodeCount := BadCodeCount + 1;
                        -- end if;
                        -- Code := Oc;
                        -- Stack (StackPtr) := Fc rem 256;
                        -- StackPtr := StackPtr + 1;
                      -- end if;
                      -- while Code >= FirstFree loop
                        -- Stack (StackPtr) := Suffix (Code);
                        -- StackPtr := StackPtr + 1;
                        -- Code := Prefix (Code);
                      -- end loop;
                      -- Stack (StackPtr) := Code rem 256;
                      -- if Slot < TopSlot then
                        -- Suffix (Slot) := Code rem 256;
                        -- Fc := Code;
                        -- Prefix (Slot) := Oc;
                        -- Slot := Slot + 1;
                        -- Oc := C;
                      -- end if;
                      -- if Slot >= TopSlot then
                        -- if CurrSize < 12 then
                          -- TopSlot := TopSlot * 2;
                          -- CurrSize := CurrSize + 1;
                        -- end if;
                      -- end if;
                    -- end if;
                    -- loop
                      -- Next_Pixel(C);
                      -- Next_Pixel(Stack (StackPtr));
                      -- procedure Next_Pixel(code: Natural) is
                      -- pragma Inline(Next_Pixel);
                        -- c : constant Color_Type:= Color_type(U32(code) and pixel_mask);
                      -- begin
                        -- -- Actually draw the pixel on screen buffer
                      -- if X < image.width then
                        -- if interlaced and mode = nice then
                          -- for i in reverse 0..Span loop
                            -- if Y+i < image.height then
                              -- Set_X_Y(X, image.height - (Y+i) - 1);
                              -- Pixel_with_palette(c);
                            -- end if;
                          -- end loop;
                        -- elsif Y < image.height then
                          -- Pixel_with_palette(c);
                        -- end if;
                      -- end if;
                      -- -- Move on to next pixel
                      -- X:= X + 1;
                      -- -- Or next row, if necessary
                      -- if X = brX then
                        -- X:= tlX;
                        -- if interlaced then
                          -- case Interlace_pass is
                            -- when 1 =>
                              -- Y:= Y + 8;
                              -- if Y >= brY then
                                -- Y:= 4;
                                -- Interlace_pass:= 2;
                                -- Span:= 3;
                                -- Feedback((Interlace_pass*100)/4);
                              -- end if;
                            -- when 2 =>
                              -- Y:= Y + 8;
                              -- if Y >= brY then
                                -- Y:= 2;
                                -- Interlace_pass:= 3;
                                -- Span:= 1;
                                -- Feedback((Interlace_pass*100)/4);
                              -- end if;
                            -- when 3 =>
                              -- Y:= Y + 4;
                              -- if Y >= brY then
                                -- Y:= 1;
                                -- Interlace_pass:= 4;
                                -- Span:= 0;
                                -- Feedback((Interlace_pass*100)/4);
                              -- end if;
                            -- when 4 =>
                              -- Y:= Y + 2;
                          -- end case;
                          -- if mode = fast and then Y < image.height then
                            -- Set_X_Y(X, image.height - Y - 1);
                          -- end if;
                        -- else -- not interlaced
                          -- Y:= Y + 1;
                          -- if Y < image.height then
                            -- Set_X_Y(X, image.height - Y - 1);
                          -- end if;
                          -- if Y mod 32 = 0 then
                            -- Feedback((Y*100)/image.height);
                          -- end if;
                        -- end if;
                      -- end if;
                      -- exit when StackPtr = 0;
                      -- StackPtr := StackPtr - 1;
                    -- end loop;
                    -- C := Read_Code;
                  -- end loop;
                  -- Get_Byte(image.buffer, temp );
                -- end Build;
          -- end case;
        -- end loop;
      -- end Load;





























































              -- ------
              -- Build:
              -- ------
                -- declare
                -- Interlace_pass : Natural range 1..4:= 1;
                -- Span           : Natural:= 7;
                -- Prefix       : array ( 0..4096 ) of Natural:= (others => 0);
                -- Suffix       : array ( 0..4096 ) of Natural:= (others => 0);
                -- Stack        : array ( 0..1024 ) of Natural;
                -- ClearCode    : constant Natural:= 2 ** CurrSize;
                -- EndingCode   : constant Natural:= ClearCode + 1;
                -- FirstFree    : constant Natural:= ClearCode + 2; -
                -- Slot         : Natural:= FirstFree;
                -- InitCodeSize : constant Code_size_range:= CurrSize + 1;
                -- TopSlot      : Natural:= 2 ** InitCodeSize;
                -- Code         : Natural;
                -- StackPtr     : Integer:= 0;
                -- Fc           : Integer:= 0;
                -- Oc           : Integer:= 0;
                -- C            : Integer;
                -- BadCodeCount : Natural:= 0;
                -- frame_interlaced := (Descriptor.Depth and 64) = 64;
                -- local_palette    := (Descriptor.Depth and 128) = 128;
                -- local.format     := GIF;
                -- local.stream     := image.stream;
                -- local.buffer     := image.buffer;
                -- begin
                  -- if local_palette then
                    -- BitsPerPixel := 1 + Natural(Descriptor.Depth and 7);
                    -- New_num_of_colours:= 2 ** BitsPerPixel;
                    -- local.palette:= new Color_table(0..New_num_of_colours-1);
                    -- Color_tables.Load_palette(local);
                    -- image.buffer:= local.buffer;
                  -- elsif image.palette = null then
                    -- raise error_in_image_data;
                  -- else
                    -- New_num_of_colours := 2**image.subformat_id;
                    -- local.palette:= new Color_table'(image.palette.all);
                  -- end if;
                  -- Pixel_mask:= U32(New_num_of_colours - 1);
                  -- Get_Byte(image.buffer, temp );
                  -- if Natural(temp) not in Code_size_range then
                    -- raise Currupt with "wrong LZW code size (must be in 2..12), is" & U8'Image(temp);
                  -- end if;
                  -- Set_X_Y(
                    -- := Natural(temp);
                    -- := Natural(Descriptor.ImageLeft);
                    -- := Natural(Descriptor.ImageTop);
                    -- X, image.height - Y - 1);
                  -- if new_num_of_colours < 256 then
                    -- declare
                      -- procedure GIF_Decode_general is
                        -- new GIF_Decode(frame_interlaced, frame_transparency, pixel_mask);
                    -- begin
                      -- GIF_Decode_general;
                    -- end;
                  -- else
                    -- if frame_interlaced then
                      -- if frame_transparency then
                        -- GIF_Decode_interlaced_transparent_8;
                      -- else
                        -- GIF_Decode_interlaced_opaque_8;
                      -- end if;
                    -- else
                      -- if frame_transparency then
                        -- GIF_Decode_straight_transparent_8;
                      -- else
                        -- GIF_Decode_straight_opaque_8;
                      -- end if;
                    -- end if;
                  -- end if;
                  -- if transparency and then b = Transp_color then
                    -- Put_Pixel(0,0,0, 0);
                    -- return;
                  -- end if;
                  -- Put_Pixel(
                    -- 16#101# * Primary_color_range(local.palette(Integer(b)).red),
                    -- 16#101# * Primary_color_range(local.palette(Integer(b)).green),
                    -- 16#101# * Primary_color_range(local.palette(Integer(b)).blue),
                    -- -- 16#101# because max intensity FF goes to FFFF
                    -- 65_535);
                  -- CurrSize := InitCodeSize;
                  -- C := Read_Code;
                  -- while C /= EndingCode loop
                    -- if C = ClearCode then
                      -- CurrSize := InitCodeSize;
                      -- Slot     := FirstFree;
                      -- TopSlot  := 2 ** CurrSize;
                      -- C := Read_Code;
                      -- while C = ClearCode loop
                        -- C := Read_Code;
                      -- end loop;
                      -- exit when C = EndingCode;
                      -- if C >= Slot then
                        -- C := 0;
                      -- end if;
                      -- Oc := C;
                      -- Fc := C;
                    -- else
                      -- Code := C;
                      -- if Code >= Slot then
                        -- if Code > Slot then
                          -- BadCodeCount := BadCodeCount + 1;
                        -- end if;
                        -- Code := Oc;
                        -- Stack (StackPtr) := Fc rem 256;
                        -- StackPtr := StackPtr + 1;
                      -- end if;
                      -- while Code >= FirstFree loop
                        -- Stack (StackPtr) := Suffix (Code);
                        -- StackPtr := StackPtr + 1;
                        -- Code := Prefix (Code);
                      -- end loop;
                      -- Stack (StackPtr) := Code rem 256;
                      -- if Slot < TopSlot then
                        -- Suffix (Slot) := Code rem 256;
                        -- Fc := Code;
                        -- Prefix (Slot) := Oc;
                        -- Slot := Slot + 1;
                        -- Oc := C;
                      -- end if;
                      -- if Slot >= TopSlot then
                        -- if CurrSize < 12 then
                          -- TopSlot := TopSlot * 2;
                          -- CurrSize := CurrSize + 1;
                        -- end if;
                      -- end if;
                    -- end if;
                    -- loop
                      -- Next_Pixel(C);
                      -- Next_Pixel(Stack (StackPtr));
                      -- procedure Next_Pixel(code: Natural) is
                      -- pragma Inline(Next_Pixel);
                        -- c : constant Color_Type:= Color_type(U32(code) and pixel_mask);
                      -- begin
                        -- -- Actually draw the pixel on screen buffer
                      -- if X < image.width then
                        -- if interlaced and mode = nice then
                          -- for i in reverse 0..Span loop
                            -- if Y+i < image.height then
                              -- Set_X_Y(X, image.height - (Y+i) - 1);
                              -- Pixel_with_palette(c);
                            -- end if;
                          -- end loop;
                        -- elsif Y < image.height then
                          -- Pixel_with_palette(c);
                        -- end if;
                      -- end if;
                      -- -- Move on to next pixel
                      -- X:= X + 1;
                      -- -- Or next row, if necessary
                      -- if X = brX then
                        -- X:= tlX;
                        -- if interlaced then
                          -- case Interlace_pass is
                            -- when 1 =>
                              -- Y:= Y + 8;
                              -- if Y >= brY then
                                -- Y:= 4;
                                -- Interlace_pass:= 2;
                                -- Span:= 3;
                                -- Feedback((Interlace_pass*100)/4);
                              -- end if;
                            -- when 2 =>
                              -- Y:= Y + 8;
                              -- if Y >= brY then
                                -- Y:= 2;
                                -- Interlace_pass:= 3;
                                -- Span:= 1;
                                -- Feedback((Interlace_pass*100)/4);
                              -- end if;
                            -- when 3 =>
                              -- Y:= Y + 4;
                              -- if Y >= brY then
                                -- Y:= 1;
                                -- Interlace_pass:= 4;
                                -- Span:= 0;
                                -- Feedback((Interlace_pass*100)/4);
                              -- end if;
                            -- when 4 =>
                              -- Y:= Y + 2;
                          -- end case;
                          -- if mode = fast and then Y < image.height then
                            -- Set_X_Y(X, image.height - Y - 1);
                          -- end if;
                        -- else -- not interlaced
                          -- Y:= Y + 1;
                          -- if Y < image.height then
                            -- Set_X_Y(X, image.height - Y - 1);
                          -- end if;
                          -- if Y mod 32 = 0 then
                            -- Feedback((Y*100)/image.height);
                          -- end if;
                        -- end if;
                      -- end if;
                      -- exit when StackPtr = 0;
                      -- StackPtr := StackPtr - 1;
                    -- end loop;
                    -- C := Read_Code;
                  -- end loop;
                  -- Get_Byte(image.buffer, temp );
                -- end Build;
          -- end case;
        -- end loop;
      -- end Load;
