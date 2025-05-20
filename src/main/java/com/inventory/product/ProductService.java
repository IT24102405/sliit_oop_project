package com.inventory.product;

import com.google.gson.Gson;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public final class ProductService {
    private static final String FILE = "D:/sliit_oop_project/Products.txt";
    private static List<Product> products;
    private static long productId = 1L;

    public static synchronized List<Product> getProducts() throws IOException {
        if (products != null) return products;
        products = new ArrayList<>();
        if (!new File(FILE).exists()) return products;
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE))) {
            Gson gson = new Gson();
            String line;
            while ((line = reader.readLine()) != null) {
                Product product = gson.fromJson(line, Product.class);
                products.add(product);
                productId = product.getId();
            }
            productId++;
        }
        return products;
    }

    public static Product getProduct(long id) throws IOException {
        if (products == null) getProducts();
        for (Product product : products) {
            if (product.getId() == id) {
                return product;
            }
        }
        return null;
    }

    public static void addProduct(Product product) throws IOException {
        if (products == null) getProducts();
        product.setId(productId++);
        products.add(product);
        save();
    }

    public static void updateProduct(Product product) throws IOException {
        if (products == null) getProducts();
        for (Product product1 : products) {
            if (product.getId() == product1.getId()) {
                product1.setName(product.getName());
                product1.setPrice(product.getPrice());
                product1.setVendor(product.getVendor());
                product1.setDescription(product.getDescription());
                save();
                return;
            }
        }
    }

    public static void deleteProduct(long id) throws IOException {
        if (products == null) getProducts();
        for (Product product : products) {
            if (product.getId() == id) {
                products.remove(product);
                save();
            }
        }
    }

    private static synchronized void save() throws IOException {
        if (products == null) getProducts();
        try (PrintWriter writer = new PrintWriter(FILE)) {
            Gson gson = new Gson();
            for (Product product : products) {
                writer.println(gson.toJson(product));
            }
        }
    }
}
