package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Product;
import models.SelectedProduct;
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
            String fetchAllProductsQuery = "SELECT * FROM PRODUCT WHERE STATUS='APPROVED'";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(fetchAllProductsQuery)) {
                try (ResultSet productResult = checkStmt.executeQuery()) {
                    while (productResult.next()) {
                        Product product = new Product();
                        product.setId(productResult.getInt("PRODUCT_ID"));
                        product.setName(productResult.getString("NAME"));
                        product.setDescription(productResult.getString("DESCRIPTION"));
                        product.setSpec(productResult.getString("SPEC"));
                        product.setPostdate(productResult.getDate("POST_DATE"));

                        // USING UTILITY METHOD FOR FETCHING PRODUCT PRICE,IMAGES
                        fetchPriceAndTenure(productResult, product);
                        fetchProductImages(productResult, product);
                        fetchProductLender(productResult, product);
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
            String fetchAllProductsQuery = "SELECT * FROM PRODUCT WHERE STATUS='APPROVED' AND CATEGORY_ID = (SELECT CATEGORY_ID FROM CATEGORY WHERE NAME = ?)";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(fetchAllProductsQuery)) {
                checkStmt.setString(1, category);
                try (ResultSet productResult = checkStmt.executeQuery()) {
                    while (productResult.next()) {
                        Product product = new Product();
                        product.setId(productResult.getInt("PRODUCT_ID"));
                        product.setName(productResult.getString("NAME"));
                        product.setDescription(productResult.getString("DESCRIPTION"));
                        product.setSpec(productResult.getString("SPEC"));
                        product.setPostdate(productResult.getDate("POST_DATE"));

                        //USING UTILITY METHOD FOR FETCHING PRODUCT PRICE,IMAGES,CATEGORY
                        fetchPriceAndTenure(productResult, product);
                        fetchProductImages(productResult, product);
                        fetchProductLender(productResult, product);
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
                        product.setPostdate(rs.getDate("POST_DATE"));

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

    //method for fetching products lent by specific user
    public ResponseHandler getAllProductsLent(int user_id) throws SQLException {
        List<Product> allLentProducts = new ArrayList<>();
        try (OracleConnection oconn = DBConnect.getConnection()) {
            String getLentProductQuery = "SELECT * FROM PRODUCT WHERE LENDER_ID = ?";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(getLentProductQuery)) {
                ops.setInt(1, user_id);

                try (ResultSet productResult = ops.executeQuery()) {
                    while (productResult.next()) {
                        Product product = new Product();
                        product.setId(productResult.getInt("PRODUCT_ID"));
                        product.setName(productResult.getString("NAME"));
                        product.setSpec(productResult.getString("SPEC"));
                        product.setStatus(productResult.getString("STATUS"));

                        // USING UTILITY METHOD FOR FETCHING PRODUCT DETAILS
                        getProductDetailsUtil(productResult, product);
                        //ADDING EACH PRODUCT TO WISHLIST ARRAY
                        allLentProducts.add(product);
                    }
                }
            }
        }
        //checking if lent product list is empty
        if (!allLentProducts.isEmpty()) {
            return new ResponseHandler(true, "All Lent Products fetched successfully!", allLentProducts);
        } else {
            return new ResponseHandler(false, "No Products found!");
        }
    }

    //method for fetching all borrow requests (borrower side)
    public ResponseHandler getOwnBorrowRequests(int user_id) throws SQLException {
        List<SelectedProduct> ownBorrowRequests = new ArrayList<>();
        try (OracleConnection oconn = DBConnect.getConnection()) {
            String getOwnBRQuery = "SELECT P.PRODUCT_ID,P.NAME,P.SPEC,RR.* FROM PRODUCT P JOIN RENTAL_REQUEST RR ON P.PRODUCT_ID = RR.PRODUCT_ID WHERE RR.BORROWER_ID = ?";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(getOwnBRQuery)) {
                ops.setInt(1, user_id);

                try (ResultSet productResult = ops.executeQuery()) {
                    while (productResult.next()) {
                        SelectedProduct selectedProduct = new SelectedProduct();
                        Product product = new Product();
                        selectedProduct.setSelectedPrice(productResult.getDouble("PRODUCT_PRICE"));
                        selectedProduct.setSelectedTenure(productResult.getInt("TENURE"));
                        selectedProduct.setOfferedPrice(productResult.getDouble("OFFERED_PRICE"));
                        selectedProduct.setStatus(productResult.getString("STATUS"));
                        selectedProduct.setDate(productResult.getDate("REQUEST_DATE"));
                        selectedProduct.setRequestId(productResult.getInt("REQUEST_ID"));
                        product.setId(productResult.getInt("PRODUCT_ID"));
                        product.setName(productResult.getString("NAME"));
                        product.setSpec(productResult.getString("SPEC"));

                        selectedProduct.setProduct(product);

                        // USING UTILITY METHOD FOR FETCHING PRODUCT DETAILS
                        fetchPriceAndTenure(productResult, product);
                        fetchProductImages(productResult, product);
                        fetchProductLender(productResult, product);
                        //ADDING EACH PRODUCT TO OWN BORROW REQUEST ARRAY
                        ownBorrowRequests.add(selectedProduct);
                    }
                }
            }
        }
        //checking if own borrow list is empty
        if (!ownBorrowRequests.isEmpty()) {
            return new ResponseHandler(true, "Borrower own requests fetched successfully!", ownBorrowRequests);
        } else {
            return new ResponseHandler(false, "No requests found!");
        }
    }

    //method for fetching all borrow requests (lender side)
    public ResponseHandler getBorrowRequests(int user_id) throws SQLException {
        List<SelectedProduct> borrowRequests = new ArrayList<>();
        try (OracleConnection oconn = DBConnect.getConnection()) {
            String getBRQuery = "SELECT P.PRODUCT_ID,P.NAME,P.SPEC,RR.* FROM PRODUCT P JOIN RENTAL_REQUEST RR ON P.PRODUCT_ID = RR.PRODUCT_ID WHERE RR.LENDER_ID = ? AND RR.STATUS <> 'rejected'";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(getBRQuery)) {
                ops.setInt(1, user_id);

                try (ResultSet productResult = ops.executeQuery()) {
                    while (productResult.next()) {
                        SelectedProduct selectedProduct = new SelectedProduct();
                        Product product = new Product();
                        selectedProduct.setSelectedPrice(productResult.getDouble("PRODUCT_PRICE"));
                        selectedProduct.setSelectedTenure(productResult.getInt("TENURE"));
                        selectedProduct.setOfferedPrice(productResult.getDouble("OFFERED_PRICE"));
                        selectedProduct.setStatus(productResult.getString("STATUS"));
                        selectedProduct.setMessage(productResult.getString("MESSAGE"));
                        selectedProduct.setDate(productResult.getDate("REQUEST_DATE"));
                        selectedProduct.setRequestId(productResult.getInt("REQUEST_ID"));
                        product.setId(productResult.getInt("PRODUCT_ID"));
                        product.setName(productResult.getString("NAME"));
                        product.setSpec(productResult.getString("SPEC"));

                        selectedProduct.setProduct(product);

                        // USING UTILITY METHOD FOR FETCHING PRODUCT DETAILS
                        fetchPriceAndTenure(productResult, product);
                        fetchProductImages(productResult, product);
                        fetchProductLender(productResult, product);
                        //ADDING EACH PRODUCT TO OWN BORROW REQUEST ARRAY
                        borrowRequests.add(selectedProduct);
                    }
                }
            }
        }
        //checking if borrow request list is empty
        if (!borrowRequests.isEmpty()) {
            return new ResponseHandler(true, "Borrow requests fetched successfully!", borrowRequests);
        } else {
            return new ResponseHandler(false, "No requests found!");
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
        String fetchProductLenderQuery = "SELECT NAME,ADDRESS,USERNAME FROM USER1 WHERE USER_ID = (SELECT LENDER_ID FROM PRODUCT WHERE PRODUCT_ID = ?)";
        try (OracleConnection oconn = DBConnect.getConnection();
                OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(fetchProductLenderQuery)) {

            ops.setInt(1, productResult.getInt("PRODUCT_ID"));
            try (ResultSet lenderResult = ops.executeQuery()) {
                if (lenderResult.next()) {
                    product.setLenderName(lenderResult.getString("NAME"));
                    product.setLenderAddress(lenderResult.getString("ADDRESS"));
                    product.setLenderUsername(lenderResult.getString("USERNAME"));
                }
            }
        }
    }
}
