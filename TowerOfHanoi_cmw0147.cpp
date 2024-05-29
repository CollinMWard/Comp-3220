/*
 * Midterm Exam 2
 * Software Construction COMP2710
 * Instructor: Xuechao Li @ Auburn University
 */

#include<iostream>
#include<time.h>
using namespace std;
int i = 0;

// tower of HANOI function implementation
void moveDisk(int n, char Original, char Aux, char Dest)
{
	if (n == 0)
		return;
	moveDisk(n - 1, Original, Dest, Aux);
	cout << "Move Disk " << n << " from " << Original << " to " << Dest << endl;
	i++;
	moveDisk(n - 1, Aux, Original, Dest);

}

// main program
int main()
{
	int n;
	time_t start, end;
	cout << "---------------------- I/O format ----------------------" << endl;
	cout << "Enter the number of disks:";
	cout << n << " " ;
	cin >> n;

	// calling the moveDisk
	i = 0;
	time(&start);
	moveDisk(n, 'A', 'B', 'C');
	time(&end);
	

	double elapse = difftime(end, start);
	cout << "The elapsed time is " << elapse << " seconds" << " for moving " << n << " disks " << endl;
	cout << i << "Seconds";
	cout << "--------------------------------------------------------" << endl;
	
	return 0;
}
