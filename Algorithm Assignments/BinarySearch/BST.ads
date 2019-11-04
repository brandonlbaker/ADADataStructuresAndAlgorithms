package binarytree is
   type String10 is new String
         (1 .. 10);

   type BinarySearchTreePoint is private;
   procedure init( Root : in out BinarySearchTreePoint);
   procedure insertBinarySearchTree (
         Root      : in out BinarySearchTreePoint;
         CustName  : in     String10;
         CustPhone : in     String10);
   procedure FindCustomerIterative (
         Root          : in     BinarySearchTreePoint;
         CustomerName  : in     String10;
         CustomerPoint :    out BinarySearchTreePoint);
   procedure FindCustomerRecursive (
         Root          : in     BinarySearchTreePoint;
         CustomerName  : in     String10;
         CustomerPoint :    out BinarySearchTreePoint);
   function inOrderSuccessor (
         TreePoint : in     BinarySearchTreePoint)
     return BinarySearchTreePoint;
   function CustomerName (
         TreePoint : in     BinarySearchTreePoint)
     return String10;
   function CustomerPhone (
         TreePoint : in     BinarySearchTreePoint)
     return String10;

private
   type Customer is
      record
         Name        : String10;
         PhoneNumber : String10;
      end record;

   type Node;
   type BinarySearchTreePoint is access Node;

   type Node is
      record
         Llink,
         Rlink : BinarySearchTreePoint;
         Ltag,
         Rtag  : Boolean;
         info  : Customer;
      end record;

end binarytree;