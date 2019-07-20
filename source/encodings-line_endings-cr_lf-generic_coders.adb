package body Encodings.Line_Endings.CR_LF.Generic_Coders is
	package body Generic_Encoders is
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
			if This.State = Need_LF then
				if Target_Last >= Target'Last then -- Wonder of anyone would supply zero-size string but precaution is must
					return;
				end if;
				Target_Last := Target_Last + 1;
				Target(Target_Last) := Line_Feed;
				This.State := Initial;
			end if;
			while Source_Last < Source'Last and Target_Last < Target'Last loop
				Source_Last := Source_Last + 1;
				C := Source(Source_Last);
				if C = Carriage_Return then
					This.State := Have_CR;
				elsif C = Line_Feed then
					if This.State /= Have_CR then
						Target_Last := Target_Last + 1;
						Target(Target_Last) := Carriage_Return;
						if(Target_Last >= Target'Last) then -- Buffer ends while outputtting CR-LF
							This.State := Need_LF;
							return;
						end if;
						This.State := Initial;
					end if;
				end if;
				Target_Last := Target_Last + 1;
				Target(Target_Last) := C;
			end loop;
		end Convert;
	end Generic_Encoders;
end Encodings.Line_Endings.CR_LF.Generic_Coders;