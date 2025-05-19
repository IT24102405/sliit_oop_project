package lk.sliit.stockmanagement.stockmanagement1;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deleteStock")
public class DeleteStockServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int index = Integer.parseInt(request.getParameter("index"));
        StockStack.stockItems.remove(index);

        response.sendRedirect("viewStock");
    }
}

