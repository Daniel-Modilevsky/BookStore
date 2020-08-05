/*
 * ===================================================================
 *
 *       Filename:  database.h
 *
 *    Description:  Declaring MySQL class for using database.
 *
 *        Created:  Friday 22 February 2013 12:48:40  IST
 *       Compiler:  gcc
 *
 *         Author:  Mandeep Kaur, meghasimak@gmail.com
 *        License:  GNU General Public License
 *      Copyright:  Copyright (c) 2013, Great Developers
 *
 * ===================================================================
 */

 /**-------------------------------------------------------------------
  *  Include database-detail.h and other files
  *------------------------------------------------------------------*/


#include <iostream>
#include <mysql.h>

  /**
   * ===================================================================
   *        Class:  MySQL
   *  Description:  MySQL class for database accessability
   * ===================================================================
   */
using namespace std;
class MySQL
{
protected:
    /** MySQL connectivity Variables */
    MYSQL* connect;
    MYSQL_RES* res_set;
    MYSQL_ROW row;
    MYSQL_FIELD* filed;

    unsigned int i;

public:
    /** MySQL Constructor */
    MySQL();

    /** Function to show tables in database */
    void ShowTables();

    void selectQuery(MYSQL_RES* res);

    int CheckUserNameAndPass(string user_name, string pass);

    /**1. Inventory Functions*/

    bool IsBookExist();

    void ShowOldestBook();

    void ShowMostTrasnaltionsBook();

    void ShowTheAmountOfBooksThatTheStoreBought();

    void ShowStoreProfit();

    /**2. Delivery Functions*/

    void CalcDelivery();

    void DeliveryStatus();

    void ShowShipmentAmountByExpress();

    void ShowHowMuchDeliveriesByIsraelPostAndExpress();

    void ShowAllDeliveriesWithAtLeast2Copies();

    /**3. Deals Functions*/

    void ShowHowManyBookSold();

    void ShowMostPopularAuthor();

    void ShowTopThreeCostumers();

    void ShowHistoryOfSpecificCostumer();

    void IsCostumerSplitedDeal();

    void ShowSumOfBitInSpecificMonth();

    void ShowTheMostProfitableDealsInTheLast12Months();

    void ShowAllCostumers();

    void ShowAverageDealsInYear();

    void ShowTheWorkerWithTheMostDeals();

    /** 4. Customers Functions*/
    void ShowOldestCustomer();

    void ShowOrderCall14Days();

    /**5. Orders Functions*/

    void ShowOrderList();

    void ShowHistoryOfOrders();

    /**6. Workers Functions*/

    void ShowSalaryOfSpecificWorker();

    /** MySQL Destructor */
    ~MySQL();
};
