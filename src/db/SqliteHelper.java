package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import Exception.SqliteError;
/**
 * Created by bowman on 14-5-21.
 */
public class SqliteHelper {
    private static Connection c = null;
    private static String DB_PATH = null;

    static {
        // Get database path - use system property or default to current directory
        String dbPath = System.getProperty("db.path");
        if (dbPath == null || dbPath.isEmpty()) {
            // Default to project root or user home directory
            String userHome = System.getProperty("user.home");
            DB_PATH = userHome + "/guestbook.db";
        } else {
            DB_PATH = dbPath;
        }
        System.out.println("Using database at: " + DB_PATH);
    }

    public static Connection getConn() throws SqliteError {
        try{
        if(c == null){
        Class.forName("org.sqlite.JDBC");
        c = DriverManager.getConnection("jdbc:sqlite:" + DB_PATH);
        }
        if(c.isClosed())
            c = DriverManager.getConnection("jdbc:sqlite:" + DB_PATH);
        }catch (Exception e){
            throw new SqliteError("No slqlite driver found",e);
        }
        return c;
    }

    public static void createTables() throws Exception {
        Connection c = null;
        Statement stmt = null;

        c = SqliteHelper.getConn();
        stmt = c.createStatement();
        stmt.executeUpdate(sqlCreateUser);
        stmt.close();
        stmt = c.createStatement();
        stmt.executeUpdate(sqlCreateNote);
        stmt.close();

        c.close();

        System.out.println("Table created successfully");
    }
    public static void DropAll()  {
        Connection c = null;
        Statement stmt = null;


        try{
        c = SqliteHelper.getConn();
        stmt = c.createStatement();
        stmt.execute(sqlDrop + sqlTableNote);
        stmt.execute(sqlDrop + sqlTableUser);
            stmt.close();
            c.close();
        }catch (SQLException e){
            e.printStackTrace();
            System.out.println("the table does not exists");
        }catch (Exception e){
            e.printStackTrace();

        }



    }
    public static final String sqlTableUser = "USER";
    public static final String sqlTableNote = "NOTE";
    public static final String sqlDrop = "DROP TABLE ";
    public static final String sqlCreateUser = "CREATE TABLE USER " +
            "(ID INTEGER PRIMARY KEY      AUTOINCREMENT ," +
            " EMAIL           TEXT    NOT NULL, " +
            " PASSWORD            TEXT     NOT NULL) ";

    public static final String sqlCreateNote = "CREATE TABLE NOTE " +
            "(ID INTEGER PRIMARY KEY     AUTOINCREMENT ," +
            " USERID           INT    NOT NULL, " +
            " TITLE            TEXT            , " +
            " CONTENT           TEXT   NOT NULL)";


}
