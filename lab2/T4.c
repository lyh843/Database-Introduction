#include <stdio.h>
#include <stdlib.h>
#include <mysql.h>

int main(void){
    MYSQL *conn;
    MYSQL_RES *result;
    MYSQL_ROW row;

    // MySQL 连接参数，对应本机上的 OrderDB 数据库。
    const char *host = "127.0.0.1";
    const char *user = "lyh";
    const char *password = "123456";
    const char *database = "OrderDB";
    const unsigned int port = 3306;

    conn = mysql_init(NULL);
    mysql_real_connect(conn, host, user, password, database, port, NULL, 0);

    // 查询工资最高的 20 名员工。
    const char* sql1 = 
            "SELECT employeeNo, employeeName, salary "
            "FROM Employee "
            "ORDER BY salary DESC "
            "LIMIT 20";
        
    mysql_query(conn, sql1);
    result = mysql_store_result(conn);

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

    // 插入一条客户记录，并再次查询该客户检查插入结果。
    const char* sql2 = 
            "INSERT INTO Customer "
            "VALUES ('C20080002', '泰康股份有限公司', '010-5422685', '天津市', '220501')";
    
    const char* sql2_test = 
            "SELECT * "
            "FROM Customer "
            "WHERE customerNo = 'C20080002'";

    mysql_query(conn, sql2);
    mysql_query(conn, sql2_test);
    result = mysql_store_result(conn);

    printf("%-10s %-10s %-10s %-10s %-10s\n", "customerNo", "customerName", "telephone", "address", "zip");
    printf("--------------------------------------------------------------\n");
    while ((row = mysql_fetch_row(result)) != NULL) {
        printf(
            "%-10s %-10s %-10s %-10s %-10s\n",
            row[0] ? row[0] : "NULL",
            row[1] ? row[1] : "NULL",
            row[2] ? row[2] : "NULL",
            row[3] ? row[3] : "NULL",
            row[4] ? row[4] : "NULL"
        );
    }

    // 删除工资大于 5000 的员工，删除前后各打印一次便于对比。
    const char* sql3 =
            "DELETE FROM Employee "
            "WHERE salary > 5000";

    const char* sql3_test = 
            "SELECT employeeName, salary "
            "FROM Employee";

    mysql_query(conn, sql3_test);
    result = mysql_store_result(conn);

    printf("%-10s %-10s\n", "employeeName", "salary");
    printf("--------------------------------------------------------------\n");
    while ((row = mysql_fetch_row(result)) != NULL) {
        printf(
            "%-10s %-10s\n",
            row[0] ? row[0] : "NULL",
            row[1] ? row[1] : "NULL"
        );
    }

    mysql_query(conn, sql3);
    
    mysql_query(conn, sql3_test);
    result = mysql_store_result(conn);

    printf("%-10s %-10s\n", "employeeName", "salary");
    printf("--------------------------------------------------------------\n");
    while ((row = mysql_fetch_row(result)) != NULL) {
        printf(
            "%-10s %-10s\n",
            row[0] ? row[0] : "NULL",
            row[1] ? row[1] : "NULL"
        );
    }
    

    // 将价格大于 1000 的产品打五折，更新前后各打印一次便于对比。
    const char* sql4 =
            "UPDATE Product "
            "SET productPrice = productPrice * 0.5 "
            "WHERE productPrice > 1000";
    
    const char* sql4_test = 
            "SELECT productName, productPrice "
            "FROM Product";

    mysql_query(conn, sql4_test);
    result = mysql_store_result(conn);

    printf("%-10s %-10s\n", "productName", "productPrice");
    printf("--------------------------------------------------------------\n");
    while ((row = mysql_fetch_row(result)) != NULL) {
        printf(
            "%-10s %-10s\n",
            row[0] ? row[0] : "NULL",
            row[1] ? row[1] : "NULL"
        );
    }
    mysql_query(conn, sql4);
    mysql_query(conn, sql4_test);
    result = mysql_store_result(conn);

    printf("%-10s %-10s\n", "productName", "productPrice");
    printf("--------------------------------------------------------------\n");
    while ((row = mysql_fetch_row(result)) != NULL) {
        printf(
            "%-10s %-10s\n",
            row[0] ? row[0] : "NULL",
            row[1] ? row[1] : "NULL"
        );
    }
}
