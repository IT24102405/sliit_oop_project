package com.inventory.dao;

import com.inventory.model.Product;
import java.util.List;

public interface ProductDAO {
    void createProduct(Product product);
    Product getProduct(Long id);
    List<Product> getAllProducts();
    List<Product> getProductsByCategory(String category);
    void updateProduct(Product product);
    void deleteProduct(Long id);
    List<Product> searchProducts(String keyword);
    List<Product> getLowStockProducts(int threshold);
}
