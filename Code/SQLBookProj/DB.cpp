/*
 * ===================================================================
 *
 *       Filename:  database.cc
 *
 *    Description:  Definition of MySQL Class for accessing database
 *
 *        Created:  Friday 22 February 2013 02:07:49  IST
 *       Compiler:  gcc
 *
 *         Author:  Mandeep Kaur, meghasimak@gmail.com
 *        License:  GNU General Public License
 *      Copyright:  Copyright (c) 2013, Great Developers
 *
 * ===================================================================
 */

 /**-------------------------------------------------------------------
  *  Include mysql.h file local header file(declaration of class)
  *------------------------------------------------------------------*/

#include "DB.h"
#include <sstream>
#define SERVER "localhost"
#define USER "root"
#define PASSWORD "Jkobany1@"
#define DATABASE "SecondHandStore"
using namespace std;

  /**
   *--------------------------------------------------------------------
   *       Class:  MySQL
   *      Method:  MySQL :: MySQL()
   * Description:  Constructor to initialize database conectivity
   *--------------------------------------------------------------------
   */

MySQL::MySQL()
{
    filed = 0;
    i =0;
    row = NULL;
    res_set = NULL;
    connect = mysql_init(NULL);
    if (!connect)
    {
        cout << "MySQL Initialization Failed";
    }

    connect = mysql_real_connect(connect, SERVER, USER, PASSWORD, DATABASE, 0, NULL, 0);


    if (connect)
    {
        cout << "Connection Succeeded\n";
    }

    else
    {
        cout << "Connection Failed\n";
    }
}

/**
 *--------------------------------------------------------------------
 *       Class:  MySQL
 *      Method:  MySQL :: ShowTables()
 * Description:  Show tables in database
 *--------------------------------------------------------------------
 */

void MySQL::ShowTables()
{
    /** Add MySQL Query */
    mysql_query(connect, "show tables");

    i = 0;

    res_set = mysql_store_result(connect);

    uint64_t numrows = mysql_num_rows(res_set);

    cout << "Tables in *" << DATABASE << "* database " << endl;

    while (((row = mysql_fetch_row(res_set)) != NULL))
    {
        cout << row[i] << endl;
    }

    system("pause");
}

void MySQL::selectQuery(MYSQL_RES* res)
{
    int num_fields = mysql_num_fields(res);
    MYSQL_ROW row = mysql_fetch_row(res);
    if (row != NULL) 
    {
        num_fields = mysql_num_fields(res);
        int i = 0;
        do 
        {
            for (i = 0; i < num_fields; i++)
            {
                cout << row[i] << "\t";

            }
            cout << endl;
        } 
        while ((row = mysql_fetch_row(res)));
        mysql_free_result(res);
    }
}

int MySQL::CheckUserNameAndPass(string user_name, string pass)
{
    string query = "select SW.Is_Manager from Store_Worker SW where SW.User_id = '" + user_name + "' and SW.User_Password = '" + pass + "' " ;
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The oldest book in Inventory is : \n";
        int num_fields = mysql_num_fields(res);
        MYSQL_ROW row = mysql_fetch_row(res);
        if (row != NULL)
        {
            num_fields = mysql_num_fields(res);
            int i = 0;
            do
            {
                for (i = 0; i < num_fields; i++)
                {
                    string check = row[i];
                    int checkInt = stoi(check);
                    return checkInt;
                }
                cout << endl;
            } while ((row = mysql_fetch_row(res)));
            mysql_free_result(res);
        }
    }
    else
    {
        return 3;
    }
}

bool MySQL::IsBookExist()
{
    cin.ignore();
    cout << "Plese enter book Name: \t";
    string Name = "";
    getline(cin, Name);
    string query = "Select b.Book_Name, i.New_Amount as Amount, i.Stored_Location from Inventory i inner join Book_Copy BC on BC.Book_id = i.Copy_id inner join book b on b.Book_id = BC.Book_id where b.Book_Name = '" + Name + "' group by i.Sequence";

    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    MYSQL_ROW row = mysql_fetch_row(res);
    if (row != nullptr) 
    {
        cout << res->metadata;
        cout << "The book " << Name <<  " is in stock\n\n";
    }
    else 
    {
        cout << "The book "<< Name << "is NOT in stock" << endl;
        return false;
    }


    return true;
}

