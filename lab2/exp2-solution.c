#include <stdio.h>
#include <stdlib.h>
#include <mysql.h>

int main(void) {
    MYSQL *conn;
    MYSQL_RES *result;
    MYSQL_ROW row;

    const char *host = "127.0.0.1";
    const char *user = "lyh";
    const char *password = "123456";
    const char *database = "OrderDB";
    const unsigned int port = 3306;

    const char *sql =
        "SELECT productNo, productName, productPrice "
        "FROM Product "
        "ORDER BY productNo";

    // 申请一个 MYSQL 连接对象
    conn = mysql_init(NULL);
    if (conn == NULL) {
        fprintf(stderr, "mysql_init failed\n");
        return 1;
    }

    // 连接数据库
    if (mysql_real_connect(conn, host, user, password, database, port, NULL, 0) == NULL) {
        fprintf(stderr, "mysql_real_connect failed: %s\n", mysql_error(conn));
        mysql_close(conn);
        return 1;
    }

    // 执行查询
    if (mysql_query(conn, sql) != 0) {
        fprintf(stderr, "query failed: %s\n", mysql_error(conn));
        mysql_close(conn);
        return 1;
    }

    // 获取结果
    result = mysql_store_result(conn);
    if (result == NULL) {
        fprintf(stderr, "mysql_store_result failed: %s\n", mysql_error(conn));
        mysql_close(conn);
        return 1;
    }

    printf("%-12s %-30s %-10s\n", "productNo", "productName", "productPrice");
    printf("--------------------------------------------------------------\n");

    // 逐行打印
    while ((row = mysql_fetch_row(result)) != NULL) {
        printf(
            "%-12s %-30s %-10s\n",
            row[0] ? row[0] : "NULL",
            row[1] ? row[1] : "NULL",
            row[2] ? row[2] : "NULL"
        );
    }

    mysql_free_result(result);
    mysql_close(conn);
    return 0;
}
