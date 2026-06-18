package kr.ac.dy.cs.util;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class H2DbConnector implements Connector, FileConnector {

    public void hello() {
        System.out.println("Hello!!");
    }

    @Override
    public Connection getConnection() {

        try {
            // H2 드라이버 로드
            Class.forName("org.h2.Driver");

            // DB 경로
            String url = "jdbc:h2:C:\\Users\\214\\Desktop\\shoppingmall-backoffice\\db\\shopingmall";

            String dbUser = "sa";
            String dbPassword = "";

            return DriverManager.getConnection(url, dbUser, dbPassword);

        } catch (Exception e) {

            throw new RuntimeException("H2 DB 연결 실패", e);
        }
    }

    @Override
    public void closeConnection(Connection connection) {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public File loadFile() {
        return null;
    }
}