void MySQL::ShowOldestBook()
{
    string query = " select i.Copy_id, i.Stored_Date, b.Book_Name from Inventory i  inner join Book_Copy BC on BC.Book_id = i.Copy_id inner join book b on b.Book_id = BC.Book_id order by i.Stored_Date limit 1";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL) 
    {
        cout << "The oldest book in Inventory is : \n";
        selectQuery(res);
    }
    else 
    {
        cout << "There is no book in Inventory\n\n";
    }
}

void MySQL::ShowMostTrasnaltionsBook()
{

    string query = " select count(distinct(BC.Translation_id)) Translation_Num, b.Book_Name from Inventory i inner join Book_Copy BC on i.Copy_id = BC.Copy_id inner join book b on b.Book_id = BC.Book_id inner join translation t on t.Translation_id = BC.Translation_id group by b.Book_id order by count(distinct(BC.Translation_id)) DESC limit 1";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The Book with the most trasnlations is : \n";
        selectQuery(res);
    }
    else
    {
        cout << "There is no book in Inventory\n\n";
    }

}
void MySQL::ShowTheAmountOfBooksThatTheStoreBought()
{
    string date1;
    string date2;
    cout << "Please enter 2 dates in yyyy-mm-dd format!\nPlease enter the FIRST DATE:\t\n";
    cin >> date1;
    cout << "Please enter the SECONED DATE:\t\n";
    cin >> date2;

    string query = "select Sum(pd.Amount) Books_Total_Amount, Sum(pd.Amount * pd.Price_Per_One) Books_Total_Price from purchasing p inner join Purchasing_Detail pd on p.Purchase_id = pd.Purchase_id where p.Purchasing_Date >= '" + date1 + "' AND p.Purchasing_Date <= '" + date2 + "'";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "the amount of books that the store bought and the profit that the store made between " << date1 << " and " << date2 << " is: \n";
        selectQuery(res);
    }
    else
    {
        cout << "There store didn't buy book between this dates.\n\n";
    }
}
void MySQL::ShowStoreProfit()
{
    string date1;
    string date2;
    string month;
    int year;
    cout << "Please enter the Month(mm):\t\n";
    cin >> month;
    cout << "Please enter the year(yyyy):\t\n";
    cin >> year;

    date1 = to_string(year) + "-" + (month) + "-01";
    if (month == "12")
    {
        date2 = to_string(year+1) + "-"+ "01-01";
    }
    else
    {
        int intmonthr = stoi(month);
        intmonthr++;
        if (intmonthr <10)
        {
            date2 = to_string(year) + "-0" + to_string(intmonthr) + "-01";
        }
        else
        {
            date2 = to_string(year) + "-" + to_string(intmonthr) + "-01";
        }

    }

    string query = "select sum((dd.Sell_Price - pd.price_per_one) * dd.Amount) as Profit, YEAR(d.Deal_Date) AS 'year', MONTH(d.Deal_Date) AS 'month'  from Deal d inner join Deal_Details dd on d.Deal_id = dd.Deal_id inner join inventory i on dd.Copy_id = i.Copy_id inner join Purchasing_Detail pd on dd.Copy_id = pd.Copy_id inner join purchasing p  on p.Purchase_id = pd.Purchase_id where d.Deal_Date >= '" + date1 + "' AND d.Deal_Date <= '" + date2 + "'";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The profit of the store between  " << date1 << " and " << date2 << " is: \n";
        selectQuery(res);
    }
}
//
void MySQL::CalcDelivery()
{
    string query = "select d.Deliver_id, sum(Amount * dd.Weight * dt.Cost) as Delivery_Price, CONCAT(c.First_Name, '" "', c.Last_Name) as Customer_Name   from delivery d inner join Delivery_Detail dd on d.Deliver_id = dd.Deliver_id inner join Delivery_Type dt on d.Type_id = dt.type_id inner join customer c on d.customer_id = c.customer_id group by d.Deliver_id";

    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The Delivery costs for all deliveries is :\n\n";
        selectQuery(res);
    }
    else
    {
        cout << "There is No Deliveries in the DB.\n\n";
    }
}

