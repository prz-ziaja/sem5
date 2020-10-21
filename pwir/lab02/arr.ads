package Arr is

type f_array is array (Integer range <>) of Float;

procedure print(A: f_array);
procedure fill(A: out f_array);
function is_sorted(A: f_array) return Boolean;
procedure sort(A: in out f_array);

end Arr;
