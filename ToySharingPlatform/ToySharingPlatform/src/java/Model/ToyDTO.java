package Model;

import java.sql.Timestamp;

public class ToyDTO {

    private int toyID;
    private String toyName;
    private String description;
    private String imageURL;
    private String condition;
    private Timestamp postDate;
    private String status;
    private String ownerID;
    private int categoryID;

    // Thêm các trường phụ để hiển thị
    private String ownerName;
    private String categoryName;

    public ToyDTO() {
    }

    public ToyDTO(int toyID, String toyName, String description, String imageURL,
            String condition, Timestamp postDate, String status,
            String ownerID, int categoryID) {
        this.toyID = toyID;
        this.toyName = toyName;
        this.description = description;
        this.imageURL = imageURL;
        this.condition = condition;
        this.postDate = postDate;
        this.status = status;
        this.ownerID = ownerID;
        this.categoryID = categoryID;
    }

    public int getToyID() {
        return toyID;
    }

    public void setToyID(int toyID) {
        this.toyID = toyID;
    }

    public String getToyName() {
        return toyName;
    }

    public void setToyName(String toyName) {
        this.toyName = toyName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public Timestamp getPostDate() {
        return postDate;
    }

    public void setPostDate(Timestamp postDate) {
        this.postDate = postDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOwnerID() {
        return ownerID;
    }

    public void setOwnerID(String ownerID) {
        this.ownerID = ownerID;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}
