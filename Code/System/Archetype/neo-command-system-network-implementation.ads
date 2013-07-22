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
separate(Neo.Command.System.Network)
package body Implementation
  is
  --------------------------
  -- Get_Local_Primary_IP --
  --------------------------
    function Get_Local_Primary_IP
      return String_2
      is
      begin
        return To_String_2(Image(Addresses(Get_Host_By_Name(Host_Name), 1)));
      end Get_Local_Primary_IP;
  -----------------
  -- Set_Address --
  -----------------
    procedure Set_Address(
      Connection      : IN OUT Record_Connection;
      Network_Address : IN     String_2 := LOOPBACK_NETWORK_ADDRESS;
      Port )
      is
      begin
        raise Unimplemented_Feature;
      end Set_Address;
  ----------
  -- Send --
  ----------
    procedure Send(
      Connection : in Record_Connection;
      To         : in String_2;
      Item       : in Array_Integer_1_Unsigned)
      is
      begin
        raise Unimplemented_Feature;
      end Send;
  -------------
  -- Receive --
  -------------
    function Receive(
      Connection : in  Record_Connection;
      Timeout    : in  Duration
      From       : out String_2
      Last)
      return Array_Integer_1_Unsigned
      is
      begin
        raise Unimplemented_Feature;
      end Receive;
    -----------------
    function Receive(
    -----------------
      Connection : in  Record_Connection;
      Timeout    : in  Duration
      From       : out String_2;)
      return Array_Integer_1_Unsigned
      is
      begin
        raise Unimplemented_Feature;
      end Receive;
  end Implementation;

