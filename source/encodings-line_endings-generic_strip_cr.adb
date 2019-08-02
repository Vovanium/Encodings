with Ada.Assertions;
use  Ada.Assertions;
package body Encodings.Line_Endings.Generic_Strip_CR is
	procedure Convert(
		This: in out Coder;
		Source: in String_Type;
		Source_Last: out Natural;
		Target: out String_Type;
		Target_Last: out Natural
	) is
		C: Character_Type;
	begin
		Source_Last := Source'First - 1;
		Target_Last := Target'First - 1;
		while Source_Last < Source'Last loop
			C := Source(Source_Last + 1);
			if This.Have_CR and C /= Line_Feed then -- emit CR not the part of CRLF sequence
				if Target_Last < Target'Last then
					Target_Last := Target_Last + 1;
					Target(Target_Last) := Carriage_Return;
				else
					return;
				end if;
				This.Have_CR := False;
			end if;
			if C = Carriage_Return then
				Assert(This.Have_CR = False, "Have should be cleared before or if condition shoudn't be true");
				This.Have_CR := True;
			else
				This.Have_CR := False;
				if Target_Last < Target'Last then
					Target_Last := Target_Last + 1;
					Target(Target_Last) := C;
				else
					return;
				end if;
			end if;
			Source_Last := Source_Last + 1;
		end loop;
	end Convert;
end Encodings.Line_Endings.Generic_Strip_CR;
