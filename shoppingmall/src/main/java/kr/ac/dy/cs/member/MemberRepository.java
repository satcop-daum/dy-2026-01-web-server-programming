package kr.ac.dy.cs.member;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * member테이블 데이터 처리
 */
public class MemberRepository {

    /**
     * member테이블 insert
     */
    public int insert(MemberDto member) {

        //DB에 insert

        //Driver로딩

        int affected = 0;
        try {
            Class.forName("org.h2.Driver");

            String url = "jdbc:h2:C:\\Work\\web0508\\shopingmall";
            String dbUser = "sa";
            String dbPassword = "";
            Connection connection = DriverManager.getConnection(url, dbUser, dbPassword);

            String sql = " insert into member (id, name, email, password, reg_date) values (?, ?, ?, ?, now()) ";
            PreparedStatement psmt = connection.prepareStatement(sql);
            psmt.setString(1, member.getUserId());
            psmt.setString(2, member.getUserName());
            psmt.setString(3, member.getEmail());
            psmt.setString(4, member.getPassword());
            affected = psmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return affected;
    }

}
