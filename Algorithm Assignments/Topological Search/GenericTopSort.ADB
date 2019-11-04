with Ada.Integer_Text_IO, Ada.Text_IO, Ada.Unchecked_Conversion;
use Ada.Integer_Text_IO, Ada.Text_IO;

package body GenericTopSort is
type Node;
type NodePointer is access Node;
type Node is tagged record
	Succ:	SortElement;
	Next:	NodePointer;
end record;

type JobElement is record
	Count:  Integer := 0;
	Top:	NodePointer;
end record;
subtype action is integer range 1 .. num;
SortStructure:  Array(0..num) of JobElement;

function CreateNodePoint is new Ada.Unchecked_Conversion(integer, NodePointer);

procedure TopologicalSort is

      actions : integer;
      relations : integer;
      front : integer;
      back : integer;
      pos : integer; -- change to pos
      accessnode : NodePointer;
      prec : SortElement;
      succ : SortElement;
      count : integer;

begin
      for pos in 1 .. num loop
         SortStructure(pos).Count := 0;
         SortStructure(pos).top := null;
      end loop;

      actions := num;

      put("Number of relations? ");
      get(relations); new_line;
      count := 1;
      loop
         put("Precident for Relation # "); put(count, 0); put(" : ");
         get(prec); new_line;
         put("Successor for Relation # "); put(count, 0); put(" : ");
         get(succ); new_line;
         accessnode := new Node;
         SortStructure(SortElement'Pos(succ)).Count := SortStructure(SortElement'Pos(succ)).Count + 1;
         accessnode.Succ := succ;
         accessnode.Next := SortStructure(SortElement'Pos(prec)).top;
         SortStructure(SortElement'Pos(prec)).top := accessnode;
         count := count + 1;
         if count = relations + 1 then
            exit;
         end if;
      end loop;

      back := 0;
      SortStructure(0).Count := 0;
      for pos in 1 .. num loop
         if SortStructure(pos).Count = 0 then
            SortStructure(back).Count := pos;
            back := pos;
         end if;
      end loop;

      front := SortStructure(0).Count;

      put("Listing sorted order: ");
      while front /= 0 loop
         put(SortElement'Val(front)); put(" ");
         actions := actions -1;
         accessnode := SortStructure(front).top;
         SortStructure(front).top := CreateNodePoint(0);

         while accessnode /= CreateNodePoint(0) loop
            SortStructure(SortElement'Pos(accessnode.succ)).Count := SortStructure(SortElement'Pos(accessnode.succ)).Count - 1;
            if SortStructure(SortElement'Pos(accessnode.succ)).Count = 0 then
               SortStructure(back).Count := SortElement'Pos(accessnode.succ);
               back := SortElement'Pos(accessnode.succ);
            end if;
            accessnode := accessnode.next;
         end loop;
         front := SortStructure(front).Count;
      end loop;

      if actions /= 0 then
      new_line; put_line("Sort failed.");
         for pos in 1 .. num loop
            SortStructure(pos).Count := 0;
         end loop;
      else
      return;
      end if;

      for pos in 1 .. num loop
         accessnode := SortStructure(pos).Top;
         SortStructure(pos).top := CreateNodePoint(0);

         while accessnode /= CreateNodePoint(0) and then SortStructure(SortElement'Pos(accessnode.succ)).Count = 0 loop
            SortStructure(SortElement'Pos(accessnode.succ)).Count := pos;
            if accessnode /= CreateNodePoint(0) then
               accessnode := accessnode.next;
            end if;
         end loop;
      end loop;

      pos := 1;
      while SortStructure(pos).Count = 0 loop
         pos := pos+1;
      end loop;

      loop
         SortStructure(pos).top := CreateNodePoint(1);
         pos := SortStructure(pos).Count;
         exit when SortStructure(pos).top /= CreateNodePoint(0);
      end loop;

      put_line("Loop causing error:");
      while SortStructure(pos).top /= CreateNodePoint(0) loop
         put(SortElement'Val(pos)); put(" ");
         SortStructure(pos).top := CreateNodePoint(0);
         pos := SortStructure(pos).Count;
      end loop;
      put(SortElement'Val(pos));
      new_line;

      end TopologicalSort;
   end GenericTopSort;