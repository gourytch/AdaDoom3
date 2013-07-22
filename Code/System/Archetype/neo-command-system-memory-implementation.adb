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
  Neo.Example;
use
  Neo.Example;
separate(Neo.System.Memory)
package body Implementation
  is
  ----------------
  -- Get_Status --
  ----------------
    function Get_State
      return Record_State
      is
      begin
        raise Unimplemented_Feature;
        return (others => <>);
      end Get_State;
  ---------------------
  -- Set_Byte_Limits --
  ---------------------
    procedure Set_Byte_Limits(
      Minimum : in Integer_8_Unsigned;
      Maximum : in Integer_8_Unsigned)
      is
      begin
        raise Unimplemented_Feature;
      end Set_Byte_Limits;
  ----------
  -- Lock --
  ----------
    procedure Lock(
      Location        : in Address;
      Number_Of_Bytes : in Integer_8_Unsigned)
      is
      begin
        raise Unimplemented_Feature;
      end Lock;
  ------------
  -- Unlock --
  ------------
    procedure Unlock(
      Location        : in Address;
      Number_Of_Bytes : in Integer_8_Unsigned)
      is
      begin
        raise Unimplemented_Feature;
      end Unlock;
  end Implementation;

