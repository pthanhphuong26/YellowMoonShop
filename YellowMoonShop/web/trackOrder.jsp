<%-- 
    Document   : trackOrder
    Created on : 13-Oct-2020, 14:11:58
    Author     : PhuongPT 
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Track Order</title>
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
            <div class="main-controller d-flex flex-column h-100 container">
                <div class="col-md-10 mx-auto">
                    <div class="row">
                        <form class="mx-auto col-md-8 my-3" action="TrackOrderServlet">
                            <div class="form-group row d-flex justify-content-center">
                                <input type="text" class="form-control col-md-8" 
                                       name="txtSearchValue" placeholder="Enter OrderID to track your Order" 
                                       value="${param.txtSearchValue}" required="">
                                <button class="btn ml-2 btn-search my-auto" type="submit" value="Search" name="btAction" >
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="16" height="16">
                                    <path fill-rule="evenodd" d="M11.5 7a4.499 4.499 0 11-8.998 0A4.499 4.499 0 0111.5 7zm-.82 4.74a6 6 0 111.06-1.06l3.04 3.04a.75.75 0 11-1.06 1.06l-3.04-3.04z"></path>
                                    </svg>
                                </button>
                            </div>
                        </form>
                    </div>  
                    <div class="row">
                        <c:set var="order" value="${requestScope.ORDER_DTO}"/>
                        <c:if test="${not empty order}">
                            <div class="my-3 mx-auto">
                                <div>Name: <strong>${order.name}</strong></div>
                                <div>Order ID: ${order.orderID}</div>
                                <div>Address: ${order.address}</div>
                                <div>Phone: ${order.phone}</div>
                                <div>Order Date: ${order.orderDate}</div>
                                <div>Payment: ${order.payment}</div>
                                <div>Payment Status: <span
                                    style="color: ${order.paymentStatus == 'Not Paid' ? 'red' : 'green'}"
                                >${order.paymentStatus}</span></div>
                            </div>
                            <c:set var="detailList" value="${requestScope.ORDERDETAIL_LIST}"/>
                            <c:if test="${not empty detailList}">
                                <div class="row mx-auto">
                                    <table border="1" class="table table-hover">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th scope="col" class="text-center">No.</th>
                                                <th scope="col" class="text-center">Name</th>
                                                <th scope="col" class="text-center">Quantity</th>
                                                <th scope="col" class="text-center">Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="detail" items="${detailList}" varStatus="counter">
                                                <tr>
                                                    <th scope="row">
                                                        ${counter.count}.
                                                    </th>
                                                    <td>
                                                        ${detail.product}
                                                    </td>
                                                    <td>
                                                        ${detail.quantity}

                                                    </td>
                                                    <td>
                                                        ${currencyFormat.formatCur(detail.price)}
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <div>Total: <strong>${currencyFormat.formatCur(order.total)}</strong></div>

                                </div>
                            </c:if>
                        </c:if>
                        <c:if test="${empty detailList}">
                            <div class="text-center my-5 alert alert-danger p-5 font-weight-bold w-100">
                                Can't find any order...
                            </div>
                        </c:if>
                    </div>
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
