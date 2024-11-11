package models;

public class User {

    private String name, username, email, password, address, agreement, avatar_image;
    private int id;
    private long phno;

    //default constructor
    public User() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    //signup constructor
    public User(String name, String email, String password, String agreement, String username) {
        this.name = name;
        this.username = username;
        this.email = email;
        this.password = password;
        this.agreement = agreement;
    }

    //update user constructor
    public User(String name, String email, long phno, String address, String username) {
        this.name = name;
        this.username = username;
        this.email = email;
        this.phno = phno;
        this.address = address;
        this.username = username;
    }

    public String getName() {
        return name;
    }

    public String getAvatar_image() {
        return avatar_image;
    }

    public void setAvatar_image(String avatar_image) {
        this.avatar_image = avatar_image;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAgreement() {
        return agreement;
    }

    public void setAgreement(String agreement) {
        this.agreement = agreement;
    }

    public long getPhno() {
        return phno;
    }

    public void setPhno(long phno) {
        this.phno = phno;
    }
}
