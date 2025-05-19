package lk.sliit.salesandodermanagement.demo2;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

@WebServlet("/delete-order")
public class DeleteOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String orderId = request.getParameter("orderId");
            OrderService service = new OrderService(getServletContext());
            service.deleteOrder(orderId);
            response.sendRedirect("view-orders");
        } catch (Exception e) {
            request.setAttribute("error", "Error deleting order: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}
