package body Encodings.Line_Endings.Add_CR is
	package body Generic_Coders is
		procedure Convert(
			This: in out Coder;
			Source: in String_Type;
			Read: out Natural;
			Destination: out String_Type;
			Written: out Natural
		) is
			C: Character_Type;
		begin
			Read := Source'First - 1;
			Written := Destination'First - 1;
			if This.State = Need_LF then
				if Written >= Destination'Last then -- Wonder of anyone would supply zero-size string but precaution is must
					return;
				end if;
				Written := Written + 1;
				Destination(Written) := Line_Feed;
				This.State := Initial;
			end if;
			while Read < Source'Last and Written < Destination'Last loop
				Read := Read + 1;
				C := Source(Read);
				if C = Carriage_Return then
					This.State := Have_CR;
				elsif C = Line_Feed then
					if This.State /= Have_CR then
						Written := Written + 1;
						Destination(Written) := Carriage_Return;
						if(Written >= Destination'Last) then -- Buffer ends while outputtting CR-LF
							This.State := Need_LF;
							return;
						end if;
						This.State := Initial;
					end if;
				end if;
				Written := Written + 1;
				Destination(Written) := C;
			end loop;
		end Convert;
	end Generic_Coders;
end Encodings.Line_Endings.Add_CR;