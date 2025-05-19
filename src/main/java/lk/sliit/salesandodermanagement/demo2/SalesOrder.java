package lk.sliit.salesandodermanagement.demo2;

public class SalesOrder {
    private String orderId;
    private String customerName;
    private String date;
    private String item;
    private int quantity;

    public SalesOrder(String orderId, String customerName, String date, String item, int quantity) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.date = date;
        this.item = item;
        this.quantity = quantity;
    }

    // Getters and Setters
    public String getOrderId() { return orderId; }
    public String getCustomerName() { return customerName; }
    public String getDate() { return date; }
    public String getItem() { return item; }
    public int getQuantity() { return quantity; }
}

