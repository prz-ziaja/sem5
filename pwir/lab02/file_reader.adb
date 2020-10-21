-- wyjatki1.adb

with Ada.Text_IO;
use Ada.Text_IO;

procedure file_reader is
  filed : File_Type;
  name: String(1..100) := (others => ' ');	
  len : Integer := 0;
  value : Character;
begin
  loop
	Put_Line("Input file name: ");
	Get_Line(name, len);
    begin  	
	  Open(filed, In_File, name(1..len));
	  exit;
	exception
	  when Name_Error => Put_Line("Problem with <" & name(1..len) & "> !");
	end;  
  end loop;
  
  Put_Line("Opening file: " & name(1..len));
  
  while not End_OF_File (filed) loop
	Get (filed, value);
	Put (value);
  end loop;
  New_Line;
  Put_Line("Closing file");
  Close(filed);
end file_reader;
