package responses;

public class ResponseHandler {
    private boolean success;
    private String message;
    private Object data;

    public ResponseHandler(boolean success, String message,Object data) {
        this.success = success;
        this.message = message;
        this.data = data;
    }
    
    public ResponseHandler(boolean success, String message) {
        this(success, message, null); // Calling the other constructor with null user
    }

    public boolean isSuccess() { return success; }
    public String getMessage() { return message; }
    public Object getData() { return data; }
}
