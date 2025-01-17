package controllers;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String paymentMethod = request.getParameter("cardNumber") != null ? "Card" : "UPI";
        String transactionId = "TXN" + System.currentTimeMillis(); // Generate a dummy transaction ID
        boolean paymentSuccess = Math.random() > 0.2; // Simulate a success rate of 80%

        request.setAttribute("paymentMethod", paymentMethod);
        request.setAttribute("transactionId", transactionId);
        request.setAttribute("status", paymentSuccess ? "Success" : "Failed");

        if (paymentSuccess) {
            request.getRequestDispatcher("/pages/paymentSuccess.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/pages/paymentFailure.jsp").forward(request, response);
        }
    }
}
