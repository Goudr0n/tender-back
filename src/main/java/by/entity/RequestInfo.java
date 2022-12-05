package by.entity;

public class RequestInfo {

    private String currentUserLogin;

    private int tenderId;

    private int newPrice;

    public String getCurrentUserLogin() {
        return currentUserLogin;
    }

    public void setCurrentUserLogin(String currentUserLogin) {
        this.currentUserLogin = currentUserLogin;
    }

    public int getTenderId() {
        return tenderId;
    }

    public void setTenderId(int tenderId) {
        this.tenderId = tenderId;
    }

    public int getNewPrice() {
        return newPrice;
    }

    public void setNewPrice(int newPrice) {
        this.newPrice = newPrice;
    }
}
