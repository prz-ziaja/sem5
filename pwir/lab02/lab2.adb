with Ada.Text_IO,Ada.Float_Text_IO, Arr, Ada.Calendar;
use Ada.Text_IO,Ada.Float_Text_IO, Arr, Ada.Calendar;

procedure Lab2 is
  T1, T2 : Time;
  D : Duration;
  Ve : Arr.f_array := (1..8 => 1.0, 9..10 =>2.0);
begin
  T1 := Clock;
  Arr.print(Ve);
  Arr.fill(Ve);
  Arr.print(Ve);
  Put_Line ("Is sorted? The answer is: " & Arr.is_sorted(Ve)'Img);  
  Arr.sort(Ve);
  Arr.print(Ve);
  Put_Line ("Is sorted? The answer is: " & Arr.is_sorted(Ve)'Img);   
  T2 := Clock;
  D := T2 - T1;
  Put_Line("Executed in: " & D'Img & " sec");
end Lab2;
