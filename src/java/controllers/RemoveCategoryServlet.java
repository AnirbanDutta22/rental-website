/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.CategoryDAO;
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
@WebServlet(name = "RemoveCategoryServlet", urlPatterns = {"/RemoveCategoryServlet"})
public class RemoveCategoryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            CategoryDAO CategoryDAO = new CategoryDAO();
            ResponseHandler res = CategoryDAO.removeCategory(categoryId);
            if (res.isSuccess()) {
                request.getSession().setAttribute("successMessage", "Category removed successfully!");
                response.sendRedirect("/pages/admin.jsp?page=category");
            } else {
                request.setAttribute("errorMessage", res.getMessage());
                request.getRequestDispatcher("/pages/admin.jsp?page=category").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddCategoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
