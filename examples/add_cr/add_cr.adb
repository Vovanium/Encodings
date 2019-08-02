-- An example of using low-level convertor API (fixed string procedures)
-- Program reads standard input, adds cr before lf, then writes to standard output
with Ada.Streams;
use  Ada.Streams;
use type Ada.Streams.Stream_Element_Offset;
with Ada.Text_IO;
use  Ada.Text_IO;
with Ada.Text_IO.Text_Streams;
use  Ada.Text_IO.Text_Streams;
with Ada.Unchecked_Conversion;
with Encodings.Line_Endings.Add_CR;
procedure Add_CR is
	-- String version of Stream.Read
	procedure Read_String(
		Stream: in out Root_Stream_Type'Class;
		Item: out String;
		Last: out Natural
	) is
		Character_Length: constant := Character'Stream_Size / Stream_Element'Size;
		Buffer_Length: constant Stream_Element_Offset := Item'Length * Character_Length;
		Buffer: Stream_Element_Array(1 .. Buffer_Length);
		Buffer_I, Buffer_Last: Stream_Element_Offset;
		Character_Count: Natural;
		function Conversion is new Ada.Unchecked_Conversion(
			Source => Stream_Element_Array,
			Target => Character
		);
	begin
		Stream.Read(Buffer, Buffer_Last);
		Character_Count := Integer(Buffer_Last) / Character_Length;
		Last := Character_Count + (Item'First - 1);
		Buffer_I := 1;
		for I in Item'First..Last loop
			Item(I) := Conversion(Buffer(Buffer_I .. Buffer_I + Character_Length - 1));
			Buffer_I := Buffer_I + Character_Length;
		end loop;
	end;

	Input_Stream: Stream_Access := Stream(Standard_Input);
	Output_Stream: Stream_Access := Stream(Standard_Output);
	Input_Buffer: String(1 .. 100);
	Output_Buffer: String(1 .. 100);
	Input_Last, Input_Read_Last: Natural;
	Output_Last: Natural;

	Coder: Encodings.Line_Endings.Add_CR.Coder;
begin
	while not End_Of_File(Standard_Input) loop
		Read_String(Input_Stream.all, Input_Buffer, Input_Read_Last);
		Input_Last := Input_Buffer'First - 1;
		while Input_Last < Input_Read_Last loop
			Coder.Convert(Input_Buffer(Input_Last + 1 .. Input_Read_Last), Input_Last, Output_Buffer, Output_Last);
			String'Write(Output_Stream, Output_Buffer(Output_Buffer'First .. Output_Last));
		end loop;
	end loop;
end Add_CR;