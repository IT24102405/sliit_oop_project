package com.inventory.product;

import com.google.gson.Gson;

import java.io.*;

public final class ProductService {
    private static final String FILE = "C:\\Users\\NaveenB2004\\Desktop\\SLIIT_OOP_PROJECT\\Products.txt";
    private static Stack<Product> products;
    private static long productId = 1L;

    public static synchronized Stack<Product> getProducts() throws IOException {
        if (products != null) return products;
        products = new Stack<>(100);
        if (!new File(FILE).exists()) return products;
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE))) {
            Gson gson = new Gson();
            String line;
            while ((line = reader.readLine()) != null) {
                Product product = gson.fromJson(line, Product.class);
                products.push(product);
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
        products.push(product);
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
