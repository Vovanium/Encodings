package Encodings.Line_Endings.CR_LF.Generic_Coders is
	generic 
		type Character_Type is (<>); -- Character, Wide_Character, Wide_Wide_Character (or whatever)
		type String_Type is array(Positive range <>) of Character_Type;
		Carriage_Return: in Character_Type; -- CR in the corresponding type
		Line_Feed: in Character_Type; -- LF in the corresponding type
		type Coder_Base is abstract tagged private; -- Type to derive
	package Generic_Encoders is
		type Coder is new Coder_Base with private;
		procedure Convert(
			This: in out Coder; -- Coder state
			Source: in String_Type; -- String to be converted
			Read: out Natural; -- Last index of source string read (length if string is starting at 1)
			Destination: out String_Type; -- Converted string
			Written: out Natural -- Last Index of destination string written
		);
	private
		type Coder_State is (
			Initial,
			Have_CR,
			Need_LF
		);
		type Coder is new Coder_Base with record
			State: Coder_State := Initial;
		end record;
	end Generic_Encoders;
	
end Encodings.Line_Endings.CR_LF.Generic_Coders;
