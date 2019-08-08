generic
	type Character_Type is (<>);
	type String_Type is array(Positive range <>) of Character_Type;
	Max_Length: Positive;
package Encodings.Utility.Generic_Sequence_Buffers is

	function Remaining_Length(
		Data: String_Type;
		Last: Natural
	) return Natural is (
		if Last >= Data'Last then 0 else Data'Last - Last
	) with
		Pre => Last >= Data'First - 1,
		Post => Remaining_Length'Result in 0 .. Data'Length;

	type Sequence_Buffer is record
		Data: String_Type(1 .. Max_Length);
		First: Positive := 1; -- first position of buffered sequence
		Last: Natural := 0; -- last position of buffered sequence
	end record;

	function Is_Empty(
		Buffer: in Sequence_Buffer
	) return Boolean is (
		Buffer.Last < Buffer.First
	);

	function Length(
		Buffer: in Sequence_Buffer
	) return Natural is (
		if Is_Empty(Buffer) then 0 else Buffer.Last - Buffer.First + 1
	) with
		Post => Length'Result in 0 .. Max_Length;

	procedure Write_Buffered(
		Buffer: in out Sequence_Buffer;
		Target: in out String_Type;
		Target_Last: in out Natural
	);

	procedure Set_Buffer(
		Buffer: in out Sequence_Buffer;
		Source: in String_Type
	) with
		Pre => Is_Empty(Buffer),
		Post => Length(Buffer) = Source'Length;

	procedure Write(
		Buffer: in out Sequence_Buffer;
		Source: in String_Type;
		Target: in out String_Type;
		Target_Last: in out Natural
	) with
		Pre => Is_Empty(Buffer);
	
end Encodings.Utility.Generic_Sequence_Buffers;