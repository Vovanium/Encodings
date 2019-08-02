generic 
	type Character_Type is (<>); -- Character, Wide_Character, Wide_Wide_Character (or whatever)
	type String_Type is array(Positive range <>) of Character_Type;
	Carriage_Return: in Character_Type; -- CR in the corresponding type
	Line_Feed: in Character_Type; -- LF in the corresponding type
	type Coder_Base is abstract tagged private; -- Type to derive
package Encodings.Line_Endings.Generic_Strip_CR is
	type Coder is new Coder_Base with private;
	procedure Convert(
		This: in out Coder; -- Coder state
		Source: in String_Type; -- String to be converted
		Source_Last: out Natural; -- Last index of source string read (length if string is starting at 1)
		Target: out String_Type; -- Converted string
		Target_Last: out Natural -- Last Index of destination string written
	);
private
	type Coder is new Coder_Base with record
		Have_CR: Boolean := False;
	end record;
end Encodings.Line_Endings.Generic_Strip_CR;
