package filters;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Check if admin session exists
        if (session == null || session.getAttribute("admin") == null) {
            // Admin is not logged in, redirect to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/pages/adminlogin.jsp");
        } else {
            // Admin is logged in, continue to requested resource
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
    }
}
