
package com.codequest;

import java.sql.Connection;

public class DBTest {

    public static void main(String[] args) throws Exception {
        try (Connection con = DBConnection.getConnection()) {
            System.out.println("CODEQUEST DATABASE CONNECTED!");
        }
    }
}
