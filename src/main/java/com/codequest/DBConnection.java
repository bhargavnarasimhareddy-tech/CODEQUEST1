
package com.codequest;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = System.getenv().getOrDefault(
        "CODEQUEST_DB_URL", "jdbc:mysql://localhost:3306/codequest_db");
    private static final String USER = System.getenv().getOrDefault(
        "CODEQUEST_DB_USER", "root");
    private static final String PASSWORD = System.getenv().getOrDefault(
        "CODEQUEST_DB_PASSWORD", "root");

    public static Connection getConnection() throws java.sql.SQLException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new java.sql.SQLException("MySQL JDBC driver is missing", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
