package db;

import model.Note;
import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Created by bowman on 14-5-21.
 */
public class DAO {

    public DAO() {
    }

    public User createUser(String email, String password) {
        PreparedStatement ps;
        ResultSet rs;
        User user = new User();

        try {
            Connection c = SqliteHelper.getConn();
            ps = c.prepareStatement("INSERT INTO USER (EMAIL,PASSWORD) VALUES (?,?)");
            ps.setString(1, email);
            ps.setString(2, password);
            ps.executeUpdate();
            c.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        user.setEmail(email);
        user.setPassword(password);
        return user;
    }

    public User validateUser(String email, String password) {
        PreparedStatement ps;
        ResultSet rs;
        User user = null;
        try {
            Connection c = SqliteHelper.getConn();
            ps = c.prepareStatement("SELECT * FROM USER WHERE email like ? AND password LIKE ?");
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt(1));
                user.setEmail(rs.getString(2));
                user.setPassword(rs.getString(3));
            }
            c.close();


        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    public boolean hasUser(String email) {
        PreparedStatement ps;
        ResultSet rs;

        try {
            Connection c = SqliteHelper.getConn();
            ps = c.prepareStatement("SELECT * FROM USER WHERE email=? ");
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                c.close();
                return true;
            }
            c.close();
            return false;


        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }


    }
    public int addNote(int userId,String Note){
        int id;
        try{
            Connection c = SqliteHelper.getConn();


            PreparedStatement ps = c.prepareStatement("INSERT INTO NOTE (USERID, CONTENT) VALUES(?,?)");
            ps.setInt(1, userId);
            ps.setString(2,Note);
            int n = ps.executeUpdate();

            c.close();
            return n;
        }catch (SQLException e){
            e.printStackTrace();
        }
        return 0;


    }
    public int addNote(String email,String Note){
        int id;
        try{
            Connection c = SqliteHelper.getConn();
            PreparedStatement ps = c.prepareStatement("SELECT id FROM USER WHERE EMAIL=?");
            ps.setString(1,email);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                id = rs.getInt(1);
            }else
                return 0;
            ps = c.prepareStatement("INSERT INTO NOTE (USERID, CONTENT) VALUES(?,?)");
            ps.setInt(1, id);
            ps.setString(2,Note);
            int n = ps.executeUpdate();

            c.close();
            return n;
        }catch (SQLException e){
            e.printStackTrace();
        }
        return 0;


    }
    public ArrayList<Note> getNotes() {
        ArrayList<Note> notes = new ArrayList<Note>();
        Note n = null;

        try {
            Connection c = SqliteHelper.getConn();
            PreparedStatement ps = c.prepareStatement("SELECT * FROM NOTE");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                n = new Note();
                n.setId(rs.getInt(1));
                n.setUserid(rs.getInt(2));
                n.setTitle(rs.getString(3));
                n.setContent(rs.getString(4));
                notes.add(n);
            }
            c.close();
            return notes;

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
