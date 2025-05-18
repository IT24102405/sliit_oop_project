package com.inventory.dao;

import com.inventory.model.Product;
import java.io.*;
import java.util.*;
import java.util.stream.Collectors;

public class ProductDAOImpl implements ProductDAO {
    private static final String DATA_FILE = "products.dat";
    private List<Product> products;

    public ProductDAOImpl() {
        products = loadProducts();
    }

    private synchronized List<Product> loadProducts() {
        File file = new File(DATA_FILE);
        if (!file.exists()) {
            return new ArrayList<>();
        }

        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file))) {
            return (List<Product>) ois.readObject();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    private synchronized void saveProducts() {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(DATA_FILE))) {
            oos.writeObject(products);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public synchronized void createProduct(Product product) {
        product.setId(generateId());
        products.add(product);
        saveProducts();
    }

    @Override
    public Product getProduct(Long id) {
        return products.stream()
                .filter(p -> p.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    @Override
    public List<Product> getAllProducts() {
        return new ArrayList<>(products);
    }

    @Override
    public List<Product> getProductsByCategory(String category) {
        return products.stream()
                .filter(p -> p.getCategory().equalsIgnoreCase(category))
                .collect(Collectors.toList());
    }

    @Override
    public synchronized void updateProduct(Product product) {
        for (int i = 0; i < products.size(); i++) {
            if (products.get(i).getId().equals(product.getId())) {
                products.set(i, product);
                saveProducts();
                break;
            }
        }
    }

    @Override
    public synchronized void deleteProduct(Long id) {
        products.removeIf(p -> p.getId().equals(id));
        saveProducts();
    }

    @Override
    public List<Product> searchProducts(String keyword) {
        keyword = keyword.toLowerCase();
        String finalKeyword = keyword;
        return products.stream()
                .filter(p -> p.getName().toLowerCase().contains(finalKeyword) ||
                           p.getDescription().toLowerCase().contains(finalKeyword) ||
                           p.getCategory().toLowerCase().contains(finalKeyword))
                .collect(Collectors.toList());
    }

    @Override
    public List<Product> getLowStockProducts(int threshold) {
        return products.stream()
                .filter(p -> p.getQuantity() <= threshold)
                .collect(Collectors.toList());
    }

    private Long generateId() {
        return products.stream()
                .mapToLong(Product::getId)
                .max()
                .orElse(0) + 1;
    }
}
