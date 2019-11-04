with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Strings.Unbounded, Ada.Strings.Unbounded.Text_IO, multistack, date;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Strings.Unbounded, Ada.Strings.Unbounded.Text_IO,
    Ada.Strings, date;

procedure driver is

   package SU renames Ada.Strings.Unbounded;

   data : SU.Unbounded_String;
   dateData : dateType;
   max, numStacks, L0, SSmin, SSmax, dataType : Integer;
   error : boolean := false;
   stackNum, choice : Integer;
   buffer : character;
   monthTemp : String(1..11);
   count : integer;

   procedure putString (x: in SU.Unbounded_String) is
   begin put(x);
   end putString;
   procedure putDate (x: in dateType) is
   begin date.MonthNameIO.put(x.month); put(" "); put(x.day, 0); put(", "); put(x.year, 0);
   end putDate;

begin
   put("Enter 1 for Strings, 2 for Dates: "); get(dataType); New_Line;
   put("Enter the number of stacks: "); get(numStacks); New_Line;
   put("Enter minimum subscipt of the multistack array: "); get(L0); New_Line;
   put("Enter the max storage of all combined stacks: "); get(max); New_Line;
   put("Enter the min subscript of the array: "); get(SSmin); New_Line;
   put("Enter the max subscript of the array: "); get(SSmax); New_Line;
   if dataType = 1 then
      declare
         package s is new multistack(numStacks, L0, max, SSmin, SSmax, SU.Unbounded_String, putString);
      begin
         StringLoop:
         loop
            new_line; put("Enter 1 for Push, 2 for Pop, 3 for End. "); get(choice); New_Line;
            case choice is
               when 1 =>
                  put("Please print which stack and the data to push. ");
                  get(stackNum);
                  get(buffer);
                  data := get_line;
                  s.push(data, stackNum, Error);
                  if error = true then
                     put_line("Can't push onto Stack.");
                     Exit StringLoop;
                  end if;
                  when 2 =>
                  put("Please print which stack to pop. ");
                  get(stackNum);
                  s.pop(data, stackNum, Error);
                  if error = true then
                     New_Line; put("Can't Pop.");
                     error := false;
                  else
                     New_Line; put(data);
                  end if;
               when 3 =>
                  exit StringLoop;
               when others =>
                  put("Invalid choice.");
            end case;
         end loop StringLoop;
      end;
   elsif dataType = 2 then
      declare
         package s is new multistack(numStacks, L0, max, SSmin, SSmax, DateType, putDate);
      begin

         DateLoop:
         loop
            new_line; put_line("Enter 1 for Push, 2 for Pop, 3 for End. ");
            get(choice);

            case choice is
               when 1 =>
                  put_line("Please print which Stack to push. ");
                  get(stackNum);
                  put("Enter the date: ");
                  count := 1;
                  getMonthTemp:
                  loop
                     get(buffer);
                     monthTemp(count) := buffer;
                     count := count + 1;
                     exit getMonthTemp when buffer = ' ';
                  end loop getMonthTemp;
                  get(dateData.day); get(buffer); get(dateData.year);
                  if monthTemp(1..3) = "Jan" then dateData.month := January;
                     elsif monthTemp(1..3)="Feb" then dateData.month := February;
                     elsif monthTemp(1..3) = "Mar" then dateData.month := March;
                     elsif monthTemp(1..3) = "Apr" then dateData.month := April;
                     elsif monthTemp(1..3) = "May" then dateData.month := May;
                     elsif monthTemp(1..3) = "Jun" then dateData.month := June;
                     elsif monthTemp(1..3) = "Jul" then dateData.month := July;
                     elsif monthTemp(1..3) = "Aug" then dateData.month := August;
                     elsif monthTemp(1..3) = "Sep" then dateData.month := September;
                     elsif monthTemp(1..3) = "Oct" then dateData.month := October;
                     elsif monthTemp(1..3) = "Nov" then dateData.month := November;
                     elsif monthTemp(1..3) = "Dec" then dateData.month := December;
                     else
                        put("Invalid Month."); return;
                  end if;
                  s.push(dateData, stackNum, Error);
                  if error = true then
                     put_line("Can't push onto Stack. ");
                     Exit DateLoop;
                  end if;
               when 2 =>
                  put("Please print which Stack to pop. ");
                  get(stackNum);
                  s.pop(dateData, stackNum, Error);
                  if error = true then
                     new_line;
                     put("Can't pop.");
                     error := false;
                  else
                     new_line;
                     date.MonthNameIO.put(dateData.month);
                     put(" ");
                     put(dateData.day, 0);
                     put(", ");
                     put(dateData.year, 0);
                  end if;
               when 3 =>
                  exit DateLoop;
               when others =>
                  put("Invalid choice.");
            end case;
         end loop DateLoop;
      end;
   end if;
end driver;