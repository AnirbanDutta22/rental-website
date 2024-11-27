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
import javax.servlet.http.HttpSession;
import models.Category;
import responses.ResponseHandler;

/**
 *
 * @author Srikanta
 */
@WebServlet(name = "AddCategoryServlet", urlPatterns = {"/AddCategoryServlet"})
public class AddCategoryServlet extends HttpServlet{
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try {
            int categoryId = Integer.parseInt(request.getParameter("category_id"));
            String name = request.getParameter("category_name");
            Category category = new Category(categoryId, name);
            HttpSession session = request.getSession();
            CategoryDAO CategoryDAO = new CategoryDAO();
            ResponseHandler res = CategoryDAO.addCategory(category);
            if (res.isSuccess()) {
                request.getSession().setAttribute("successMessage", "Category added successfully!");
                response.sendRedirect("/pages/admin.jsp#manage-category");
            } else {
                request.setAttribute("errorMessage", res.getMessage());
                request.getRequestDispatcher("/pages/admin.jsp#manage-category").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddCategoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
