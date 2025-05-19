package lk.sliit.salesandodermanagement.demo2;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

@WebServlet("/create-order")
public class CreateOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String orderId = request.getParameter("orderId");
            String customerName = request.getParameter("customerName");
            String date = request.getParameter("date");
            String item = request.getParameter("item");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            SalesOrder order = new SalesOrder(orderId, customerName, date, item, quantity);
            OrderService service = new OrderService(getServletContext());
            service.saveOrder(order);

            response.sendRedirect("view-orders");
        } catch (Exception e) {
            request.setAttribute("error", "Error creating order: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}

