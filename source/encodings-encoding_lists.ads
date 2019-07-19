with Ada.Strings.Bounded;
package Encodings.Encoding_Lists is
	Encoding_Name_Length_Maximum: constant := 16;
	package Encoding_Name_Strings is new Ada.Strings.Bounded.Generic_Bounded_Length(
		Max => Encoding_Name_Length_Maximum
	);
end Encodings.Encoding_Lists;