void MySQL::DeliveryStatus()
{
    cout << "Plese enter Delivery ID: \t";
    string ID = "";
    cin >> ID;
    string query = "select d.Deliver_id, d.Status_Delivery from delivery d inner join Delivery_Type dt on d.Type_id = dt.type_id inner join customer c on d.customer_id = c.customer_id where d.Deliver_id ='" + ID + "'";

    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The Delivery status is :\n\n";
        selectQuery(res);
    }
    else
    {
        cout << "There is No Delivery with this ID.\n\n";
    }
}

void MySQL::ShowShipmentAmountByExpress()
{
    string date1;
    string date2;
    string Shipping = "Courier_Company";
    cout << "Please enter 2 dates in yyyy-mm-dd format!\nPlease enter the FIRST DATE:\t\n";
    cin >> date1;
    cout << "Please enter the SECONED DATE:\t\n";
    cin >> date2;
    string query = "select sum(Amount * dd.Weight * dt.Cost) as Delivery_Price, dt.Type_Delivery from delivery d inner join Delivery_Detail dd on d.Deliver_id = dd.Deliver_id inner join Delivery_Type dt on d.Type_id = dt.type_id inner join customer c on d.customer_id = c.customer_id where d.Start_Date >= '" + date1 + "' AND d.Start_Date <= '" + date2 + "' and dt.Type_Delivery = '" + Shipping + "' group by dt.Type_Delivery";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The shipment amount by express bettwen  " << date1 << " and " << date2 << " is: \n";
        selectQuery(res);
    }
    else
    {
        cout << "There is No writer between these dates.\n\n";
    }
}

void MySQL::ShowHowMuchDeliveriesByIsraelPostAndExpress()
{
    string query = "select count(d.Deliver_id) Num_Of_Delivers, dt.Type_Delivery  from delivery d inner join Delivery_Detail dd on d.Deliver_id = dd.Deliver_id inner join Delivery_Type dt on d.Type_id = dt.type_id where d.Start_Date >= 12 - MONTH(NOW()) AND d.Start_Date <= NOW() group by dt.Type_Delivery";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        selectQuery(res);
    }

}

void MySQL::ShowAllDeliveriesWithAtLeast2Copies()
{
    string date1;
    string date2;
    string month;
    int year;
    cout << "Please enter the Month(mm):\t\n";
    cin >> month;
    cout << "Please enter the year(yyyy):\t\n";
    cin >> year;

    date1 = to_string(year) + "-" + (month)+"-01";
    if (month == "12")
    {
        date2 = to_string(year + 1) + "-" + "01-01";
    }
    else
    {
        int intmonthr = stoi(month);
        intmonthr++;
        if (intmonthr < 10)
        {
            date2 = to_string(year) + "-0" + to_string(intmonthr) + "-01";
        }
        else
        {
            date2 = to_string(year) + "-" + to_string(intmonthr) + "-01";
        }

    }

    string query = "select Sum(i.New_Amount) as Amount, YEAR(i.Stored_Date) AS 'year', MONTH(i.Stored_Date) AS 'month'  from inventory i where i.Stored_Location = 'Stock' and i.Stored_Date >= '" + date1 + "' AND i.Stored_Date <= '" + date2 + "'";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The books that in the Inventory between " << date1 << " and " << date2 << " are: \n";
        selectQuery(res);
    }
    else
    {
        cout << "There is no book in Inventory.\n\n";
    }
}


void MySQL::ShowOrderList()
{
    string query = "select * from Store_Order SO where Order_Status != 'Complete' order by SO.Order_Date";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    row = mysql_fetch_row(res);
    int numOfFields = mysql_num_fields(res);
    int i = 0;
    do {
        for (i = 0; i < numOfFields; i++)
        {
            cout << row[i] << "\t";
        }
        cout << "\n";
    }
    while ((row = mysql_fetch_row(res)));
    mysql_free_result(res);
}

void MySQL::ShowHistoryOfOrders()
{
    string FirstName;
    string LastName;
    cout << "Please enter the FIRST NAME of the costumer:\t\n";
    cin >> FirstName;
    cout << "Please enter the LAST NAME of the costumer:\t\n";
    cin >> LastName;

    string query = "select CONCAT(c.First_Name, '" "', c.Last_Name) as Customer_Name, SO.Order_Date, b.Book_Name, b.Title, b.Book_Condition, SO.Amount, So.Order_Status  from Store_Order SO inner join Book_Copy BC on SO.Copy_id = BC.Copy_id inner join book b on b.Book_id = BC.Book_id inner join customer c on SO.customer_id = c.customer_id where c.First_Name ='" + FirstName + "' And c.Last_Name ='" + LastName+ "' order by SO.Order_Date";

    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The History of the costumer " << FirstName << LastName << "is :\n\n";
        selectQuery(res);
    }
    else
    {
        cout << "There is No costumer " << FirstName << LastName << "  in the DB.\n\n";
    }


}



