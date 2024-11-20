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
import responses.ResponseHandler;

@WebServlet(name = "BorrowerActionServlet", urlPatterns = {"/BorrowerActionServlet"})
public class BorrowerActionServlet extends HttpServlet {

    int request_id, product_id;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            switch (request.getParameter("type")) {
                case "pending":
                    //that means borrower want to cancel the request
                    request_id = Integer.parseInt(request.getParameter("request_id"));
                    out.println(request_id);
                    product_id = Integer.parseInt(request.getParameter("product_id"));
                    out.println(product_id);

                    //using userdao to cancel borrow request
                    UserDAO userDAO = new UserDAO();
                    ResponseHandler res = userDAO.cancelBorrowRequest(product_id, request_id);

                    if (res.isSuccess()) {
                        response.sendRedirect("/pages/requestDashboard.jsp");
                    } else {
                        request.setAttribute("errorMessage", res.getMessage());
                        RequestDispatcher rd = request.getRequestDispatcher("/pages/requestDashboard.jsp");
                        rd.forward(request, response);
                    }
                    
                    break;
                case "rejected":
                    //that means borrower want to request again
                    break;
                default:
                    break;
            }

        } catch (SQLException ex) {
            Logger.getLogger(SendBorrowRequestServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
