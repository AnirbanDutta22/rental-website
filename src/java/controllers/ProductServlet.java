/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import models.Product;
import java.io.IOException;
//import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Creating list of Product objects
        List<Product> productsList = new ArrayList<>();
        productsList.add(new Product("Laptop", 1200.0,"../assets/images/chair.jpg"));
        productsList.add(new Product("Smartphone", 800.0,"../assets/images/fur/bed/bed1.jpeg"));
        productsList.add(new Product("Tablet", 300.0,"../assets/images/fur/ALMIRAH/alm1.jpeg"));
        productsList.add(new Product("Headphones", 150.0,"../assets/images/fur/ALMIRAH/Home.jpeg"));
        productsList.add(new Product("Laptop", 1200.0,"../assets/images/home/FAN/fan1.jpeg"));
        productsList.add(new Product("Smartphone", 800.0,"../assets/images/home/TV/tv1.jpeg"));
        productsList.add(new Product("Tablet", 300.0,"../assets/images/vehicals/cycle/cycle1.jpeg"));
        productsList.add(new Product("Headphones", 150.0,"../assets/images/vehicals/cycle/cycle3.jpeg"));
        
        request.setAttribute("products", productsList);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/index.jsp");
        dispatcher.forward(request, response);
    }
}
