package com.inventory_and_stock_management.utils;

import com.inventory_and_stock_management.models.Supplier;

import java.io.*;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletContext;

/**
 * Utility class for handling file operations related to suppliers.
 */
public class FileHandler {
    private static final String SUPPLIERS_FILE = "/WEB-INF/data/suppliers.txt";

    /**
     * Reads all suppliers from the file.
     *
     * @param context ServletContext to get the real path
     * @return List of Supplier objects
     */
    public static List<Supplier> readAllSuppliers(ServletContext context) {
        List<Supplier> suppliers = new ArrayList<>();
        String filePath = context.getRealPath(SUPPLIERS_FILE);
        File file = new File(filePath);

        // Create the file if it doesn't exist
        if (!file.exists()) {
            try {
                // Ensure directory exists
                File parentDir = file.getParentFile();
                if (!parentDir.exists()) {
                    parentDir.mkdirs();
                }
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return suppliers; // Return empty list
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Supplier supplier = Supplier.fromFileString(line);
                if (supplier != null) {
                    suppliers.add(supplier);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return suppliers;
    }

    /**
     * Saves a list of suppliers to the file.
     *
     * @param context ServletContext to get the real path
     * @param suppliers List of Supplier objects to save
     * @return true if successful, false otherwise
     */
    public static boolean saveAllSuppliers(ServletContext context, List<Supplier> suppliers) {
        String filePath = context.getRealPath(SUPPLIERS_FILE);
        File file = new File(filePath);

        // Create the file if it doesn't exist
        if (!file.exists()) {
            try {
                // Ensure directory exists
                File parentDir = file.getParentFile();
                if (!parentDir.exists()) {
                    parentDir.mkdirs();
                }
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (Supplier supplier : suppliers) {
                writer.write(supplier.toFileString());
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Adds a new supplier to the file.
     *
     * @param context ServletContext to get the real path
     * @param supplier Supplier object to add
     * @return true if successful, false otherwise
     */
    public static boolean addSupplier(ServletContext context, Supplier supplier) {
        List<Supplier> suppliers = readAllSuppliers(context);

        // Generate a unique ID if not provided
        if (supplier.getId() == null || supplier.getId().isEmpty()) {
            supplier.setId(UUID.randomUUID().toString().substring(0, 8));
        }

        suppliers.add(supplier);
        return saveAllSuppliers(context, suppliers);
    }

    /**
     * Updates an existing supplier in the file.
     *
     * @param context ServletContext to get the real path
     * @param supplier Supplier object with updated information
     * @return true if successful, false otherwise
     */
    public static boolean updateSupplier(ServletContext context, Supplier supplier) {
        List<Supplier> suppliers = readAllSuppliers(context);
        boolean found = false;

        for (int i = 0; i < suppliers.size(); i++) {
            if (suppliers.get(i).getId().equals(supplier.getId())) {
                suppliers.set(i, supplier);
                found = true;
                break;
            }
        }

        if (found) {
            return saveAllSuppliers(context, suppliers);
        }
        return false;
    }

    /**
     * Deletes a supplier from the file.
     *
     * @param context ServletContext to get the real path
     * @param id ID of the supplier to delete
     * @return true if successful, false otherwise
     */
    public static boolean deleteSupplier(ServletContext context, String id) {
        List<Supplier> suppliers = readAllSuppliers(context);
        boolean removed = suppliers.removeIf(s -> s.getId().equals(id));

        if (removed) {
            return saveAllSuppliers(context, suppliers);
        }
        return false;
    }

    /**
     * Finds a supplier by ID.
     *
     * @param context ServletContext to get the real path
     * @param id ID of the supplier to find
     * @return Supplier object if found, null otherwise
     */
    public static Supplier findSupplierById(ServletContext context, String id) {
        List<Supplier> suppliers = readAllSuppliers(context);

        for (Supplier supplier : suppliers) {
            if (supplier.getId().equals(id)) {
                return supplier;
            }
        }

        return null;
    }
}