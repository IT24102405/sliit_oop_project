package lk.sliit.salesandodermanagement.demo2;


import lk.sliit.salesandodermanagement.demo2.SalesOrder;
import jakarta.servlet.ServletContext;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.nio.file.*;

public class OrderService {
    private final String ordersFilePath;
    private final String tempFilePath;

    public OrderService(ServletContext context) throws IOException {
        if (context == null) {
            // Fallback to a default location if ServletContext is not available
            String userHome = System.getProperty("user.home");
            String dataDir = Paths.get(userHome, "salesapp_data").toString();
            createDirectory(dataDir);
            this.ordersFilePath = Paths.get(dataDir, "orders.txt").toString();
            this.tempFilePath = Paths.get(dataDir, "temp_orders.txt").toString();
        } else {
            // Use WEB-INF/data directory
            String dataDir = context.getRealPath("/WEB-INF/data");
            if (dataDir == null) {
                throw new IOException("Could not resolve /WEB-INF/data directory");
            }
            createDirectory(dataDir);
            this.ordersFilePath = Paths.get(dataDir, "orders.txt").toString();
            this.tempFilePath = Paths.get(dataDir, "temp_orders.txt").toString();
        }
        
        // Ensure the orders file exists
        createFileIfNotExists(ordersFilePath);
    }

    private void createDirectory(String dirPath) throws IOException {
        Path path = Paths.get(dirPath);
        if (!Files.exists(path)) {
            Files.createDirectories(path);
        }
    }

    private void createFileIfNotExists(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        if (!Files.exists(path)) {
            Files.createFile(path);
        }
    }

    // Save a new sales order to the orders.txt file
    public void saveOrder(SalesOrder order) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ordersFilePath, true))) {
            writer.write(String.format("%s,%s,%s,%s,%d",
                order.getOrderId(),
                order.getCustomerName(),
                order.getDate(),
                order.getItem(),
                order.getQuantity()));
            writer.newLine();
        }
    }

    // Read and return all sales orders from the file
    public List<SalesOrder> getAllOrders() throws IOException {
        List<SalesOrder> orders = new ArrayList<>();
        Path path = Paths.get(ordersFilePath);
        
        if (!Files.exists(path)) {
            return orders;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(ordersFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 5) {
                    try {
                        orders.add(new SalesOrder(
                            parts[0], parts[1], parts[2], parts[3], Integer.parseInt(parts[4])
                        ));
                    } catch (NumberFormatException e) {
                        // Log the error but continue processing other records
                        System.err.println("Invalid quantity format in line: " + line);
                    }
                }
            }
        }
        return orders;
    }

    // Delete an order by orderId
    public void deleteOrder(String orderId) throws IOException {
        Path inputPath = Paths.get(ordersFilePath);
        Path tempPath = Paths.get(tempFilePath);

        if (!Files.exists(inputPath)) {
            throw new FileNotFoundException("Orders file not found");
        }

        boolean found = false;
        List<String> remainingLines = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(ordersFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.startsWith(orderId + ",")) {
                    remainingLines.add(line);
                } else {
                    found = true;
                }
            }
        }

        if (!found) {
            throw new IOException("Order ID not found: " + orderId);
        }

        // Write the remaining lines back to the original file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ordersFilePath))) {
            for (String line : remainingLines) {
                writer.write(line);
                writer.newLine();
            }
        }
    }

    public void updateOrder(SalesOrder updatedOrder) throws IOException {
        Path inputPath = Paths.get(ordersFilePath);
        Path tempPath = Paths.get(tempFilePath);

        if (!Files.exists(inputPath)) {
            throw new FileNotFoundException("Orders file not found");
        }

        boolean found = false;
        List<String> updatedLines = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(ordersFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.startsWith(updatedOrder.getOrderId() + ",")) {
                    // Replace the line with the updated order
                    String updatedLine = String.format("%s,%s,%s,%s,%d",
                            updatedOrder.getOrderId(),
                            updatedOrder.getCustomerName(),
                            updatedOrder.getDate(),
                            updatedOrder.getItem(),
                            updatedOrder.getQuantity());
                    updatedLines.add(updatedLine);
                    found = true;
                } else {
                    updatedLines.add(line);
                }
            }
        }

        if (!found) {
            throw new IOException("Order ID not found: " + updatedOrder.getOrderId());
        }

        // Write all lines back to the original file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ordersFilePath))) {
            for (String line : updatedLines) {
                writer.write(line);
                writer.newLine();
            }
        }
    }

    public SalesOrder getOrderById(String orderId) throws IOException {
        Path path = Paths.get(ordersFilePath);

        if (!Files.exists(path)) {
            throw new FileNotFoundException("Orders file not found");
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(ordersFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 5 && parts[0].equals(orderId)) {
                    try {
                        return new SalesOrder(parts[0], parts[1], parts[2], parts[3], Integer.parseInt(parts[4]));
                    } catch (NumberFormatException e) {
                        System.err.println("Invalid quantity format for order ID: " + orderId);
                        return null;
                    }
                }
            }
        }

        // Return null if order not found
        return null;
    }
}
