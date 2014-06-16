package Exception;

/**
 * Created by bowman on 14-6-16.
 */
public class SqliteError extends Error {
    public SqliteError(String message, Throwable cause) {
        super(message, cause);
    }
}
