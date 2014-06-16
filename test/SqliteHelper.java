import junit.framework.TestCase;

import java.sql.Connection;

/**
 * Created by bowman on 14-5-21.
 */
public class SqliteHelper extends TestCase {
    public void testGetConn() throws Error {
        Connection c = null;
        try {
            c = db.SqliteHelper.getConn();
        } catch (Exception e) {
            e.printStackTrace();
            assert (false);
        }
        assert (c != null);

    }

    public void testCreateTables() throws Exception {
        try {
            db.SqliteHelper.createTables();
        } catch (Exception e) {
            e.printStackTrace();
            assert (false);
        }
    }



    @Override
    public void setUp() throws Exception {
        db.SqliteHelper.DropAll();
    }
}