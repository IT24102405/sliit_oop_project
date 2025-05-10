package com.inventory_and_stock_management.servlets;

import com.inventory_and_stock_management.models.User;
import com.inventory_and_stock_management.utils.UserUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AddUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("AddUserServlet called"); // Debug line

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        System.out.println("Parameters received - username: " + username +
                ", email: " + email + ", role: " + role); // Debug line

        User newUser = new User(username, email, password, role);

        if (UserUtil.addUser(newUser)) {
            response.sendRedirect(request.getContextPath() + "/userManagement.jsp?message=User added successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/userManagement.jsp?error=Username already exists");
        }
    }
}
