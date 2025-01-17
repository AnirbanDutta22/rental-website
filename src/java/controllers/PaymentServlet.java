package controllers;

import dao.TransactionDAO;
import java.io.IOException;
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
import responses.ResponseHandler;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int rentalId = Integer.parseInt(request.getParameter("rentalId"));
        int transactionId = Integer.parseInt(request.getParameter("transactionId"));
        int requestId = Integer.parseInt(request.getParameter("requestId"));
//        HttpSession session = null;
//        session.setAttribute("requestId",requestId);

        String paymentMethod = request.getParameter("cardNumber") != null ? "Card" : "UPI";
        String transactionId2 = "TXN" + System.currentTimeMillis(); // Generate a dummy transaction ID
        boolean paymentSuccess = Math.random() > 0.2; // Simulate a success rate of 80%

        request.setAttribute("paymentMethod", paymentMethod);
        request.setAttribute("transactionId", transactionId2);
        request.setAttribute("status", paymentSuccess ? "Success" : "Failed");

        if (paymentSuccess) {
            TransactionDAO transactionDao = new TransactionDAO();
            try {
                ResponseHandler res = transactionDao.setTransactionStatusPaid(rentalId, transactionId);
                if (res.isSuccess()) {
                    request.setAttribute("successMessage", res.getMessage());
                } else {
                    request.setAttribute("errorMessage", res.getMessage());
                    RequestDispatcher rd = request.getRequestDispatcher("/pages/signup.jsp");
                    rd.forward(request, response);
                }
            } catch (SQLException ex) {
                Logger.getLogger(PaymentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("requestId", requestId);
            request.getRequestDispatcher("/pages/paymentSuccess.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/pages/paymentFailure.jsp").forward(request, response);
        }
    }
}
