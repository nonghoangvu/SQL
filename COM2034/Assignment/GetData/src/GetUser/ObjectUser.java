package GetUser;

public class ObjectUser {
    private String name;
    private String gender;
    private String address;
    private String quan;
    private String sdt;
    private String email;

    public ObjectUser(String name, String gender, String address, String quan, String sdt, String email) {
        this.name = name;
        this.gender = gender;
        this.address = address;
        this.quan = quan;
        this.sdt = sdt;
        this.email = email;
    }

    public ObjectUser() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getQuan() {
        return quan;
    }

    public void setQuan(String quan) {
        this.quan = quan;
    }

    public String getSdt() {
        return sdt;
    }

    public void setSdt(String sdt) {
        this.sdt = sdt;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}
