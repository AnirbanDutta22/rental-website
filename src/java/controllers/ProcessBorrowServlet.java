package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Product;
import models.SelectedProduct;

@WebServlet(name = "ProcessBorrowServlet", urlPatterns = {"/ProcessBorrowServlet"})
public class ProcessBorrowServlet extends HttpServlet {

    int product_id, prev_tenure, selected_tenure;
    double selected_price;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            product_id = Integer.parseInt(request.getParameter("productId"));
            out.println(product_id);
            prev_tenure = Integer.parseInt(request.getParameter("prevTenure"));
            out.println(prev_tenure);
            selected_price = Double.parseDouble(request.getParameter("price"));
            out.println(selected_price);
            selected_tenure = Integer.parseInt(request.getParameter("tenure"));
            out.println(selected_tenure);

            //get selected product
            Product product = new Product();
            HttpSession session = request.getSession();
            product = (Product) session.getAttribute("selectedProduct");
            SelectedProduct selectedProduct = new SelectedProduct(product);
            selectedProduct.setSelectedPrice(selected_price);
            selectedProduct.setSelectedTenure(selected_tenure);
            selectedProduct.setPrevTenure(prev_tenure);

            //set selected product with updated values
            request.getSession().setAttribute("selectedProduct", selectedProduct);
            response.sendRedirect("/pages/borrowRequest.jsp");

        }

    }
}
