package com.inventory_and_stock_management.servlets;

import com.inventory_and_stock_management.models.User;
import com.inventory_and_stock_management.utils.UserUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;


public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=Passwords do not match.");
            return;
        }

        User newUser = new User(username, email, password, "user"); // Default role is "user"

        if (UserUtil.addUser(newUser)) {
            response.sendRedirect("index.jsp?message=Registration successful, please login.");
        } else {
            response.sendRedirect("register.jsp?error=Username already exists.");
        }
    }
}





