generic
   numStacks : integer;
   L0 : integer;
   max : integer;
   SSmin : integer;
   SSmax : integer;
   type item is private;
   with procedure putItem(f: in item);

package multistack is

   procedure push(x: in item; stackNum: in integer; overflow: in out boolean);
   procedure pop(x: out item; stackNum: in integer; underflow: in out boolean);
   procedure reallocate(x: in item; stackNum: in integer; overflow: in out boolean);
   procedure moveStack;
   procedure printContents(printOT : in Boolean);
   function floor(x: in float) return integer;
end;