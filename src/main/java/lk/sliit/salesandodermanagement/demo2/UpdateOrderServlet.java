package lk.sliit.salesandodermanagement.demo2;



import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/update-order")
public class UpdateOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String orderId = request.getParameter("orderId");
        String customerName = request.getParameter("customerName");
        String date = request.getParameter("date");
        String item = request.getParameter("item");
        String quantityStr = request.getParameter("quantity");

        try {
            int quantity = Integer.parseInt(quantityStr);

            SalesOrder updatedOrder = new SalesOrder(orderId, customerName, date, item, quantity);
            OrderService orderService = new OrderService(getServletContext());
            orderService.updateOrder(updatedOrder);

            response.sendRedirect("view-orders"); // or wherever you list orders
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid quantity format.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (IOException e) {
            request.setAttribute("error", "Error updating order: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}

