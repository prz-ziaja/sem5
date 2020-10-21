with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

package body Arr is
    procedure print (a : f_array) is
    begin
        for i in a'Range loop
            Put_Line ("Array(" & i'Img & ") = " & a (i)'Img);
        end loop;
    end print;

    procedure fill (a : out f_array) is
        Generator : Ada.Numerics.Float_Random.Generator;
    begin
        for i in a'Range loop
            a (i) := Random (Generator);
        end loop;
    end fill;

    function is_sorted (A : f_array) return Boolean is
    begin
        return
           (for all Idx in A'First .. (A'Last - 1) => A (Idx + 1) >= A (Idx));
    end is_sorted;

    procedure sort (a : in out f_array) is
	x : Float;
    begin
    	While_Loop :
		while not Arr.is_sorted(a) loop
			for i in a'First .. (a'Last - 1) loop
				if a (i) > a(i+1) then
					x := a(i);
					a(i) := a(i+1);
					a(i+1) := x;
				end if;
			end loop;
		end loop While_Loop;
    end sort;

end Arr;
