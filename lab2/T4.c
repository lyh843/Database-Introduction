#include <stdio.h>
#include <stdlib.h>
#include <mysql.h>

void print(MYSQL_RES* result){
    MYSQL_ROW row;
    printf("%-10s %-10s %-10s\n", "employeeNo", "employeeName", "salary");
    printf("--------------------------------------------------------------\n");
    while ((row = mysql_fetch_row(result)) != NULL) {
        printf(
            "%-10s %-10s %-10s\n",
            row[0] ? row[0] : "NULL",
            row[1] ? row[1] : "NULL",
            row[2] ? row[2] : "NULL"
        );
    }
}

int main(void){
    MYSQL *conn;
    MYSQL_RES *result;

    const char *host = "127.0.0.1";
    const char *user = "lyh";
    const char *password = "123456";
    const char *database = "OrderDB";
    const unsigned int port = 3306;

    conn = mysql_init(NULL);
    mysql_real_connect(conn, host, user, password, database, port, NULL, 0);

    const char* sql1 = 
            "SELECT employeeNo, employeeName, salary "
            "FROM Employee "
            "ORDER BY salary DESC "
            "LIMIT 20";
        
    mysql_query(conn, sql1);
    result = mysql_store_result(conn);
    print(result);

    const char* sql2 = 
            "INSERT INTO Customer "
            "VALUES ('C20080002', '泰康股份有限公司', '010-5422685', '天津市', '220501')";
    
    mysql_query(conn, sql2);

    const char* sql3 =
            "DELETE FROM Employee "
            "WHERE salary > 5000";

    mysql_query(conn, sql3);
    

    const char* sql4 =
            "UPDATE Product "
            "SET productPrice = productPrice * 0.5 "
            "WHERE productPrice > 1000";
    
    mysql_query(conn, sql4);
}