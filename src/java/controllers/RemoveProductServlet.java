package controllers;

import dao.UserDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import responses.ResponseHandler;

@WebServlet(name = "RemoveProductServlet", urlPatterns = {"/RemoveProductServlet"})
public class RemoveProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("lender_id");
            int product_id = Integer.parseInt(request.getParameter("product_id"));
            
            // Use userDAO to remove the product to the database
            UserDAO userDAO = new UserDAO();
            ResponseHandler res = userDAO.removeProduct(product_id, username);

            // Redirect or forward based on the response
            if (res.isSuccess()) {
                request.getSession().setAttribute("successMessage", "Product removed successfully!");
                response.sendRedirect("pages/userDashboard.jsp?page=allProducts"); // Redirect to the all product list page
            } else {
                request.setAttribute("errorMessage", res.getMessage());
                request.getRequestDispatcher("pages/userDashboard.jsp?page=allProducts").forward(request, response); // Forward to all product page if there's an error
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
