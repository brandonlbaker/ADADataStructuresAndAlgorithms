with generictopSort, Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure driver is

   type nameType is (ZERO, Betty, Bob, Joe, Mary, Sam, Tom);
   package NameTypeIO is new Ada.Text_IO.Enumeration_IO(nameType); use NameTypeIO;

   procedure NameGet(x: out nameType) is
   begin
      NameTypeIO.Get(x);
   end NameGet;

   procedure NamePut(x : nameType) is
   begin
      NameTypeIO.Put(x);
   end NamePut;

   procedure intGet(x: out Integer) is
   begin
      Ada.Integer_Text_IO.Get(x, 0);
   end intGet;

   procedure intPut(x : in Integer) is
   begin
      Ada.Integer_Text_IO.Put(x, 0);
   end intPut;
   numItems : integer;
   choice : integer;

begin
   loop
      numItems := -1;
      choice := -1;
      while choice /= 0 AND choice /= 1 AND choice /= 2 loop
         new_line;
         put_line("Enter 1 for Enumeration sort, 2 for Integer sort, and 0 for quit.");
         get(choice);
      end loop;

      if choice = 1 then
         declare
            package namesort is new GenericTopSort(nameType, 6, NameGet, NamePut);
         begin
            namesort.TopologicalSort;
         end;

      elsif choice = 2 then

         while numItems < 0 loop
            put("Number of items? ");
            get(numItems);
         end loop;

         declare
           package intSort is new generictopsort(integer, numItems, intGet, intPut);
         begin
            intSort.TopologicalSort;
         end;
      elsif choice = 0 then
         Exit;
      end if;
   end loop;
end driver;