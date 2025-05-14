package com.inventory_and_stock_management.utils;

import com.inventory_and_stock_management.models.User;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserUtil {
    private static final String FILE_PATH = "users.txt" ;

    public static List<User> readUsers() {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 4) {
                    users.add(new User(parts[0], parts[1], parts[2], parts[3]));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return users;
    }

    public static void writeUsers(List<User> users) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (User user : users) {
                writer.write(user.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static User findUserByUsername(String username) {
        List<User> users = readUsers();
        for (User user : users) {
            if (user.getUsername().equals(username)) {
                return user;
            }
        }
        return null;
    }

    public static boolean addUser(User newUser) {
        System.out.println("Attempting to add user: " + newUser.getUsername()); // Debug line

        List<User> users = readUsers();
        for (User user : users) {
            if (user.getUsername().equals(newUser.getUsername())) {
                System.out.println("Username already exists: " + newUser.getUsername());
                return false;
            }
        }
        users.add(newUser);
        writeUsers(users);
        System.out.println("User added successfully: " + newUser.getUsername());
        return true;
    }

    public static boolean updateUser(User updatedUser) {
        List<User> users = readUsers();
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getUsername().equals(updatedUser.getUsername())) {
                users.set(i, updatedUser);
                writeUsers(users);
                return true;
            }
        }
        return false;
    }

    public static boolean deleteUser(String username) {
        List<User> users = readUsers();
        boolean removed = users.removeIf(user -> user.getUsername().equals(username));
        if (removed) {
            writeUsers(users);
        }
        return removed;
    }
}
//rfgh