void MySQL::ShowHowManyBookSold()
{
    cin.ignore();
    string Name;
    cout << "Enter Book's name :\t";
    getline(cin, Name); 
    

    string query = "select sum(dd.Amount) as NUm_Of_Books from Deal d inner join Deal_Details dd on d.Deal_id = dd.Deal_id inner join Book_Copy BC on BC.Book_id = dd.Copy_id inner join book b on b.Book_id = BC.Book_id where b.Book_Name = '" + Name + "' group by dd.Amount";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL) {
        cout << "The number of sold book for " << Name << " is: \t";
        selectQuery(res);
    }
    else 
    {
        cout << "The book : " << Name << " Sold 0 Copies\n\n";
    }

}

void MySQL::ShowMostPopularAuthor()
{
    string date1;
    string date2;
    cout << "Please enter 2 dates in yyyy-mm-dd format!\nPlease enter the FIRST DATE:\t\n";
    cin >> date1;
    cout << "Please enter the SECONED DATE:\t\n";
    cin >> date2;
    string query = "select sum(dd.Amount) as Selling_Books, a.Author_Name from Deal d inner join Deal_Details dd on d.Deal_id = dd.Deal_id inner join Book_Copy BC on dd.Copy_id = BC.Copy_id inner join book b on b.Book_id = BC.Book_id inner join author a on a.Author_id = BC.Author_id where d.Deal_Date >= '" + date1 + "' AND d.Deal_Date <= '" + date2 + "' group by A.Author_Name order by sum(dd.Amount) DESC LIMIT 1";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL) 
    {
        cout << "The author that publish the most books bettwen the "<< date1<< " and " << date2 << " is: \n";
        selectQuery(res);
    }
    else 
    {
        cout << "There is No writer between these dates.\n\n";
    }
}

void MySQL::ShowTopThreeCostumers()
{
    string query = "select sum(dd.Amount) as Buing_Books, CONCAT(c.First_Name, '" "', c.Last_Name) as Customer_Name from Deal d inner join Deal_Details dd on d.Deal_id = dd.Deal_id inner join Book_Copy BC on dd.Copy_id = BC.Copy_id inner join book b on b.Book_id = BC.Book_id inner join customer c on d.customer_id = c.customer_id group by d.Customer_id order by count(d.customer_id) DESC limit 3";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The TOP 3 costumers that bout the most books are :\n\n";
        selectQuery(res);
    }
    else
    {
        cout << "There is'nt 3 Costumers .\n\n";
    }
}

void MySQL::ShowHistoryOfSpecificCostumer()
{ 

    string FirstName;
    string LastName;
    cout << "Please enter the FIRST NAME of the costumer:\t\n";
    cin >> FirstName;
    cout << "Please enter the LAST NAME of the costumer:\t\n";
    cin >> LastName;

    string query = "select CONCAT(c.First_Name, '""', c.Last_Name) as Customer_Name, b.book_name, dd.sell_price, d.Deal_Date from Deal d inner join Deal_Details dd on d.Deal_id = dd.Deal_id inner join Book_Copy BC on dd.Copy_id = BC.Copy_id inner join book b on b.Book_id = BC.Book_id inner join customer c on d.customer_id = c.customer_id where c.First_Name ='" +  FirstName  + "' And c.Last_Name ='" +  LastName + "' order by d.Deal_Date";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The History of the costumer " << FirstName<< " " << LastName << " "<<  "is :\n\n";
        selectQuery(res);
    }
    else
    {
        cout << "There is No costumer " <<FirstName << " " << LastName <<"  in the DB.\n\n";
    }


}

