-- lab6_2.adb

with Ada.Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO;

procedure zad2 is
	
task P1 is
	entry Start;
end P1;  

task P2 is
	entry Start;
end P2;

type Color is (Czerwony, Zielony, Niebieski);

function GenCol(I:Integer) return Color is
	--type Kolory is (Czerwony, Zielony, Niebieski);
  package Los_Color is new Ada.Numerics.Discrete_Random(Color);
  use Los_Color;

  X : Color;
  Gen: Generator; -- z pakietu Los_Kolor
begin
	Reset(Gen);
	X := Random(Gen);
	return X;
end GenCol;

function GenNUM(I:Integer) return Integer is
      subtype Num_Type is Integer range 0 .. 49;
      package Random_Num is new Ada.Numerics.Discrete_Random(Num_Type);
			use Random_Num;
			X : Integer := 0;
  		Gen: Generator;
begin
 Reset(Gen);
 X := Random(Gen);
 return X;
end GenNUM;

type Day is (poniedzialek, wtorek, sroda, czwartek, piatek, sobota, niedziela);

function GenDay(I:Integer) return Day is
  package Los_Day is new Ada.Numerics.Discrete_Random(Day);
  use Los_Day;
 
  X : Day;
  Gen: Generator;
begin
  Reset(Gen);
  X := Random(Gen);
   return X;
end GenDay;

function GenNu(I:Integer) return Float is
     subtype Num_Type is Integer range 0 .. 5;
     package Random_Num is new Ada.Numerics.Discrete_Random(Num_Type);
     use Random_Num;
     X : Float := 0.0;
     Gen: Generator;
begin
   Reset(Gen);
   X := Float(Random(Gen));
   return X;
end GenNu;


task body P1 is	
begin
  accept Start;
	  Put_Line("A:  " & GenNu(1)'Img);
end P1;

task body P2 is	
begin
  accept Start; 
		Put("B:  " & GenNu(1)'Img &" "& GenCol(1)'Img &" "& GenDay(1)'Img);
		for I in 1..6 loop
			Put(" " & GenNUM(1)'Img);
		end loop;
end P2;

begin
  P1.Start;
  P2.Start; 
end zad2;
