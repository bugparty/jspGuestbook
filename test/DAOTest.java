import db.*;
import junit.framework.TestCase;
import model.Note;
import model.User;

import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Created by bowman on 14-6-15.
 */
public class DAOTest extends TestCase {
    private DAO mDAO;

    @Override
    public void setUp() throws Exception {
        try{
        db.SqliteHelper.createTables();}
        catch (SQLException e){

            System.out.println("DAOTest.setUp:" + e.getMessage());
        }
        mDAO = new DAO();
    }

    public void testCreateUser() throws Exception{
        String user = "bowman12333123";
        String pass = "pass";
        User u = mDAO.createUser(user,pass);
        assert(u!= null);
    }
    public void testQueryUser() throws Exception {
        String user = "bowman123123";
        String pass = "pass";
        User u = mDAO.createUser(user,pass);
        u = mDAO.validateUser(user, pass);
        assert(u!= null);
        System.out.println("email:"+u.getEmail()+"pass:"+u.getPassword());
        assert (u.getEmail().equals(user));

    }

    public void testAddNote() throws Exception {
        String user = "bowmanAddNote";
        String note = "hello";
        User u = mDAO.createUser(user,"123");
        assert(mDAO.addNote(user,note)!=0);

    }

    public void testGetNotes() throws Exception {
        ArrayList<Note> notes = mDAO.getNotes();
        assert(notes != null);

    }

}
