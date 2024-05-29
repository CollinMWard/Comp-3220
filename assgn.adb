with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
package body Assgn is 

 package Rand is new Ada.Numerics.Discrete_Random (BINARY_NUMBER);
      use Rand;

   --initialize first array (My_Array) with random binary values
  procedure Init_Array (Arr: in out BINARY_ARRAY) is
    begin
        for I in The_Array'range loop
            The_Array(I) := BINARY_NUMBER'Pos (Random(2));
        end loop;
    end Init_Array;




--reverse binary array
   procedure Reverse_Bin_Arr (Arr : in out BINARY_ARRAY) is
      Temp : BINARY_ARRAY;
   begin
      -- Reverse the binary array
      for i in Arr'range loop
         Temp(Arr'length - i + 1) := Arr(i);
      end loop;

      Arr := Temp;
   end Reverse_Bin_Arr;




--print an array
procedure Print_Bin_Arr (Arr : in BINARY_ARRAY) is
   begin
      for I in Arr'range loop
         Put(Arr(I));
      end loop;
      New_Line;
   end Print_Bin_Arr;






 --Convert Integer to Binary Array
    function Int_To_Bin(Num : in INTEGER) return BINARY_ARRAY is
   Temp_Array : BINARY_ARRAY;
   Positive_Int : INTEGER := ABS(Num);
   I : INTEGER := Temp_Array'last;
begin
   while Positive_Int > 0 loop
      Temp_Array(I) := BINARY_NUMBER'Pos (Positive_Int mod 2);
      Positive_Int := Positive_Int / 2;
      I := I - 1;
   end loop;
   -- If the original integer was negative, take the two's complement
   if Num < 0 then
      for J in Temp_Array'range loop
         Temp_Array(J) := BINARY_NUMBER'Pos (1 - BINARY_NUMBER'Pos(Temp_Array(J)));
      end loop;
      for J in reverse Temp_Array'range loop
         if Temp_Array(J) = BINARY_NUMBER'Pos (0) then
            Temp_Array(J) := BINARY_NUMBER'Pos (1);
            exit;
         else
            Temp_Array(J) := BINARY_NUMBER'Pos (0);
         end if;
      end loop;
   end if;
   -- Return the binary array representation of the integer
   return Temp_Array;
end Int_To_Bin;



--convert binary number to integer
  function Bin_To_Int (Arr : in BINARY_ARRAY) return INTEGER is
   Result : INTEGER := 0;
begin
   for I in Arr'range loop
      Result := Result * 2 + Integer(BINARY_NUMBER'Pos(Arr(I)));
   end loop;
   -- Return the integer
   return Result;
end Bin_To_Int;

    
       
       
   --overloaded + operator to add two BINARY_ARRAY types together

function "+" (Left, Right : in BINARY_ARRAY) return BINARY_ARRAY is
   Result : BINARY_ARRAY;
   Carry : BINARY_NUMBER := BINARY_NUMBER'Pos(0);
begin
   -- Add two binary arrays together one digit at a time
   for I in Result'range loop
      Result(I) := (Left(I) + Right(I) + Carry) mod 2;
      Carry := (Left(I) + Right(I) + Carry) / 2;
   end loop;

   return Result;
end "+";

       
       
       
       
       
    
--overloaded + operator to add an INTEGER type and a BINARY_ARRAY type together
       
function "+" (Left : in INTEGER; Right : in BINARY_ARRAY) return BINARY_ARRAY is
   Result : BINARY_ARRAY;
   Temp : BINARY_ARRAY;
   Carry : BINARY_NUMBER := BINARY_NUMBER'Pos(0);
begin
   -- Convert the integer to a binary array
   Temp := Int_To_Bin(Left);

   -- Add two binary arrays together one digit at a time
   for I in Result'range loop
      if Temp(I) = BINARY_NUMBER'Pos(1) and Right(I) = BINARY_NUMBER'Pos(1) then
         if Carry = BINARY_NUMBER'Pos(1) then
            Result(I) := BINARY_NUMBER'Pos(1);
         else
            Result(I) := BINARY_NUMBER'Pos(0);
         end if;
         Carry := BINARY_NUMBER'Pos(1);
      elsif Temp(I) = BINARY_NUMBER'Pos(1) or Right(I) = BINARY_NUMBER'Pos(1) then
         if Carry = BINARY_NUMBER'Pos(1) then
            Result(I) := BINARY_NUMBER'Pos(0);
            Carry := BINARY_NUMBER'Pos(1);
         else
            Result(I) := BINARY_NUMBER'Pos(1);
            Carry := BINARY_NUMBER'Pos(0);
         end if;
      else
         if Carry = BINARY_NUMBER'Pos(1) then
            Result(I) := BINARY_NUMBER'Pos(1);
         else
            Result(I) := BINARY_NUMBER'Pos(0);
         end if;
         Carry := BINARY_NUMBER'Pos(0);
      end if;
   end loop;

   return Result;
end "+";






--overloaded - operator to subtract a BINARY_ARRAY type from an INTEGER type
function "-" (Left, Right : in BINARY_ARRAY) return BINARY_ARRAY is
   Result : BINARY_ARRAY;
   Borrow : BINARY_NUMBER := BINARY_NUMBER'Pos(0);
begin
   for I in Result'range loop
     
      if Left(I) = BINARY_NUMBER'Pos(1) and Right(I) = BINARY_NUMBER'Pos(0) then
         if Borrow = BINARY_NUMBER'Pos(1) then
            Result(I) := BINARY_NUMBER'Pos(0);
            Borrow := BINARY_NUMBER'Pos(0);
         else
            Result(I) := BINARY_NUMBER'Pos(1);
         end if;
     
      elsif Left(I) = BINARY_NUMBER'Pos(0) and Right(I) = BINARY_NUMBER'Pos(1) then
         if Borrow = BINARY_NUMBER'Pos(1) then
            Result(I) := BINARY_NUMBER'Pos(1);
         else
            Result(I) := BINARY_NUMBER'Pos(0);
            Borrow := BINARY_NUMBER'Pos(1);
         end if;
      
      elsif Left(I) = BINARY_NUMBER'Pos(1) and Right(I) = BINARY_NUMBER'Pos(1) then
         if Borrow = BINARY_NUMBER'Pos(1) then
            Result(I) := BINARY_NUMBER'Pos(1);
         else
            Result(I) := BINARY_NUMBER'Pos(0);
            Borrow := BINARY_NUMBER'Pos(1);
         end if;
  
      else
         if Borrow = BINARY_NUMBER'Pos(1) then
            Result(I) := BINARY_NUMBER'Pos(1);
            Borrow := BINARY_NUMBER'Pos(0);
         else
            Result(I) := BINARY_NUMBER'Pos(0);
         end if;
      end if;
   end loop;

   return Result;
end "-";




 --overloaded - operator to subtract one BINARY_ARRAY type from another	
function "-" (Left : in INTEGER; Right : in BINARY_ARRAY) return BINARY_ARRAY is
   Temp : INTEGER;
   Result : BINARY_ARRAY;
begin
   -- Convert binary array to integer and subtract the integer value of `Left`
   Temp := Bin_To_Int(Right) - Left;
   -- Convert the difference back to a binary array
   Result := Int_To_Bin(Temp);
   return Result;
end "-";







end Assgn;