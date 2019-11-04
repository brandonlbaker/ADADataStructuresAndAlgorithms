with Ada.Text_IO,Ada.Strings.Unbounded,Ada.Strings.Unbounded.Text_IO,BinaryTree;
use Ada.Text_IO,Ada.Strings.Unbounded,Ada.Strings.Unbounded.Text_IO,BinaryTree;

procedure driver IS
   package IIO IS NEW Ada.Text_IO.integer_IO(integer);
   use IIO;

   root      : binarySearchTreePoint;
   tempPoint : BinarySearchTreePoint;
   selection : integer               := 0;


   procedure get10 (
         S : in out String10) IS
      buf : Unbounded_String;
   begin
      buf := Get_Line;

      FOR I in String10'range loop
         if I <= length(buf) then
            S(I) := element(buf,I);
         else
            S(I) := ' ';
         end if;
      end loop;
   end get10;

   Name  : String10 := (others => ' ');
   Phone : String10 := (others => ' ');
   NewName  : String10 := (others => ' ');
begin
   init(root);
   init(tempPoint);
   Put_Line("1. Insert");
   Put_Line("2. Recursive Find");
   Put_Line("3. Iterative Find");
   Put_Line("4. Inorder From Node");
   Put_Line("5. Exit");
   loop
      Put("Enter Command : ");
      get(selection); Skip_line;
      case selection IS
         when 1 =>
            Put("Enter Name: ");
            get10(name);
            Put("Enter Phone Number: ");
            get10(phone);
            insertBinarySearchTree(root,name,phone);
            Put_line("Successfully inserted");
            New_Line;
         when 2 =>
            Put("Enter Name: ");
            get10(name);
            FindCustomerRecursive(root,name,temppoint);
            if CustomerName(tempPoint) = name  then
               name := customerName(temppoint);
               Phone := customerPhone(tempPoint);
               put("Name: "); Put_line(String(Name));
               Put("Phone: "); Put_line(String(Phone));
            else
               Put_Line("Name not found");
            end if;
         when 3 =>
            Put("Enter Name: ");
            get10(name);
            FindCustomerIterative(root,name,temppoint);
            if CustomerName(tempPoint) = name then
               name := customerName(temppoint);
               Phone := customerPhone(temppoint);
               put("Name: "); Put_line(String(Name));
               Put("Phone: "); Put_line(String(Phone));
            else
               Put_Line("Name not found");
            end if;

         when 4 =>
            Put("Enter Name: ");
            get10(name);
            if String(name) = "root      " then
               name := customerName(root);
            end if;
            FindCustomerIterative(root,name,temppoint);
            if CustomerName(tempPoint) = name then
            tempPoint := inOrderSuccessor(tempPoint);   
               loop
               NewName := customerName(temppoint);
               Phone := customerPhone(temppoint);
               put("Name: "); Put_line(String(NewName));
               Put("Phone: "); Put_line(String(Phone));
               if NewName /= name then
               tempPoint := inOrderSuccessor(tempPoint);
               else
               exit;
               end if;
               end loop;
            else
               Put_Line("Name not found");
            end if;
         when 5 =>
            exit;

         when others =>
            Put_Line("Incorrect Command.");

      end case;
   end loop;
end driver;