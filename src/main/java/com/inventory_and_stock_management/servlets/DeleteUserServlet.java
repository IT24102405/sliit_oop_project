package com.inventory_and_stock_management.servlets;

import com.inventory_and_stock_management.utils.UserUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");

        if (UserUtil.deleteUser(username)) {
            response.sendRedirect("userManagement.jsp?message=User deleted successfully");
        } else {
            response.sendRedirect("userManagement.jsp?error=Failed to delete user");
        }
    }
}
