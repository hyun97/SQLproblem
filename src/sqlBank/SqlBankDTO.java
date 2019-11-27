package sqlBank;

public class SqlBankDTO {
    int quizID;
    int edit;
    int star;
    int unlike;
    String user;
    String part;
    String title;
    String question;
    String solution;
    String solution2;
    String solution3;

    public int getQuizID() {
        return quizID;
    }

    public int getEdit() {
        return edit;
    }

    public int getStar() {
        return star;
    }

    public int getUnlike() {
        return unlike;
    }

    public String getUser() {
        return user;
    }

    public String getPart() {
        return part;
    }

    public String getTitle() {
        return title;
    }

    public String getQuestion() {
        return question;
    }

    public String getSolution() {
        return solution;
    }

    public String getSolution2() {
        return solution2;
    }

    public String getSolution3() {
        return solution3;
    }

    // Get Question
    public SqlBankDTO(int quizID, int edit, int star, int unlike, String user, String part, String title,
                      String question,
                      String solution,
                      String solution2, String solution3) {
        this.quizID = quizID;
        this.edit = edit;
        this.star = star;
        this.unlike = unlike;
        this.user = user;
        this.part = part;
        this.title = title;
        this.question = question;
        this.solution = solution;
        this.solution2 = solution2;
        this.solution3 = solution3;
    }

    // Get SqlBank List
    public SqlBankDTO(int quizID, int star, String user, String part, String title) {
        this.quizID = quizID;
        this.star = star;
        this.user = user;
        this.part = part;
        this.title = title;
    }

}
