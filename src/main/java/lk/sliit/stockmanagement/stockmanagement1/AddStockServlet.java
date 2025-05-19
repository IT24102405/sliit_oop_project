package lk.sliit.stockmanagement.stockmanagement1;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/addStock")
public class AddStockServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        LocalDate expiry = LocalDate.parse(request.getParameter("expiry"));

        StockItem item = new StockItem(name, quantity, expiry);
        StockStack.stockItems.push(item);

        response.sendRedirect("viewStock");
    }
}
