package controllers;

import dao.UserDAO;
import models.Product;
import responses.ResponseHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;
import models.User;

@WebServlet(name = "AddProductServlet", urlPatterns = {"/AddProductServlet"})
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve product details from the request
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String spec = request.getParameter("spec");
            String[] tags = request.getParameterValues("tag");
            String[] productImage = request.getParameterValues("imageUrl");
            int categoryId = Integer.parseInt(request.getParameter("category"));
            String[] prices = request.getParameterValues("price");
            String[] tenures = request.getParameterValues("tenure");
            String[] titles = request.getParameterValues("title");
            String[] details = request.getParameterValues("details");

            List<Product.PriceTenure> PriceTenures = new ArrayList<>();
            List<Product.Details> Details = new ArrayList<>();
            if (prices != null && tenures != null && prices.length == tenures.length) {
                // Convert to a List<Product.PriceTenure> equivalent
                for (int i = 0; i < prices.length && i < tenures.length; i++) {
                    try {
                        double price = Double.parseDouble(prices[i]); // Parse price as integer
                        int tenure = Integer.parseInt(tenures[i]); // Tenure as string
                        PriceTenures.add(new Product.PriceTenure(price, tenure));
                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "Invalid price value at index " + i);
                        request.getRequestDispatcher("/pages/lendProduct.jsp").forward(request, response);
                        return;
                    }
                }
            } else {
                request.setAttribute("errorMessage", "Price and Tenure are required !");
                request.getRequestDispatcher("/pages/lendProduct.jsp").forward(request, response);
                return;
            }

            if (titles != null && details != null && titles.length == details.length) {
                // Convert to a List<Product.PriceTenure> equivalent
                for (int i = 0; i < titles.length && i < details.length; i++) {
                    try {
                        String title = titles[i];
                        String detail = details[i];
                        Details.add(new Product.Details(title, detail));
                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMessage", "Invalid price value at index " + i);
                        request.getRequestDispatcher("/pages/lendProduct.jsp").forward(request, response);
                        return;
                    }
                }
            }

            //Get the currenty user
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            int userId = user.getId();

            // Initialize the Product model with retrieved data
            Product Product = new Product(name, description, spec, tags, categoryId, productImage, Details, PriceTenures);

            // Use ProductDAO to add the product to the database
            UserDAO userDAO = new UserDAO();
            ResponseHandler res = userDAO.addProduct(Product, userId);

            // Redirect or forward based on the response
            if (res.isSuccess()) {
                request.getSession().setAttribute("successMessage", "Product added successfully!");
                response.sendRedirect("pages/userDashboard.jsp?page=allProducts"); // Redirect to the product list page
            } else {
                request.setAttribute("errorMessage", res.getMessage());
                request.getRequestDispatcher("/pages/lendProduct.jsp").forward(request, response); // Forward to add product page if there's an error
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
