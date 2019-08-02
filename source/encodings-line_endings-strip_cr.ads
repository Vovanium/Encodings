with Ada.Characters.Latin_1;
use  Ada.Characters.Latin_1;
with Encodings.Line_Endings.Generic_Strip_CR;

package Encodings.Line_Endings.Strip_CR is new Generic_Strip_CR(
	Character_Type => Character,
	String_Type => String,
	Carriage_Return => CR,
	Line_Feed => LF,
	Coder_Base => Coder_Base
);
