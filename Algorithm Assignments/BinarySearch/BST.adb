package body binarytree is
   Count : integer := 0;
   
   procedure init( Root : in out BinarySearchTreePoint) is
   begin
    Root := null;
   end;

   procedure insertBinarySearchTree (
         Root      : in out BinarySearchTreePoint;
         custName  : in     String10;
         custPhone : in     String10) is
      p : binarySearchTreePoint := root;
      t : binarySearchTreePoint;
   begin
      count:=count+1;
      t:=new node;
      t.info.name:=custName;
      t.info.phoneNumber:=custPhone;
      t.rLink:=t;
      t.lLink:=t;
      t.rTag:=True;

      if root = null then
         root:=t;
      else
         loop
         if p.info.name > custName then
               if not p.lTag then
               t.Llink := P.LLink; t.LTag := P.LTag;
	         P.Llink := t;  P.LTag := true;  t.RLink := P;  t.RTag := false;
               exit;
               else
               p:=p.llink;
               end if;
         elsif p.info.name <= custName then
               if  not p.rTag OR p.rLink = Root then
               t.Rlink := P.RLink; t.RTag := P.RTag;
	         P.Rlink := t;  P.RTag := true;  t.LLink := P;  t.LTag := false;
               exit;
               else
               p:=p.rlink;
               end if;
         end if;
         end loop;
      end if;
   end insertBinarySearchTree;



   procedure FindCustomerIterative (
         Root          : in     BinarySearchTreePoint;
         CustomerName  : in     String10;
         CustomerPoint :    out BinarySearchTreePoint) is
      p    : binarySearchTreePoint := root;
      temp : integer               := count;
   begin
      customerpoint:=root;
      loop
         if temp = 0 then
            p:=root;
            exit;
         elsif p.info.name = customerName then
            customerPoint:= p;
            exit;
         elsif p.info.name > customerName then
            p:=p.lLink;
         elsif p.info.name < customerName then
            p:=p.rLink;
         end if;

         temp:=temp-1;

      end loop;
   end FindCustomerIterative;

   procedure FindCustomerRecursive (
         Root          : in     BinarySearchTreePoint;
         CustomerName  : in     String10;
         CustomerPoint :    out BinarySearchTreePoint) is
      p : binarysearchtreepoint;
   begin
      if root /= null then
         p:=root;

         if p.info.name > customerName then
            if p.lTag=true then
               findCustomerRecursive(p.lLink, customerName,CustomerPoint);
            end if;
         elsif p.info.name < customerName then
            if p.rTag=true then
               findCustomerRecursive(p.rLink, customerName,CustomerPoint);
            end if;
         elsif p.info.name = customerName then
            CustomerPoint := p;
            return;
         end if;
      else
         CustomerPoint := Root;
         return;
      end if;

   end FindCustomerRecursive;

   function inOrderSuccessor (
         TreePoint : in     BinarySearchTreePoint)
     return BinarySearchTreePoint is
      p : binarySearchTreePoint;
      q : binarySearchTreePoint;
   begin
      p:=treePoint;
      q := p.rLink;
      if p.rTag = false then
         p:=q;
      else
         WHILE q.lTag = true loop
            q := q.lLink;
         end loop;
         p:=q;
      end if;
      return p;
   end inOrderSuccessor;

   function CustomerName (
         TreePoint : in     BinarySearchTreePoint)
     return String10 is
   begin
      return treePoint.info.name;
   end CustomerName;

   function CustomerPhone (
         TreePoint : in     BinarySearchTreePoint)
     return String10 is
   begin
      return treePoint.info.phoneNumber;
   end CustomerPhone;

end binarytree;