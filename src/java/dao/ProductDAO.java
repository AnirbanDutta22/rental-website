package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Product;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;
import utils.DBConnect;

public class ProductDAO {

    //method for fetching all products
    public ResponseHandler getAllProducts() throws SQLException {
        List<Product> productList = new ArrayList<>();

        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING ALL PRODUCTS
            String fetchAllProductsQuery = "SELECT * FROM PRODUCT";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(fetchAllProductsQuery)) {
                try (ResultSet productResult = checkStmt.executeQuery()) {
                    while (productResult.next()) {
                        Product product = new Product();
                        product.setId(productResult.getInt("PRODUCT_ID"));
                        product.setName(productResult.getString("NAME"));
                        product.setDescription(productResult.getString("DESCRIPTION"));
                        product.setSpec(productResult.getString("SPEC"));

                        // USING UTILITY METHOD FOR FETCHING PRODUCT PRICE,IMAGES
                        fetchPriceAndTenure(productResult, product);
                        fetchProductImages(productResult, product);
                        //ADDING EACH PRODUCT TO PRODUCTLIST ARRAY
                        productList.add(product);
                    }
                }
            }
        }
        //checking if productList is empty
        if (!productList.isEmpty()) {
            return new ResponseHandler(true, "All Products fetched successfully!", productList);
        } else {
            return new ResponseHandler(false, "No Products found!");
        }
    }

    //method for fetching products of a specific category
    public ResponseHandler getAllProducts(String category) throws SQLException {
        List<Product> productList = new ArrayList<>();

        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING PRODUCTS FROM SPECIFIC CATEGORY
            String fetchAllProductsQuery = "SELECT * FROM PRODUCT WHERE CATEGORY_ID = (SELECT CATEGORY_ID FROM CATEGORY WHERE NAME = ?)";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(fetchAllProductsQuery)) {
                checkStmt.setString(1, category);
                try (ResultSet productResult = checkStmt.executeQuery()) {
                    while (productResult.next()) {
                        Product product = new Product();
                        product.setId(productResult.getInt("PRODUCT_ID"));
                        product.setName(productResult.getString("NAME"));
                        product.setDescription(productResult.getString("DESCRIPTION"));

                        //USING UTILITY METHOD FOR FETCHING PRODUCT PRICE,IMAGES,CATEGORY
                        fetchPriceAndTenure(productResult, product);
                        fetchProductImages(productResult, product);
                        //ADDING EACH PRODUCT TO PRODUCTLIST ARRAY
                        productList.add(product);

                    }
                }
            }
        }
        //checking if productList is empty
        if (!productList.isEmpty()) {
            return new ResponseHandler(true, "All Products fetched successfully!", productList);
        } else {
            return new ResponseHandler(false, "No Products found!");
        }
    }

    //method for fetching details of a specific product
    public ResponseHandler getProduct(String product_id) throws SQLException {

        int productId = Integer.parseInt(product_id);

        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERIES FOR FETCHING ALL PRODUCTS
            String fetchAllProductsQuery = "SELECT * FROM PRODUCT WHERE PRODUCT_ID = ?";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(fetchAllProductsQuery)) {
                checkStmt.setInt(1, productId);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        Product product = new Product();
                        product.setId(rs.getInt("PRODUCT_ID"));
                        product.setName(rs.getString("NAME"));
                        product.setDescription(rs.getString("DESCRIPTION"));
                        product.setSpec(rs.getString("SPEC"));

                        //USING UTILITY METHOD FOR FETCHING PRODUCT DETAILS
                        getProductDetailsUtil(rs, product);

                        return new ResponseHandler(true, "Product details fetched successfully!", product);
                    } else {
                        return new ResponseHandler(false, "Product not found!");
                    }
                }
            }
        }
    }

    //method for fetching wishlist products
    public ResponseHandler getWishlist(int user_id) throws SQLException {
        List<Product> wl = new ArrayList<>();
        try (OracleConnection oconn = DBConnect.getConnection()) {
            String getWishlistQuery = "SELECT PRODUCT_ID,NAME,SPEC FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM USER_WISHLIST WHERE USER_ID = ?)";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(getWishlistQuery)) {
                ops.setInt(1, user_id);

                try (ResultSet wishlistResult = ops.executeQuery()) {
                    while (wishlistResult.next()) {
                        Product product = new Product();
                        product.setId(wishlistResult.getInt("PRODUCT_ID"));
                        product.setName(wishlistResult.getString("NAME"));
                        product.setSpec(wishlistResult.getString("SPEC"));

                        // USING UTILITY METHOD FOR FETCHING PRODUCT PRICE,IMAGES
                        fetchPriceAndTenure(wishlistResult, product);
                        fetchProductImages(wishlistResult, product);
                        //ADDING EACH PRODUCT TO WISHLIST ARRAY
                        wl.add(product);
                    }
                }
            }
        }
        //checking if wishlist is empty
        if (!wl.isEmpty()) {
            return new ResponseHandler(true, "All Wishlist Products fetched successfully!", wl);
        } else {
            return new ResponseHandler(false, "No Products found!");
        }
    }
    
    //method fot fetching products lent by specific user
    public ResponseHandler getAllProductsLent(int user_id) throws SQLException{
        List<Product> wl = new ArrayList<>();
        try (OracleConnection oconn = DBConnect.getConnection()) {
            String getWishlistQuery = "SELECT PRODUCT_ID,NAME,SPEC FROM PRODUCT WHERE PRODUCT_ID IN (SELECT PRODUCT_ID FROM USER_WISHLIST WHERE USER_ID = ?)";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(getWishlistQuery)) {
                ops.setInt(1, user_id);

                try (ResultSet wishlistResult = ops.executeQuery()) {
                    while (wishlistResult.next()) {
                        Product product = new Product();
                        product.setId(wishlistResult.getInt("PRODUCT_ID"));
                        product.setName(wishlistResult.getString("NAME"));
                        product.setSpec(wishlistResult.getString("SPEC"));

                        // USING UTILITY METHOD FOR FETCHING PRODUCT PRICE,IMAGES
                        fetchPriceAndTenure(wishlistResult, product);
                        fetchProductImages(wishlistResult, product);
                        //ADDING EACH PRODUCT TO WISHLIST ARRAY
                        wl.add(product);
                    }
                }
            }
        }
        //checking if wishlist is empty
        if (!wl.isEmpty()) {
            return new ResponseHandler(true, "All Wishlist Products fetched successfully!", wl);
        } else {
            return new ResponseHandler(false, "No Products found!");
        }
    }

    // Utility method for fetching product details (price, tenure, and images)
    public static void getProductDetailsUtil(ResultSet productResult, Product product) throws SQLException {
        // Fetch price and tenure details
        fetchPriceAndTenure(productResult, product);

        // Fetch images details
        fetchProductImages(productResult, product);

        // Fetch other details of product
        fetchProductDetails(productResult, product);

        // Fetch product's category
        fetchProductCategory(productResult, product);

        // Fetch product's lender details
        fetchProductLender(productResult, product);

        // Fetch product's tags
        fetchProductTags(productResult, product);
    }

    private static void fetchPriceAndTenure(ResultSet productResult, Product product) throws SQLException {
        String fetchPriceTenureQuery = "SELECT * FROM PRODUCT_PRICE WHERE PRODUCT_ID = ?";
        try (OracleConnection oconn = DBConnect.getConnection();
                OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(fetchPriceTenureQuery)) {

            ops.setInt(1, productResult.getInt("PRODUCT_ID"));
            try (ResultSet priceResult = ops.executeQuery()) {
                List<Product.PriceTenure> priceTenures = new ArrayList<>();
                while (priceResult.next()) {
                    double price = priceResult.getDouble("PRICE");
                    int tenure = priceResult.getInt("TENURE");
                    priceTenures.add(new Product.PriceTenure(price, tenure));
                }
                product.setPriceTenures(priceTenures);
            }
        }
    }

    private static void fetchProductImages(ResultSet productResult, Product product) throws SQLException {
        String fetchImagesQuery = "SELECT * FROM PRODUCT_IMAGE WHERE PRODUCT_ID = ?";
        try (OracleConnection oconn = DBConnect.getConnection();
                OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(fetchImagesQuery)) {

            ops.setInt(1, productResult.getInt("PRODUCT_ID"));
            try (ResultSet imageResult = ops.executeQuery()) {
                List<String> imageList = new ArrayList<>();
                while (imageResult.next()) {
                    String image = imageResult.getString("IMAGE");
                    imageList.add(image);
                }
                String[] images = imageList.toArray(new String[0]);
                product.setImageUrl(images);
            }
        }
    }

    private static void fetchProductDetails(ResultSet productResult, Product product) throws SQLException {
        String fetchProductDetailsQuery = "SELECT * FROM PRODUCT_DETAILS WHERE PRODUCT_ID = ?";
        try (OracleConnection oconn = DBConnect.getConnection();
                OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(fetchProductDetailsQuery)) {

            ops.setInt(1, productResult.getInt("PRODUCT_ID"));
            try (ResultSet detailsResult = ops.executeQuery()) {
                List<Product.Details> detailsList = new ArrayList<>();
                while (detailsResult.next()) {
                    String title = detailsResult.getString("TITLE");
                    String details = detailsResult.getString("DETAILS");
                    detailsList.add(new Product.Details(title, details));
                }
                product.setDetails(detailsList);
            }
        }
    }

    private static void fetchProductCategory(ResultSet productResult, Product product) throws SQLException {
        String fetchProductCategoryQuery = "SELECT NAME FROM CATEGORY WHERE CATEGORY_ID = (SELECT CATEGORY_ID FROM PRODUCT WHERE PRODUCT_ID = ?)";
        try (OracleConnection oconn = DBConnect.getConnection();
                OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(fetchProductCategoryQuery)) {

            ops.setInt(1, productResult.getInt("PRODUCT_ID"));
            try (ResultSet catResult = ops.executeQuery()) {
                if (catResult.next()) {
                    product.setCategory(catResult.getString("NAME"));
                }
            }
        }
    }

    private static void fetchProductTags(ResultSet productResult, Product product) throws SQLException {
        String fetchImagesQuery = "SELECT * FROM PRODUCT_TAGS WHERE PRODUCT_ID = ?";
        try (OracleConnection oconn = DBConnect.getConnection();
                OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(fetchImagesQuery)) {

            ops.setInt(1, productResult.getInt("PRODUCT_ID"));
            try (ResultSet tagsResult = ops.executeQuery()) {
                List<String> tagsList = new ArrayList<>();
                while (tagsResult.next()) {
                    String tag = tagsResult.getString("TAG");
                    tagsList.add(tag);
                }
                String[] tags = tagsList.toArray(new String[0]);
                product.setTags(tags);
            }
        }
    }

    private static void fetchProductLender(ResultSet productResult, Product product) throws SQLException {
        String fetchProductLenderQuery = "SELECT NAME,ADDRESS FROM USER1 WHERE USER_ID = (SELECT LENDER_ID FROM PRODUCT WHERE PRODUCT_ID = ?)";
        try (OracleConnection oconn = DBConnect.getConnection();
                OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(fetchProductLenderQuery)) {

            ops.setInt(1, productResult.getInt("PRODUCT_ID"));
            try (ResultSet lenderResult = ops.executeQuery()) {
                if (lenderResult.next()) {
                    product.setLenderName(lenderResult.getString("NAME"));
                    product.setLenderAddress(lenderResult.getString("ADDRESS"));
                }
            }
        }
    }
}
