<%-- 
    Document   : showDetail
    Created on : 11-Oct-2020, 16:15:12
    Author     : PhuongPT 
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show Detail Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
        <style>
            <%@include file="css/style.css"%>
        </style>
    </head>
    <body>
        <jsp:useBean id="currencyFormat" class="phuongpt.util.CurrencyFormat"/>

        <div class="container-fluid p-0 h-100">
            <div class="header">
                <c:set var="user" value="${sessionScope.USER_DTO}"/>
                <div class="row">
                    <nav class="navbar w-100">
                        <ul class="nav w-100 justify-content-between navbar-link">
                            <li class="nav-item text-white">
                                WELCOME ${user.name}!!!
                            </li>
                            <div class="nav-link-group">
                                <li class="nav-item">
                                    <a href="SearchCakeServlet" class="nav-link text-white">HOME</a>
                                </li>
                                <c:if test="${user.role != 'Admin'}">
                                    <li class="nav-item">
                                        <a href="viewCart.jsp" class="nav-link text-white">CART</a>
                                    </li>
                                </c:if>
                                <c:if test="${user.role == 'User'}">
                                    <li class="nav-item">
                                        <a href="trackOrder.jsp" class="nav-link text-white">ORDER</a>
                                    </li>
                                </c:if>
                            </div>

                            <li class="nav-item ">
                                <c:if test="${empty sessionScope.USER_DTO}">       
                                    <a href="login.jsp" class="text-white">Login</a>
                                </c:if>
                                <c:if test="${not empty sessionScope.USER_DTO}">       
                                    <a class="text-decoration-none nav-link" href="LogoutServlet">
                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
                                        <path fill-rule="evenodd" fill="white" 
                                              d="M3 3.25c0-.966.784-1.75 1.75-1.75h5.5a.75.75 0 010 1.5h-5.5a.25.25 0 00-.25.25v17.5c0 
                                              .138.112.25.25.25h5.5a.75.75 0 010 1.5h-5.5A1.75 1.75 0 013 20.75V3.25zm16.006 9.5l-3.3 
                                              3.484a.75.75 0 001.088 1.032l4.5-4.75a.75.75 0 000-1.032l-4.5-4.75a.75.75 0 00-1.088 
                                              1.032l3.3 3.484H10.75a.75.75 0 000 1.5h8.256z">

                                        </path>
                                        </svg>
                                    </a>   
                                </c:if>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
            <div class="main-controller h-100 container">
                <c:set var="proDTO" value="${requestScope.PRODUCT_DTO}"/>
                <div class="product w-100 d-flex ">
                    <div class="product-image m-4" >
                        <img style="width: 400px;" src="${proDTO.image}"/>
                    </div>
                    <div class="product-buy m-4 ">
                        <h3>${proDTO.name}</h3>
                        <hr>
                        <h4><strong>${currencyFormat.formatCur(proDTO.price)}</strong></h4>
                        <hr>
                        <form action="AddToCartServlet" method="POST">
                            <p class="">Available products: ${proDTO.quantity}</p>

                            <div class="group-input">
                                <input type="button" value="-" id="qty-minus-btn" class="qty-btn" >
                                <input type="number" id="input-quantity" value="1" name="txtQuantity" min="1" max="${proDTO.quantity}">
                                <input type="hidden"value="${proDTO.proID}" name="txtProductID">
                                <input type="button" value="+" id="qty-plus-btn" class="qty-btn">
                            </div>
                            <c:set var="invalid" value="${requestScope.ADD_TO_CART_ERROR}" />
                            <c:if test="${not empty invalid}">
                                <div class="alert alert-danger d-flex justify-content-center" role="alert">
                                    <small>${invalid}</small>
                                </div>
                            </c:if>
                            <div>
                                <button type="submit" class="btn btn-primary" >Add To Cart</button>

                            </div>
                        </form>

                    </div>
                </div>
                <hr>
                <div class="product-detail m-5">
                    <p>Product Name: ${proDTO.name}</p>
                    <p>Product Description: ${proDTO.description}</p>
                    <p>Creation Date: ${proDTO.creationDate}</p>
                    <p>Expiration Date: ${proDTO.expirationDate}</p>
                </div>
            </div>
        </div>
    </div>
</div>        
<script>
    <%@include file="js/main.js"%>
</script>

<!--Bootstrap JS-->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>

