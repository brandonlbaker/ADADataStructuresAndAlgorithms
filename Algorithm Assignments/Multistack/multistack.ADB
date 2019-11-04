with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

package body multistack is

   s : array(SSmin .. SSmax) of item;
   base : array(1 .. (numstacks + 1)) of integer;
   top : array(1 .. numstacks) of integer;
   oldTop : array(1 .. (numStacks + 1)) of Integer;   --stores the oldTop, growth, and newBase to conserve space
   availSpace, totalInc, initialStackSize, J, Zeta : integer;
   growthAllocate, Alpha, Beta, Tau, Sigma : float;
   equalAllocate : float := 0.08;
   minSpace : float := float(max-L0) * 0.05;

   procedure push(x: in item; stackNum: in integer; overflow: in out boolean) is
   begin
      top(stackNum) := top(stackNum) + 1;
      if top(stackNum) > base(stackNum + 1) then
         put_line("Reallocating...");
         printContents(true);
         reallocate(x, stackNum, overflow);
         if overflow then
            return;
         else printContents(false);
         end if;
      else
         s(top(stackNum)) := x;
      end if;
   end push;
   procedure pop(x: out item; stackNum: in integer; underflow: in out boolean) is
   begin
      if top(stackNum) = base(stackNum) then
         underflow := true;
         return;
      else
         x := s(top(stackNum));
         top(stackNum) := top(stackNum) - 1;
      end if;
   end pop;
   procedure reallocate(x: in item; stackNum: in integer; overflow: in out boolean) is
   begin
      new_line; putItem(x); put(" caused the overflow"); new_line; new_line;
      AvailSpace := max - L0;
      TotalInc := 0;
      J := numStacks;
      while j > 0 loop
         availSpace := availSpace - (Top(j) - Base(J));
         if top(j) > oldTop(j) then
            oldTop(j+1) := top(j) - oldTop(j);
            totalInc := totalInc + oldTop(j+1);
         else
            oldTop(j+1) := 0;
         end if;

         J := J - 1;
      end loop;
      if float(AvailSpace) < (minSpace - 1.0) then
         put_line("Insufficient memory for repacking.");
         top(stackNum) := top(stackNum) - 1;
         overflow := true;
         return;
      end if;
      GrowthAllocate := 1.0 - EqualAllocate;
      Alpha := EqualAllocate * float(AvailSpace) / float(numStacks);
      Beta := GrowthAllocate * float(AvailSpace) / float(totalInc);
      oldTop(1) := Base(1);
      Sigma := 0.0;
      For J in integer range 2 .. numStacks loop
         Tau := Sigma + Alpha + float(oldTop(J)) * Beta;
         oldTop(j) := oldTop(j-1) + (top(j-1) - base(j-1) + floor(Tau) - floor(Sigma));
         Sigma := Tau;
      end Loop;
      top(stackNum) := top(stackNum) - 1;
      moveStack;
      top(stackNum) := top(stackNum) + 1;
      s(top(StackNum)) := x;
      for J in integer range 1..numStacks loop
         oldTop(j) := top(j);
      end loop;
   end reallocate;
   procedure moveStack is
   begin
      for J in integer range 2 .. numStacks loop
         if oldTop(j) < base(j) then
            zeta := base(j) - oldTop(j);
            for L in integer range base(j)+1 .. top(j) loop
               s(L - Zeta) := s(L);
            end loop;
            base(j) := oldTop(j);
            top(j) := top(j) - Zeta;
         end if;
      end loop;
      for J in reverse 2 .. numStacks loop
         if oldTop(j) > base(j) then
            zeta := oldTop(j) - base(j);
            for L in reverse (base(j) + 1) .. Top(j) loop
               s(L + zeta) := s(L);
            end loop;
            base(j) := oldTop(j);
            top(j) := top(j) + zeta;
         end if;
      end loop;
   end moveStack;
   procedure printContents(printOT : boolean) is
   begin
      if printOT = true then
         put("--Before repacking--");
      else
         put("--After repacking--");
      end if;
      new_line;
      for j in 1 .. numStacks loop
         put("Base["); put(j, 0); put("]   = "); put(base(j), 0); new_line;
         put("Top["); put(j, 0); put("]    = "); put(top(j), 0); new_line;
         if printOT = true then
            put("OldTop["); put(j, 0); put("] = "); put(oldTop(j), 0); new_line;
         end if;
      end loop;
      put("Base["); put(numStacks+1, 0); put("]   = "); put(base(numStacks+1), 0); new_line;
         for j in 1..numStacks loop
            put("Stack "); put(j, 0); new_line;
               for count in base(j)+1..top(j) loop
                  put(count, 2); put(": "); putItem(s(count)); new_line;
               end loop;
         end loop;
   end printContents;
   function floor(x : float) return integer is
      ret : integer;
   begin
      ret := integer(x);
      if float(ret) <= x then
         return ret;
      else
         return ret - 1;
      end if;
   end floor;
begin
   initialStackSize := (max - L0) / numStacks;
   for i in integer range 1 .. numStacks loop
      base(i) := floor((float(i)-1.0) / float(numStacks) * float(max - L0)) + L0;
      top(i) := base(i);
      oldTop(i) := top(i);
   end loop;
   base(numStacks + 1) := max;
end multistack;