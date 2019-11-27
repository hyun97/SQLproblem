package star;

public class StarDTO {
    String userIP;
    int quizID;

    public String getUserID() {
        return userIP;
    }

    public int getQuizID() {
        return quizID;
    }

    public StarDTO(String userIP, int quizID) {
        this.userIP = userIP;
        this.quizID = quizID;
    }
}
