package model;

public class ProductSpec {
    private int specId;
    private int productId;
    private String specName;
    private String specValue;

    public int getSpecId() {
        return specId;
    }
    public void setSpecId(int specId) {
        this.specId = specId;
    }
    public int getProductId() {
        return productId;
    }
    public void setProductId(int productId) {
        this.productId = productId;
    }
    public String getSpecName() {
        return specName;
    }
    public void setSpecName(String specName) {
        this.specName = specName;
    }
    public String getSpecValue() {
        return specValue;
    }
    public void setSpecValue(String specValue) {
        this.specValue = specValue;
    }

    @Override
    public String toString() {
        return "ProductSpec{" + "specId=" + specId + ", productId=" + productId + ", specName=" + specName + ", specValue=" + specValue + '}';
    }
    
    
} 