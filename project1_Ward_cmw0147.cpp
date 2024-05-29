#include <iostream>
#include <iomanip>
/*
Collin Ward
cmw0147@auburn.edu
COMP 2710-002
project1_Ward_cmw0147

Coded in Visual Studio and Complied with Visual Studio Command Prompt and Auburn Linux Server
A simple program to create an amortization table.

I was not fmailiar with alot of the C++ syntax, I found a good equivalent to try catch and used them for input checks.
*/

using namespace std;

int main() {
  
   int loanAmount;
   std::cout << "Loan Amount: ";
   std::cin >> loanAmount;
       while(std::cin.fail()) {
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(),'\n');
    std::cout << "Invalid Loan Amount";
    return 0;
}
   while (loanAmount < 0) {
 std::cout << "Loan Amount > 0: ";
   std::cin >> loanAmount;
       while(std::cin.fail()) {
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(),'\n');
    std::cout << "Invalid Loan Amount";
    return 0;
}
   }
  
   double interestRate;
   std::cout << "Interest Rate ('%' per year): ";

      std::cin >> interestRate;
   while(std::cin.fail()) {
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(),'\n');
    std::cout << "Invalid Interest Rate";
    return 0;
   }

   while (interestRate < 0) {
     std::cout << "Interest Rate ('%' per year) > 0: ";
      std::cin >> interestRate;
  while(std::cin.fail()) {
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(),'\n');
    std::cout << "Invalid Interest Rate";
    return 0;
}
   }
   
   double monthlyPayment;
   std::cout << "Monthly Payments: ";
   std::cin >> monthlyPayment;
     while(std::cin.fail()) {
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(),'\n');
    std::cout << "Invalid Monthly Payment";
    return 0;
}
   while (monthlyPayment < (interestRate/12 * loanAmount / 100)) {
 std::cout << "Larger Monthly Payments: ";
 std::cin >> monthlyPayment;
     while(std::cin.fail()) {
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(),'\n');
    std::cout << "Invalid Monthly Payment";
    return 0;
}
   }

   double balance = loanAmount;
   int month = 0;
   if (loanAmount < 0 || interestRate < 0 || monthlyPayment < 0) {
      return 0;
   } 
   double interestTotal = 0;
 
   std::cout << "*****************************************************************\n";
   std::cout << "\tAmortization Table\n";
   std::cout << "*****************************************************************\n";
   std::cout << "Month\tBalance\t\tPayment\tRate\tInterest\tPrincipal\n";
   std::cout << month << "\t";
   std:cout << fixed << setprecision(2) << "$" << balance << "\t";
   if (balance > 1000) {
 std::cout << "N/A\tN/A\tN/A\t\tN/A\n";
   } else {
   std::cout << "\tN/A\tN/A\tN/A\t\tN/A\n";
   }

   while (balance > 0) {
   month++;
   double interest = ((interestRate / 12) * balance) / 100;
   interestTotal = interestTotal + interest;
   double principal = monthlyPayment - interest;

   if (balance > principal) {
balance = balance - principal;

   } else {
  monthlyPayment = balance + interest;
  principal = balance;
  balance = 0;
   }
if (balance > 1000) {
std::cout << month << "\t$" << fixed << setprecision(2) << balance << "\t";
   std::cout << "$" << monthlyPayment << "\t" << interestRate / 12 << "\t$" << interest << "\t";
   std::cout << "\t" << principal << "\n";

} else {
   std::cout << month << "\t$" << fixed << setprecision(2) << balance << "\t";
   std::cout << "\t$" << monthlyPayment << "\t" << interestRate / 12 << "\t$" << interest << "\t";
   std::cout << "\t" << principal << "\n";
}
   }
    std::cout << "*****************************************************************\n\n";

    std::cout << "It takes " << month << " months to pay off the loan.\n";
    std::cout << "Total interest paid is: $" << fixed << setprecision(2) << interestTotal;

   return 0;

}