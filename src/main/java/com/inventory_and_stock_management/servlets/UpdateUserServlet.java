package com.inventory_and_stock_management.servlets;

import com.inventory_and_stock_management.models.User;
import com.inventory_and_stock_management.utils.UserUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class UpdateUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("UpdateUserServlet reached!");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User existingUser = UserUtil.findUserByUsername(username);
        if (existingUser == null) {
            response.sendRedirect("userManagement.jsp?error=User not found");
            return;
        }

        // Update user details
        existingUser.setEmail(email);
        existingUser.setRole(role);

        // Only update password if a new one was provided
        if (password != null && !password.isEmpty()) {
            existingUser.setPassword(password);
        }

        if (UserUtil.updateUser(existingUser)) {
            response.sendRedirect("userManagement.jsp?message=User updated successfully");
        } else {
            response.sendRedirect("userManagement.jsp?error=Failed to update user");
        }
    }
}
//sdfghjk