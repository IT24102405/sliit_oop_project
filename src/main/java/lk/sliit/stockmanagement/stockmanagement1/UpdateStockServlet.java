package lk.sliit.stockmanagement.stockmanagement1;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/updateStock")
public class UpdateStockServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int index = Integer.parseInt(request.getParameter("index"));
        String name = request.getParameter("name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        LocalDate expiry = LocalDate.parse(request.getParameter("expiry"));

        StockItem updatedItem = new StockItem(name, quantity, expiry);
        StockStack.stockItems.set(index, updatedItem);

        response.sendRedirect("viewStock");
    }
}
