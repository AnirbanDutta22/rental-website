package controllers;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.SelectedProduct;
import models.User;
import responses.ResponseHandler;

@WebServlet(name = "SendBorrowRequestServlet", urlPatterns = {"/SendBorrowRequestServlet"})
public class SendBorrowRequestServlet extends HttpServlet {

    int tenure, offeredPrice;
    String message;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            tenure = Integer.parseInt(request.getParameter("tenure"));
            out.println(tenure);
            message = request.getParameter("msg");
            out.println(message);
            offeredPrice = Integer.parseInt(request.getParameter("offeredPrice"));
            out.println(offeredPrice);

            SelectedProduct selectedProduct = new SelectedProduct();
            User user = new User();
            //get selected product
            HttpSession session = request.getSession();
            selectedProduct = (SelectedProduct) session.getAttribute("selectedProduct");
            user = (User) session.getAttribute("user");
            //set selected product with updated values
            selectedProduct.setOfferedPrice(offeredPrice);
            selectedProduct.setSelectedTenure(tenure);
            selectedProduct.setMessage(message);

            //using userdao to send borrow request
            UserDAO userDAO = new UserDAO();
            ResponseHandler res = userDAO.sendBorrowRequest(selectedProduct, user);

            if (res.isSuccess()) {
                request.getSession().setAttribute("requestedProduct", selectedProduct);
                response.sendRedirect("/pages/requestDashboard.jsp");
            } else {
                request.setAttribute("errorMessage", res.getMessage());
                RequestDispatcher rd = request.getRequestDispatcher("/pages/borrowRequest.jsp");
                rd.forward(request, response);
            }

        } catch (SQLException ex) {
            Logger.getLogger(SendBorrowRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
