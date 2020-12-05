with Ada.Text_IO, Ada.Numerics.Discrete_Random, Ada.Numerics.Elementary_Functions;
use Ada.Text_IO, Ada.Numerics.Elementary_Functions;

procedure Zad1 is

task Server is 
  entry Start;
	entry Koniec;
  entry Comp(X, Y:Integer);
end Server;
	
task Client is
  entry Start;
end Client;

task body Client is
    package Rand is new Ada.Numerics.Discrete_Random(Integer);
    use Rand;
    Gen: Generator;
    X: Integer := 0;
    Y: Integer := 0;
    N: Integer := 5;
begin
    accept Start;	
    for K in 1..N loop
        reset(gen);
        X := (Random(Gen) mod 10);
        Y := (Random(Gen) mod 10);
        Put_Line("A:  (" & X'Img & " ," & Y'Img &" )");
        Server.Comp(X, Y);
    end loop;
    Server.Koniec;	
end Client;

task body Server is
    Xa: Integer := 0;
    Ya: Integer := 0;	
    Xb: Integer := 0;
    Yb: Integer :=0;	
    D1: Float := 0.0;
    D2: Float := 0.0;
begin
    accept Start;
    loop
    select 
		    accept Comp(X, Y: in Integer) do
			    Xb := X;
			    Yb := Y;
        	    D1 := Sqrt(Float( Xb**(2) + Yb**(2)));
			    D2 := Sqrt(Float((abs(Xa - Xb))**(2) + (abs(Ya - Yb))**(2)));
		    end Comp;
      	    Put_Line("B:  Distance ([0, 0], ["&Xb'Img&","&Yb'Img &"]) =" & D1'Img);
      	    if not((Xa = 0)and(Ya = 0)) then
		        Put_Line("B:  Distance (["&Xa'Img & ","&Ya'Img &"],["&Xb'Img & " ,"&Yb'Img &"]) =" & D2'Img);
		    end if;
		    Xa := Xb;
		    Ya := Yb;
    or 
            accept Koniec;
	            exit;
        end select;
    end loop;
end Server;

begin
    Server.Start; 
    Client.Start;   
end Zad1;
	  	
