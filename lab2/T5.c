#include <stdio.h>
#include <stdlib.h>
#include <mysql.h>

void print(MYSQL_RES* result){

}

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

    // 从键盘读入部门名，用它拼接后面的更新和查询语句。
    char str_department[50];
    char sql1[200];
    char sql1_test[200];
    scanf("%49s", str_department);

    // 给指定部门的员工统一加薪 200。
    snprintf(sql1, sizeof(sql1), 
            "UPDATE Employee "
            "SET salary = salary + 200 "
            "WHERE department = '%s'", str_department);

    // 查询该部门员工工资，用于加薪前后对比。
    snprintf(sql1_test, sizeof(sql1_test), 
            "SELECT employeeName, salary "
            "From Employee "
            "WHERE department = '%s'", str_department);

    mysql_query(conn, sql1_test);
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
    mysql_query(conn, sql1);
    mysql_query(conn, sql1_test);
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

    // 查询所有客户的名称、地址和电话。
    const char* sql2 = 
            "SELECT customerName, address, telephone "
            "FROM Customer";
    
    mysql_query(conn, sql2);
    result = mysql_store_result(conn);
    printf("%-10s %-10s %-10s\n", "customerName", "address", "telephone");
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
