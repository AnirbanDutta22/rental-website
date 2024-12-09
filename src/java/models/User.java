package models;

public class User {

    private String name, username, email, password, address,district,state, agreement, avatar_image,cover_image;
    private int id,pin;
    private long phno;
    private boolean isVerified;

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
    public User(int id, String name, String email, long phno, String address,String district,String state, int pin,boolean isVerified,  String username) {
        this.id = id;
        this.name = name;
        this.username = username;
        this.email = email;
        this.phno = phno;
        this.address = address;
        this.district = district;
        this.state = state;
        this.pin = pin;
        this.username = username;
        this.isVerified = isVerified;
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
    
    public String getCover_image() {
        return cover_image;
    }

    public void setCover_image(String cover_image) {
        this.cover_image = cover_image;
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

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public int getPin() {
        return pin;
    }

    public void setPin(int pin) {
        this.pin = pin;
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
    
    public boolean isIsVerified() {
        return isVerified;
    }

    public void setIsVerified(boolean isVerified) {
        this.isVerified = isVerified;
    }
}
