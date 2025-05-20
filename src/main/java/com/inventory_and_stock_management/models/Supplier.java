package com.inventory_and_stock_management.models;

import java.io.Serializable;

/**
 * Represents a supplier in the Inventory and Stock Management System.
 * This class implements the CRUD operations for supplier management.
 */
public class Supplier implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;
    private String name;
    private String company;
    private String phone;
    private String email;
    private String address;

    // Default constructor
    public Supplier() {
    }

    // Parameterized constructor
    public Supplier(String id, String name, String company, String phone, String email, String address) {
        this.id = id;
        this.name = name;
        this.company = company;
        this.phone = phone;
        this.email = email;
        this.address = address;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * Converts a supplier object to a string representation for file storage.
     * Format: id|name|company|phone|email|address
     *
     * @return String representation of the supplier
     */
    public String toFileString() {
        return String.join("|", id, name, company, phone, email, address);
    }

    /**
     * Creates a Supplier object from a string representation from file.
     *
     * @param line String representation from file
     * @return Supplier object
     */
    public static Supplier fromFileString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 6) {
            return new Supplier(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]);
        }
        return null;
    }

    @Override
    public String toString() {
        return "Supplier{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", company='" + company + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}