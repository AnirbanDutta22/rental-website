/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.AdminDAO;
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

/**
 *
 * @author Srikanta
 */
@WebServlet(name = "ProductApprovalServlet", urlPatterns = {"/ProductApprovalServlet"})
public class ProductApprovalServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        switch (request.getParameter("type")) {
            case "approve":
                try {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    AdminDAO AdminDAO = new AdminDAO();
                    ResponseHandler res = AdminDAO.approveProduct(productId);
                    if (res.isSuccess()) {
                        request.getSession().setAttribute("successMessage", "Product approved successfully!");
                        response.sendRedirect("/pages/admin.jsp?page=products");
                    } else {
                        request.setAttribute("errorMessage", res.getMessage());
                        request.getRequestDispatcher("/pages/admin.jsp?page=products").forward(request, response);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(CategoryServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            case "reject":
                try {
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    AdminDAO AdminDAO = new AdminDAO();
                    ResponseHandler res = AdminDAO.rejectProduct(productId);
                    if (res.isSuccess()) {
                        request.getSession().setAttribute("successMessage", "Product rejected successfully!");
                        response.sendRedirect("/pages/admin.jsp?page=products");
                    } else {
                        request.setAttribute("errorMessage", res.getMessage());
                        request.getRequestDispatcher("/pages/admin.jsp?page=products").forward(request, response);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(CategoryServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            default:
                break;
        }

    }
}
