/*
 * ===================================================================
 *
 *       Filename:  database-main.cpp
 *
 *    Description:  Main Method
 *
 *        Created:  Thursday 28 February 2013 10:53:59  IST
 *       Compiler:  gcc
 *
 *         Author:  Mandeep Kaur, meghasimak@gmail.com
 *        License:  GNU General Public License
 *      Copyright:  Copyright (c) 2013, Great Developers
 *
 * ===================================================================
 */

 /**-------------------------------------------------------------------
  *  \mainpage MySQL Connectivity with C++
  *
  *  This is a working code example of using C++ to interface with MySQL.
  *  Steps:
  *
  *  \li Download this code \n
  *      $ git clone https://github.com/megha55/mysql-with-cpp.git
  *
  *  \li For installing MySQL Connector for C++ \n
  *      $ make install
  *
  *  \li Change database details in database-detail.h file.
  *
  *  \li To run example \n
  *      $ make
  *
  *------------------------------------------------------------------*/

  /**-------------------------------------------------------------------
   *  Include required header files
   *------------------------------------------------------------------*/

#include "DB.h"
#include <string>
#include <iostream>
using namespace std;

int main(void)
{
	MySQL Mysql;
	int IntroWhile = 1;
	int IntroInsideWhile = 1;
	int answer;
	string user_name, pass, str;
	while (IntroWhile == true)
	{
		cout << "\nPlease Login:" << endl << endl;
		cout << "UserID: ";
		cin >> user_name;
		cout << "Password: ";
		cin >> pass;

		answer = Mysql.CheckUserNameAndPass(user_name, pass);
		if (answer == 1)
		{
			cout << "Welcome , You are loged in as a manager\n\n";
			IntroWhile = false;
			Sleep(2000);
		}
		else if(answer == 0)
		{
			cout << "Welcome , You are loged in as a worker\n\n";
			IntroWhile = false;
			Sleep(2000);

		}
		else
		{
			cout << "There is an error with the username or password\n\n";
			cout << "Please try again\n\n";
			Sleep(2000);
		}

	}
	
	while (IntroInsideWhile == true)
	{
		system("CLS");
		cout << "---------WELCOME TO NAVY STORE MANAGED BY DANIEL & KOBANY---------\n";
		cout << "---------AVAILABLE FUNCTIONS---------\n";
		string choice;

		cout << "1.Inventory Area\n";
		cout << "2.Delivery Area\n";
		cout << "3.Deals Area\n";
		cout << "4.Customers Area\n";
		cout << "5.Orders Area\n";
		cout << "6.Workers Area\n";
		cout << "7.To exit\n";
		cout << "Enter your choice\n";

		cin >> choice;
		//Inventory

		if (choice == "1") 
		{
			system("CLS");
			while (true) 
			{
				string InsideChoice = "";
				cout << "1.Press 1 to check if book exist in stock.(1)\n";
				cout << "2.Press 2 to check who is the oldest book.(3)\n";
				cout << "3.Press 3 to check what is the book with the most traslations.(8)\n";
				cout << "4.Press 4 to check how much books the store bought between 2 dates and show to profit.(22a)\n";
				cout << "5.Press 5 to check the store profit in a specific month.(22b)\n";
				cout << "6.Press 6 to go back to the main menu.\n";
				cin >> InsideChoice;
				system("CLS");

				if (InsideChoice == "1") 
				{ 
					Mysql.IsBookExist();
				}
				else if (InsideChoice == "2")
				{
					Mysql.ShowOldestBook();
				}
				else if (InsideChoice == "3")
				{
					Mysql.ShowMostTrasnaltionsBook();
				}
				else if (InsideChoice == "4")
				{
					Mysql.ShowTheAmountOfBooksThatTheStoreBought();
				}
				else if (InsideChoice == "5")
				{
					Mysql.ShowStoreProfit();
				}
				else if (InsideChoice == "6")
				{
					break;
				}
				else
				{
					cout << "There is no such option ,\n";
					cout << "Please try again\n";
					cin >> InsideChoice;
				}

				cout << "Press any key to continue...\n";
				cin.ignore();
				getchar();
				system("CLS");
			}

		}
		//Delivery

		else if (choice == "2") 
		{
			while (true)
			{
				system("CLS");
				string InsideChoice = "";
				cout << "1.Press 1 to calc the payment for delivery (11).\n";
				cout << "2.Press 2 to check the status of delivery(13).\n";
				cout << "3.Press 3 to check what is the shippments amount in a particular month by Xpress.(14)\n";
				cout << "4.Press 4 to check how much deliveries made by israel post and how much by Xpress in the past 12 month.(17)\n";
				cout << "5.Press 5 to check how much deliveries had at least 2 copies.(18)\n";
				cout << "6.Press 6 to check how much deliveries had at least 2 copies.(21)\n";
				cout << "7.Press 7 to go back to the main menu.";

				cin >> InsideChoice;
				system("CLS");
				if (InsideChoice == "1")
				{
					Mysql.CalcDelivery();
				}
				else if (InsideChoice == "2")
				{
					Mysql.DeliveryStatus();
				}
				else if (InsideChoice == "3")
				{
					Mysql.ShowShipmentAmountByExpress();
				}
				else if (InsideChoice == "4")
				{
					Mysql.ShowHowMuchDeliveriesByIsraelPostAndExpress();
				}
				else if (InsideChoice == "5")
				{
					Mysql.ShowAllDeliveriesWithAtLeast2Copies();
				}
				else if (InsideChoice == "6")
				{
					Mysql.ShowAllDeliveriesWithAtLeast2Copies();
				}
				else if (InsideChoice == "7")
				{
					break;
				}
				else
				{
					cout << "There is no such option ,\n";
					cout << "Please try again\n";
					cin >> InsideChoice;
				}
				cout << "Press any key to continue...\n";
				cin.ignore();
				getchar();
				system("CLS");
			}
		}
		//Deals

		else if (choice == "3") 
		{
			while (true)
			{

				system("CLS");
				string InsideChoice = "";
				cout << "1.Press 1 to check how many copies of spesific book was sold (5)\n";
				cout << "2.Press 2 to check who is the most popular author(6).\n";
				cout << "3.Press 3 to check who are the top 3 coustumers(7).\n";
				cout << "4.Press 4 to check the history of specific customer (9).\n";
				cout << "5.Press 5 to check the history of specific customer (12).\n";
				cout << "6.Press 6 to check what is the ammount of money that dlivered to the store account by bit App in specific month.(15)\n";
				cout << "7.Press 7 to check what is the deals that made proffit in the last 12 monthe in compere to last year(16).\n";
				cout << "8.Press 8 to check all the costumers that bought at least one book in the last 24 month.(19)\n";
				cout << "9.Press 9 to check what is the averge of deals in the last 12 month for evry month.(23)\n";
				cout << "10.Press 10 to check who is the seller with the most deals in a specific month (25)\n";
				cout << "11.Press 11 to go back to the main menu.";

				cout << "Enter q to exit.\n";
				cin >> InsideChoice;
				system("CLS");
				if (InsideChoice == "1")
				{
					Mysql.ShowHowManyBookSold();
				}
				else if (InsideChoice == "2")
				{
					Mysql.ShowMostPopularAuthor();
				}
				else if (InsideChoice == "3")
				{
					Mysql.ShowTopThreeCostumers();
				}
				else if (InsideChoice == "4")
				{
					Mysql.ShowHistoryOfSpecificCostumer();
				}
				else if (InsideChoice == "5")
				{
					Mysql.IsCostumerSplitedDeal();
				}
				else if (InsideChoice == "6")
				{
					Mysql.ShowSumOfBitInSpecificMonth();
				}
				else if (InsideChoice == "7")
				{
					Mysql.ShowTheMostProfitableDealsInTheLast12Months();
				}
				else if (InsideChoice == "8")
				{
					Mysql.ShowAllCostumers();
				}

				else if (InsideChoice == "9")
				{
					Mysql.ShowAverageDealsInYear();
				}

				else if (InsideChoice == "10")
				{
					Mysql.ShowTheWorkerWithTheMostDeals();
				}

				else if (InsideChoice == "11")
				{
					break;
				}

				else
				{
					cout << "There is no such option ,\n";
					cout << "Please try again\n";
					cin >> InsideChoice;
				}

				cout << "Press any key to continue...\n";
				cin.ignore();
				getchar();
				system("CLS");
			}
		}

		//Customers

		else if (choice == "4") 
		{
			while (true) 
			{
				system("CLS");
				string InsideChoice = "";
				cout << "1.Press 1 to check who is the oldest customer.(2)\n";
				cout << "2.Press 2 to check all the customers that made an order and the store didn't call them in 14 days.(20)\n";
				cout << "3.Press 3 to go back to the main menu.";
				cin >> InsideChoice;
				system("CLS");

				if (InsideChoice == "1") 
				{ 
					Mysql.ShowOldestCustomer();
				}
				else if (InsideChoice == "2")
				{
					Mysql.ShowOrderCall14Days();
				}
				else if (InsideChoice == "3") 
				{
					break;
				}
				else
				{
					cout << "There is no such option ,\n";
					cout << "Please try again\n";
					cin >> InsideChoice;
				}
				cout << "Press any key to continue...\n";
				cin.ignore();
				getchar();
				system("CLS");
			}
		}

		//Orders

		else if (choice == "5") 
		{
			while (true) 
			{
				system("CLS");
				string InsideChoice = "";
				cout << "1.Press 1 to see the current order list (4)\n";
				cout << "2.Press 2 to see history of order for a spesific person (10)\n";
				cout << "3.Press 3 to go back to the main menu.";
				cin >> InsideChoice;
				system("CLS");

				if (InsideChoice == "1") 
				{
					Mysql.ShowOrderList();
				}

				else if (InsideChoice == "2")
				{
					Mysql.ShowHistoryOfOrders();
				}

				else if (InsideChoice == "3") 
				{ 
					break;
				}
				else
				{
					cout << "There is no such option ,\n";
					cout << "Please try again\n";
					cin >> InsideChoice;
				}
				cin.ignore();
				system("CLS");
			}
		}

		//Workers

		else if (choice == "6") 
		{
			system("CLS");
			while (true) 
			{
				string InsideChoice = "";
				cout << "1.Press 1 to check the salary of a specific emploey in a spesific month.(24)\n";
				cout << "2.Press 2 to go back to the main menu.";
				cin >> InsideChoice;
				system("CLS");

				if (InsideChoice == "1") 
				{ 
					Mysql.ShowSalaryOfSpecificWorker();
				}
				else if (InsideChoice == "2")
				{
					break;
				}
				else
				{
					cout << "There is no such option ,\n";
					cout << "Please try again\n";
					cin >> InsideChoice;
				}
				cin.ignore();
				system("CLS");
			}
		}
		
		else if (choice == "7")
		{
			return 0;
		}
		
		else
		{
			cout << "There is no such option ,\n";
			cout << "Please try again\n";
			cin >> choice;
		}
	}
	
	return 0;
}




