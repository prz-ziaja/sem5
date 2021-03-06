with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.discrete_Random ,Ada.Strings.Fixed, Ada.Containers.Vectors;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Strings.Fixed, Ada.Containers;
procedure Tree is

type Element is
  record 
    Data : Integer := 0;
    Up : access Element := Null;
    Right : access Element := Null;
    Left : access Element := Null;
  end record; 

type Elem_Ptr is access all Element;

Function Depth(Tree: in Elem_Ptr; Deep: in Integer) return Integer is
begin
    If Tree = Null then
        return Deep;
    else
        return Integer'Max(
            Depth(Tree.Left, Deep+1),
            Depth(Tree.Right, Deep+1)
        );
    end if;
end Depth;


Procedure Print(Tree: in Elem_Ptr) is
begin
    if Tree /= Null then
        Put("[");
        if Tree.Left /= Null then
            Print(Tree.Left);
            Put("<-");
        end if;
        Put(Tree.Data, Width => 0);
        if Tree.Right /= Null then
            Put("->");
            Print(Tree.Right);
        end if;
        Put("]");
    end if;
end Print;

Procedure Insert(Tree: in out Elem_Ptr; N: Integer) is
    Elem: Elem_Ptr := new Element;
    P: Elem_Ptr := Null;
    L: Elem_Ptr := Tree;
    IsLeft: Boolean;
begin
    Elem.Data := N;
    If Tree = Null then
        Elem.Up := P;
        Tree := Elem;
    else
        while L /= Null loop
            P := L;
            if N < L.Data then
                L := L.Left;
                IsLeft := True;
            else
                L := L.Right;
                IsLeft := False;
            end if;   
        end loop;

        if IsLeft then
            P.Left := Elem;
        else
            P.Right := Elem;
        end if;

        Elem.Up := P;
    end if;
end Insert;

Function Search(Tree: in out Elem_Ptr; N: in Integer) return Boolean is
begin
    if Tree /= Null and then Tree.Data = N then
        return True;
    elsif  Tree /= Null and then Tree.Data < N then
        return Search(Tree.Right,N);
    elsif  Tree /= Null and then Tree.Data > N then
        return Search(Tree.Left,N);
    else 
        return False;
    end if;
end Search;

Function Min(Tree: in out Elem_Ptr) return Elem_Ptr is
    T: Elem_Ptr := Tree;
begin
    while T.Left /= Null loop
        T := T.Left;
    end loop;
    return T;
end Min;

Function Max(Tree: in out Elem_Ptr) return Elem_Ptr is
    T: Elem_Ptr := Tree;
begin
    while T.Right /= Null loop
        T := T.Right;
    end loop;
    return T;
end Max;

function Serialize(Tree: in out Elem_Ptr) return String is
begin
    if Tree /= Null then
        return "{" 
        & """data"":""" & Ada.Strings.Fixed.Trim(Tree.Data'Image, Ada.Strings.Left) 
        & """,""left"":" & Serialize(Tree.Left)
        & ",""right"":" & Serialize(Tree.Right) 
        & "}";
    else
        return "null";
    end if;
end Serialize;

procedure Save(Tree: in Elem_Ptr) is
    Utfil        : File_Type;
    T: Elem_Ptr := Tree;
begin
    Create(Utfil, Out_File, "tree.json");
    Put_Line(Utfil, Serialize(T));
    Close(Utfil);
end Save;

Function Length(Tree: in Elem_Ptr) return Integer is
begin
    if Tree /= Null then
        return 1 + Length(Tree.Left) + Length(Tree.Right);
    else
        return 0;
    end if;
end Length;

package Float_Container is new Vectors(Natural,Integer);    -- changed
use Float_Container;
function GetNodes(Tree: in Elem_Ptr) return Vector is
    The_Stack: Vector;
begin
    if Tree /= Null then
        Append(The_Stack, GetNodes(Tree.Left));
        Append(The_Stack, Tree.Data);
        Append(The_Stack, GetNodes(Tree.Right));
    end if;
   return The_Stack;
end GetNodes;

procedure Balance_Step(Tree: in out Elem_Ptr; Nodes: in out Vector; First: in Integer; Last: in Integer) is
Elem: Elem_Ptr := new Element;
Center_index: Integer;
begin
    Tree := Elem;
    Center_index:= Integer((Last+First+1)/2);

    Elem.Data := Nodes(Center_index);

    if (Center_index-1 >= First) then
        Balance_Step(Elem.Left, Nodes, First, Center_index-1);
    end if;
    if (Last >= Center_index+1) then
        Balance_Step(Elem.Right, Nodes, Center_index+1, Last);
    end if;
end Balance_Step;

procedure Balance(Tree: in out Elem_Ptr) is
    The_Stack: Vector := GetNodes(Tree);
begin
    Balance_Step(Tree,The_Stack,0,Integer(Length(The_Stack)-1));
end Balance;

Tree : Elem_Ptr := Null;
    
begin
    Insert(Tree, 9);
    Insert(Tree, 8);
    Insert(Tree, 7);
    Insert(Tree, 17);
    Insert(Tree, 18);
    Insert(Tree, 19);
    Insert(Tree, 20);



    Print(Tree);
    Put_Line("");
    Put_Line("After");
    Balance(Tree);
    Print(Tree);
    Save(Tree);
end Tree;
