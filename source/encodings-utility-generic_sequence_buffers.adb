package body Encodings.Utility.Generic_Sequence_Buffers is

	procedure Write_Buffered(
		Buffer: in out Sequence_Buffer;
		Target: in out String_Type;
		Target_Last: in out Natural
	) is
		Remaining        : Natural  := Remaining_Length(Target, Target'Last - Target_Last);
		Buffered         : Natural  := Length(Buffer);
		Write_Length     : Natural  := Natural'Min(Remaining, Buffered);
		New_Target_Last  : Natural  := Target_Last + Write_Length;
		New_Buffer_First : Positive := Buffer.First + Write_Length;
	begin
		Target(Target_Last + 1 .. New_Target_Last) := Buffer.Data(Buffer.First .. New_Buffer_First - 1);
		Target_Last := New_Target_Last;
		Buffer.First := New_Buffer_First;
	end Write_Buffered;

	procedure Set_Buffer(
		Buffer: in out Sequence_Buffer;
		Source: in String_Type
	) is
	begin
		Buffer.Data(1 .. Source'Length) := Source;
		Buffer.First := 1;
		Buffer.Last := Source'Length;
	end Set_Buffer;

	procedure Write(
		Buffer: in out Sequence_Buffer;
		Source: in String_Type;
		Target: in out String_Type;
		Target_Last: in out Natural
	) is
	begin
		Set_Buffer(Buffer, Source);
		Write_Buffered(Buffer, Target, Target_Last);
	end;


end Encodings.Utility.Generic_Sequence_Buffers;