void MySQL::IsCostumerSplitedDeal()
{
    string FirstName;
    string LastName;
    cout << "Please enter the FIRST NAME of the costumer:\t\n";
    cin >> FirstName;
    cout << "Please enter the LAST NAME of the costumer:\t\n";
    cin >> LastName;

    string query = "select* from delivery d inner join Delivery_Detail dd on d.Deliver_id = dd.Deliver_id inner join Delivery_Type dt on d.Type_id = dt.type_id inner join customer c on d.customer_id = c.customer_id where d.Deal_id = c.First_Name = '" + FirstName + "' and c.Last_Name = '" + LastName + "'";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The costumer " << FirstName << " " << LastName << " " << "Split a Deal:\n\n";
        selectQuery(res);
    }
    else
    {
        cout << "There is No costumer " << FirstName << " " << LastName << "  in the DB.\n\n";
    }

}

void MySQL::ShowSumOfBitInSpecificMonth()
{
    string date1;
    string date2;
    string Patment_Method = "bit";
    cout << "Please enter 2 dates in yyyy-mm-dd format!\nPlease enter the FIRST DATE:\t\n";
    cin >> date1;
    cout << "Please enter the SECONED DATE:\t\n";
    cin >> date2;
    string query = "select Sum(d.Total_Cost) as Total_Cost, d.Pay_Option from Deal d where d.Pay_Option = '" + Patment_Method + "' and d.Deal_Date >= '" + date1 + "' AND d.Deal_Date <= '" + date2 + "' group by d.Pay_Option";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The total amount that tranfered by BIT between  " << date1 << " and " << date2 << " is: \n";
        selectQuery(res);
    }
    else
    {
        cout << "There amount between these dates is 0.\n\n";
    }
}

void MySQL::ShowTheMostProfitableDealsInTheLast12Months()
{
    string query = "SELECT d.deal_id, sum((dd.Sell_Price - pd.price_per_one) * dd.Amount) AS book_profit FROM Deal d inner join Deal_Details dd on d.Deal_id = dd.Deal_id inner join inventory i on dd.Copy_id = i.Copy_id inner join Purchasing_Detail pd on dd.Copy_id = pd.Copy_id where d.Deal_Date >= 12 - MONTH(NOW()) AND d.Deal_Date <= NOW() GROUP BY d.deal_id HAVING( SELECT AVG(Profit) AS average FROM (select sum((dd.Sell_Price - pd.price_per_one) * dd.Amount) as Profit  from Deal d inner join Deal_Details dd on d.Deal_id = dd.Deal_id inner join inventory i on dd.Copy_id = i.Copy_id inner join Purchasing_Detail pd on dd.Copy_id = pd.Copy_id inner join purchasing p  on p.Purchase_id = pd.Purchase_id where d.Deal_Date >= 12 - MONTH(NOW()) AND d.Deal_Date <= NOW() group by d.deal_id) AS Average_Profit ) < book_profit";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "There most profitable deals in the last 12 month are :\n\n";
        selectQuery(res);
    }
}

void MySQL::ShowAllCostumers()
{
    string query = "select * from Customer";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        selectQuery(res);
    }
    else
    {
        cout << "There is not Costumers .\n\n";
    }
}

void MySQL::ShowAverageDealsInYear()
{
    string date1;
    string date2;
    string month;
    int year;
    cout << "Please enter the Month(mm):\t\n";
    cin >> month;
    cout << "Please enter the year(yyyy):\t\n";
    cin >> year;
    date1 = to_string(year) + "-" + (month)+"-01";
    int intmonthr = stoi(month);
    if (intmonthr < 10)
    {
        date2 = to_string(year+1) + "-0" + to_string(intmonthr) + "-01";
    }
    else
    {
        date2 = to_string(year + 1) + "-" + to_string(intmonthr) + "-01";
    }
    string query = "select avg(d.Total_Cost) Total_Year_Cost, Month(d.Deal_Date) as 'Month', Year(d.Deal_Date) - 1 as 'From_Year', Year(d.Deal_Date) as 'To_Year' from Deal d where d.Deal_Date >= '" + date1 + "' AND d.Deal_Date <= '" + date2 + "' GROUP BY MONTH(d.Deal_Date)";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The average deals between  " << date1 << " and " << date2 << " is: \n";
        selectQuery(res);
    }
    else
    {
        cout << "There is not deals between  " << date1 << " and " << date2 << " is: \n";
    }
}

