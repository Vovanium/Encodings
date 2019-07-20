with Ada.Characters.Latin_1;
use  Ada.Characters.Latin_1;
with Encodings.Line_Endings.CR_LF.Generic_Coders;
use  Encodings.Line_Endings.CR_LF.Generic_Coders;
package Encodings.Line_Endings.CR_LF.Coders is
	package Encoders is new Generic_Encoders(
		Character_Type => Character,
		String_Type => String,
		Carriage_Return => CR,
		Line_Feed => LF,
		Coder_Base => Coder_Base
	);
end Encodings.Line_Endings.CR_LF.Coders;