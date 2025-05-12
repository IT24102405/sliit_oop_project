package com.inventory_and_stock_management.servlets;

import com.inventory_and_stock_management.models.User;
import com.inventory_and_stock_management.utils.UserUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = UserUtil.findUserByUsername(username);

        if (user != null && user.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("admin".equals(user.getRole())) {
                response.sendRedirect("userManagement.jsp");
            } else {
                response.sendRedirect("userDashboard.jsp");
            }
        } else {
            response.sendRedirect("index.jsp?error=Invalid username or password");
        }
    }
}

//dfghj