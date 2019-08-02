with Ada.Streams;
use  Ada.Streams;
-- Several utilities to ease encoded string processing
package Encodings.Utility is
	pragma Pure;

	-- Generic array version of Stream.Read returning last element written
	generic
		type Element_Type is (<>);
		type Index_Type is (<>);
		type Array_Type is array(Index_Type range <>) of Element_Type;
	procedure Read_Array(
		Stream: in out Root_Stream_Type'Class;
		Item: out Array_Type;
		Last: out Index_Type'Base
	);
	
	procedure Read_String(Stream: in out Root_Stream_Type'Class; Item: out String; Last: out Positive'Base);

end Encodings.Utility;
