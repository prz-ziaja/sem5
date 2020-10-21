-- menup.adb

with Ada.Text_IO, Opcje, Ada.Integer_Text_IO, Ada.Calendar, Ada.Calendar.Formatting;
use Ada.Text_IO, Opcje,  Ada.Integer_Text_IO, Ada.Calendar, Ada.Calendar.Formatting;

procedure MenuP is
  Zn: Character := ' '; 
  filed : File_Type;
  T : Time;
  T0 : constant Ada.Calendar.Time := Ada.Calendar.Time_Of(1970, 01, 01);
  D : Duration;
  procedure Pisz_Menu is
  begin
	New_Line;  
	Put_Line("Menu:");  
    Put_Line(" s - opcja s");
	Put_Line(" c - opcja c");
	Put_Line(" p - opcja p");
	Put_Line("ESC -Wyjscie");
	Put_Line("Wybierz (s,c,p, ESC-koniec):");
  end Pisz_Menu;
  
begin
Create(filed, Out_File, "dziennik.txt");
T := Clock;
D := T - T0;
Put_Line(filed, "Program started: " & D'Img );
  loop
  	  T := Clock;
	  D := T - T0;
          Put_Line(filed, "Menu: " & D'Img );
    Pisz_Menu;
	Get_Immediate(Zn);
	exit when Zn = ASCII.ESC;
	case Zn is
	  when 's' => 
	  T := Clock;
	  D := T - T0;
          Put_Line(filed, "S option: " & D'Img );
	  Opcja_S;
	  when 'c' => 
	  T := Clock;
	  D := T - T0;
          Put_Line(filed, "C option: " & D'Img );
	  Opcja_C;
	  when 'p' => 
	  T := Clock;
	  D := T - T0;
          Put_Line(filed, "P option: " & D'Img );
	  Opcja_P;
      when others =>
      	  T := Clock;
	  D := T - T0;
          Put_Line(filed, "Input error: " & D'Img );
       Put_Line("Blad!!");
	end case;
  end loop;
  T := Clock;
  D := T - T0;
  Put_Line(filed, "Program stoped: " & D'Img );
  Close(filed);
  Put_Line("Koniec");
end MenuP;
  	 
  
