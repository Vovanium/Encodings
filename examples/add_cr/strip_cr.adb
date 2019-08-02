-- An example of using low-level convertor API (fixed string procedures)
-- Program reads standard input, adds cr before lf, then writes to standard output
with Ada.Streams;
use  Ada.Streams;
with Ada.Text_IO;
use  Ada.Text_IO;
with Ada.Text_IO.Text_Streams;
use  Ada.Text_IO.Text_Streams;
with Ada.Unchecked_Conversion;
with Encodings.Line_Endings.Strip_CR;
with Encodings.Utility;
use Encodings.Utility;
procedure Strip_CR is

	Input_Stream: Stream_Access := Stream(Standard_Input);
	Output_Stream: Stream_Access := Stream(Standard_Output);
	Input_Buffer: String(1 .. 100);
	Output_Buffer: String(1 .. 100);
	Input_Last, Input_Read_Last: Natural;
	Output_Last: Natural;

	Coder: Encodings.Line_Endings.Strip_CR.Coder;
begin
	while not End_Of_File(Standard_Input) loop
		Read_String(Input_Stream.all, Input_Buffer, Input_Read_Last);
		Input_Last := Input_Buffer'First - 1;
		while Input_Last < Input_Read_Last loop
			Coder.Convert(Input_Buffer(Input_Last + 1 .. Input_Read_Last), Input_Last, Output_Buffer, Output_Last);
			String'Write(Output_Stream, Output_Buffer(Output_Buffer'First .. Output_Last));
		end loop;
	end loop;
end Strip_CR;
