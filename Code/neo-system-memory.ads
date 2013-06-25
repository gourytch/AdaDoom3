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
  Interfaces.C,
  Neo.Foundation.Output,
  Neo.Foundation.Data_Types;
use
  System,
  Interfaces,
  Interfaces.C,
  Neo.Foundation.Output,
  Neo.Foundation.Data_Types;
package Neo.System.Memory
  is
  -------------
  -- Records --
  -------------
    type Record_State
      is record
        Load                                       : Float_4_Percent    := 0.0;
        Number_Of_Disk_Bytes_Total                 : Integer_8_Unsigned := 0;
        Number_Of_Disk_Bytes_Available             : Integer_8_Unsigned := 0;
        Number_Of_Physical_Bytes_Total             : Integer_8_Unsigned := 0;
        Number_Of_Physical_Bytes_Available         : Integer_8_Unsigned := 0;
        Number_Of_Page_File_Bytes_Total            : Integer_8_Unsigned := 0;
        Number_Of_Page_File_Bytes_Available        : Integer_8_Unsigned := 0;
        Number_Of_Virtual_Bytes_Total              : Integer_8_Unsigned := 0;
        Number_Of_Virtual_Bytes_Available          : Integer_8_Unsigned := 0;
        Number_Of_Virtual_Bytes_Available_Extended : Integer_8_Unsigned := 0;
      end record;
  --------------
  -- Packages --
  --------------
    generic
      type Type_To_Manage
        is private;
    package Manager
      is
        procedure Lock(
          Item : in out Type_To_Manage);
        procedure Unlock(
          Item : in out Type_To_Manage);
      end Manager;
  -----------------
  -- Subprograms --
  -----------------
    procedure Test;
    procedure Set_Byte_Limits(
      Minimum : in Integer_8_Unsigned;
      Maximum : in Integer_8_Unsigned)
      with Pre => Minimum < Maximum;
    function Get_State
      return Record_State;
    function Get_State_At_Launch
      return Record_State;
-------
private
-------
  ---------------
  -- Constants --
  ---------------
    FAILED_LOCK            : constant String_2 := "Failed to lock memory location!";
    FAILED_UNLOCK          : constant String_2 := "Failed to unlock memory location!";
    FAILED_SET_BYTE_LIMITS : constant String_2 := "Failed to set byte limits!";
  --------------------
  -- Implementation --
  --------------------
    package Implementation
      is
        function Get_State
          return Record_State;
        procedure Set_Byte_Limits(
          Minimum : in Integer_8_Unsigned;
          Maximum : in Integer_8_Unsigned)
          with Pre => Minimum < Maximum;
        procedure Lock(
          Location        : in Address;
          Number_Of_Bytes : in Integer_8_Unsigned);
        procedure Unlock(
          Location        : in Address;
          Number_Of_Bytes : in Integer_8_Unsigned);
      end Implementation;
  end Neo.System.Memory;
