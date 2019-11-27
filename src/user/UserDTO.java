package user;

public class UserDTO {
    String name;
    String password;
    String email;
    int email_verify;

    public String getName() {
        return name;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public int getEmail_verify() {
        return email_verify;
    }

    public UserDTO(String name, String password, String email, int email_verify) {
        this.name = name;
        this.password = password;
        this.email = email;
        this.email_verify = email_verify;
    }
}