void MySQL::ShowTheWorkerWithTheMostDeals()
{
    string date1;
    string date2;
    string month;
    int year;
    cout << "Please enter the Month(mm):\t\n";
    cin >> month;
    cout << "Please enter the year(yyyy):\t\n";
    cin >> year;

    date1 = to_string(year) + "-" + (month)+"-01";
    if (month == "12")
    {
        date2 = to_string(year + 1) + "-" + "01-01";
    }
    else
    {
        int intmonthr = stoi(month);
        intmonthr++;
        if (intmonthr < 10)
        {
            date2 = to_string(year) + "-0" + to_string(intmonthr) + "-01";
        }
        else
        {
            date2 = to_string(year) + "-" + to_string(intmonthr) + "-01";
        }

    }

    string query = "select count(d.deal_id) Deal_Number, CONCAT(SW.First_Name, '""', SW.Last_Name) as Worker_Name from Deal d inner join store_worker SW on SW.Worker_id = d.Worker_id where d.Deal_Date >= '" + date1 + "'  AND d.Deal_Date <= '" + date2 + "' group by SW.Worker_id limit 1";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The worker that made the most deal between  " << date1 << " and " << date2 << " is: \n";
        selectQuery(res);
    }
}

void MySQL::ShowOldestCustomer()
{

    string query = " Select* from Customer c order by c.Sign_Up_Date limit 1";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);

    if (res != NULL) 
    {
        cout << "The oldest customer that signed up is : \n";
        selectQuery(res);
    }
    else 
    {
        cout << "There is not customer in DB.\n\n";
    }
}

void MySQL::ShowOrderCall14Days()
{
    string status = "in_Storge";
    string query = "select SO.Order_id, SO.Amount, SO.Order_Date, SO.Order_Status, CONCAT(c.First_Name, '""', c.Last_Name) as Customer_Name from Store_Order SO inner join Book_Copy BC on SO.Copy_id = BC.Copy_id inner join book b on b.Book_id = BC.Book_id inner join customer c on SO.customer_id = c.customer_id where SO.Order_Status = '" + status + "' and SO.Order_Date >= 14 - Day(NOW()) AND SO.Order_Date <= NOW()";
    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);

    if (res != NULL)
    {
        cout << "The customers that made order 14 days ago and we didn't call them yet are : \n";
        selectQuery(res);
    }
    else
    {
        cout << "There is not customers with open orders .\n\n";
    }
}





































void MySQL::ShowSalaryOfSpecificWorker()
{
    string FirstName;
    string LastName;
    string Month;
    string Year;
    cout << "Please enter the FIRST NAME of the costumer:\t\n";
    cin >> FirstName;
    cout << "Please enter the LAST NAME of the costumer:\t\n";
    cin >> LastName;
    cout << "Please enter Month:\t\n";
    cin >> Month;
    cout << "Please enter Year:\t\n";
    cin >> Year;

    string query = "select CONCAT(W.First_Name, '""', W.Last_Name) as Worker_Name, (W.Hourly_Salary * SW.Hours) as Bruto_Salary, SW.Month_Val As Month, SW.Year_Val As Year from store_worker W inner join Summery_Worker SW on w.Worker_id = SW.Worker_id where W.First_Name = '" + FirstName + "' and W.Last_Name = '" + LastName + "' and SW.Month_Val = '" + Month + "' and SW.Year_Val = '" + Year + "'";

    const char* Newquery = query.c_str();
    mysql_query(connect, Newquery);
    MYSQL_RES* res = mysql_store_result(connect);
    if (res != NULL)
    {
        cout << "The History of the costumer " << FirstName << LastName << "is :\n\n";
        selectQuery(res);
    }
    else
    {
        cout << "There is No costumer " << FirstName << LastName << "  in the DB.\n\n";
    }



    //select CONCAT(W.First_Name, " ", W.Last_Name) as Worker_Name, (W.Hourly_Salary * SW.Hours) as Bruto_Salary, SW.Month_Val As Month, SW.Year_Val As Year from store_worker W inner join Summery_Worker SW on w.Worker_id = SW.Worker_id where W.First_Name = '" + FirstName + "' and W.Last_Name = '" + LastName + "' and SW.Month_Val = '" + Month + "' and SW.Year_Val = '" + Year + "'
}

/**
 *--------------------------------------------------------------------
 *       Class:  MySQL
 *      Method:  MySQL :: ~MySQL()
 * Description:  Destructor of MySQL class for closing mysql
 *               connection
 *--------------------------------------------------------------------
 */
MySQL :: ~MySQL()
{
    mysql_close(connect);
}
