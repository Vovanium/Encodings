with Ada.Unchecked_Conversion;
with Ada.Streams;
use  Ada.Streams;
use type Ada.Streams.Stream_Element_Offset;

package body Encodings.Utility is

	--generic
	--	type Element_Type is private;
	--	type Index_Type is (<>);
	--	type Array_Type is array(Index_Type range <>) of Element_Type;
	procedure Read_Array(
		Stream: in out Root_Stream_Type'Class;
		Item: out Array_Type;
		Last: out Index_Type'Base
	) is
		Element_Length: constant Stream_Element_Offset := Element_Type'Stream_Size / Stream_Element'Size;
		Buffer_Length: constant Stream_Element_Offset := Item'Length * Element_Length;
		Buffer: Stream_Element_Array(1 .. Buffer_Length);
		Buffer_I, Buffer_Last: Stream_Element_Offset;
		Element_Count: Natural;
		function Conversion is new Ada.Unchecked_Conversion(
			Source => Stream_Element_Array,
			Target => Element_Type
		);
	begin
		Stream.Read(Buffer, Buffer_Last);
		Element_Count := Natural(Buffer_Last / Element_Length);
		Last := Item'First; -- + (Element_Count - 1);
		Buffer_I := 1;
		for I in 1..Element_Count loop
			Item(Last) := Conversion(Buffer(Buffer_I .. Buffer_I + Element_Length - 1));
			Last := Index_Type'Succ(Last);
			Buffer_I := Buffer_I + Element_Length;
		end loop;
		Last := Index_Type'Pred(Last);
	end;

	-- Strange, GNAT cannot use generic instance for package subprogram
	procedure Read_String(Stream: in out Root_Stream_Type'Class; Item: out String; Last: out Positive'Base) is
		procedure Inst is new Read_Array(Element_Type => Character, Index_Type => Positive, Array_Type => String);
	begin
		Inst(Stream, Item, Last);
	end;

end Encodings.Utility;
