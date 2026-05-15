#include <stdio.h>
#include <stdlib.h>
#include <mysql.h>

void print(MYSQL_RES* result){
    MYSQL_ROW row;
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

    char str_department[50];
    char sql1[200];
    scanf("%49s", str_department);

    snprintf(sql1, sizeof(sql1), 
            "UPDATE Employee "
            "SET salary = salary + 200 "
            "WHERE department = '%s'", str_department);

    mysql_query(conn, sql1);

    const char* sql2 = 
            "SELECT customerName, address, telephone "
            "FROM Customer";
    
    mysql_query(conn, sql2);
    result = mysql_store_result(conn);
    print(result);
}