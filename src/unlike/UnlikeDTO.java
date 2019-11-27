package unlike;

public class UnlikeDTO {
    String userIP;
    int quizID;

    public String getUserID() {
        return userIP;
    }

    public int getQuizID() {
        return quizID;
    }

    public UnlikeDTO(String userIP, int quizID) {
        this.userIP = userIP;
        this.quizID = quizID;
    }
}
