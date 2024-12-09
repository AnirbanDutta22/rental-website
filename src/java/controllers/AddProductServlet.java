package controllers;

import dao.UserDAO;
import java.io.File;
import models.Product;
import responses.ResponseHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import models.User;

@WebServlet(name = "AddProductServlet", urlPatterns = {"/AddProductServlet"})
@MultipartConfig
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            
            //fetching currenr user's username
            HttpSession session = request.getSession();
            User curruser = (User) session.getAttribute("user");
            
            if(!curruser.isIsVerified()){
                request.getSession().setAttribute("lendErrorMessage", "Complete filling your address first !");
                response.sendRedirect("/pages/userDashboard.jsp?page=lendProduct");
                return;
            }
            
            String username = curruser.getEmail().split("@")[0];
            out.println("username : " + username);
            //Get the current user id
            int userId = curruser.getId();


            // Retrieve product details from the request
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String spec = request.getParameter("spec");
            String[] tags = request.getParameterValues("tag");
            String[] productImage;
            int categoryId = Integer.parseInt(request.getParameter("category"));
            String[] prices = request.getParameterValues("price");
            String[] tenures = request.getParameterValues("tenure");
            String[] titles = request.getParameterValues("title");
            String[] details = request.getParameterValues("details");
            // Retrieve all uploaded files
            Collection<Part> fileParts = request.getParts(); // Get all file parts
            // Price Tenures
            List<Product.PriceTenure> PriceTenures = new ArrayList<>();
            // Details
            List<Product.Details> Details = new ArrayList<>();
            // Images paths
            List<String> uploadedFilePaths = new ArrayList<>();
            

            // Define the upload directory
            String uploadDir = "uploads";
            String uploadPath = getServletContext().getRealPath("") + File.separator + uploadDir;
            File uploadDirectory = new File(uploadPath);
            if (!uploadDirectory.exists()) {
                uploadDirectory.mkdir(); // Create upload directory if it doesn't exist
            }

            for (Part filePart : fileParts) {
                if (filePart.getName().equals("imageUrl") && filePart.getSize() > 0) {
                    // Get file extension and original name
                    String fileExtension = getFileExtension(filePart.getSubmittedFileName());

                    // Generate unique file name
                    String fileName = username + filePart.getSubmittedFileName() + fileExtension;

                    // Full path to save the file
                    String fullPath = uploadPath + File.separator + fileName;
                    try {
                        filePart.write(fullPath); // Save the file
                        out.println("File written successfully: " + fullPath);

                        // Add relative path to list for database
                        uploadedFilePaths.add(uploadDir + "/" + fileName);
                    } catch (IOException e) {
                        e.printStackTrace();
                        out.println("Failed to upload file: " + filePart.getSubmittedFileName() + ". Error: " + e.getMessage());
                    }
                }
            }
            // Store the uploaded file paths to productImage array
            productImage = uploadedFilePaths.toArray(new String[0]);
            out.println(productImage);

            // Add Price Tenures
            if (prices != null && tenures != null && prices.length == tenures.length) {
                for (int i = 0; i < prices.length && i < tenures.length; i++) {
                    try {
                        double price = Double.parseDouble(prices[i]); // Parse price as integer
                        int tenure = Integer.parseInt(tenures[i]); // Tenure as string
                        PriceTenures.add(new Product.PriceTenure(price, tenure));
                    } catch (NumberFormatException e) {
                        request.setAttribute("lendErrorMessage", "Invalid price value at position" + (i + 1));
                        request.getRequestDispatcher("/pages/userDashboard.jsp?page=lendProduct").forward(request, response);
                        return;
                    }
                }
            } else {
                request.setAttribute("lendErrorMessage", "Price and Tenure are required !");
                request.getRequestDispatcher("/pages/userDashboard.jsp?page=lendProduct").forward(request, response);
                return;
            }

            // Add details
            if (titles != null && details != null && titles.length == details.length) {
                for (int i = 0; i < titles.length && i < details.length; i++) {
                    try {
                        String title = titles[i];
                        String detail = details[i];
                        Details.add(new Product.Details(title, detail));
                    } catch (NumberFormatException e) {
                        request.setAttribute("lendErrorMessage", "Invalid price value at index " + i);
                        request.getRequestDispatcher("/pages/userDashboard.jsp?page=lendProduct").forward(request, response);
                        return;
                    }
                }
            }

            // Initialize the Product model with retrieved data
            Product Product = new Product(name, description, spec, tags, categoryId, productImage, Details, PriceTenures);

            // Use ProductDAO to add the product to the database
            UserDAO userDAO = new UserDAO();
            ResponseHandler res = userDAO.addProduct(Product, userId);

            // Redirect or forward based on the response
            if (res.isSuccess()) {
                request.getSession().setAttribute("lendSuccessMessage", "Product added successfully!");
                response.sendRedirect("pages/userDashboard.jsp?page=allProducts"); // Redirect to the product list page
            } else {
                request.setAttribute("lendErrorMessage", res.getMessage());
                request.getRequestDispatcher("/pages/userDashboard.jsp?page=lendProduct").forward(request, response); // Forward to add product page if there's an error
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Utility method to get file extension
    private String getFileExtension(String fileName) {
        if (fileName == null) {
            return "";
        }
        int dotIndex = fileName.lastIndexOf('.');
        return (dotIndex >= 0) ? fileName.substring(dotIndex) : "";
    }
}
