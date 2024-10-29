package responses;

import models.User;

public class ResponseHandler {
    private boolean success;
    private String message;
    private User user;

    public ResponseHandler(boolean success, String message,User user) {
        this.success = success;
        this.message = message;
        this.user = user;
    }
    
    public ResponseHandler(boolean success, String message) {
        this(success, message, null); // Calling the other constructor with null user
    }

    public boolean isSuccess() { return success; }
    public String getMessage() { return message; }
    public User getUser() { return user; }
}
