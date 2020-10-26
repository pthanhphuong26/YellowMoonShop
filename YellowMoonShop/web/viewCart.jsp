<%-- 
    Document   : viewCart
    Created on : 11-Oct-2020, 17:57:24
    Author     : PhuongPT 
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
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
                    <c:set var="cart" value="${sessionScope.CART}"/>
                    <c:if test="${not empty cart.items}">
                        <h2 class="text-center my-3"><strong>Your Cart</strong></h2>
                        <div class="my-2"><a href="SearchCakeServlet" class="text-muted">Continue shopping...</a></div>
                        <table border="1" class="table table-hover">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col" class="text-center">No.</th>
                                    <th scope="col" class="text-center">Name</th>
                                    <th scope="col" class="text-center">Quantity</th>
                                    <th scope="col" class="text-center">Unit Price</th>
                                    <th scope="col" class="text-center">Total</th>
                                    <th scope="col" class="text-center"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="pro" items="${cart.items}" varStatus="counter">
                                    <c:set var="dto" value="${pro.value}"/>
                                    <tr>
                                        <th scope="row">
                                            ${counter.count}.
                                        </th>
                                        <td>
                                            <a href="ShowDetailServlet?id=${pro.key}" class="text-info">${dto.name}</a>
                                        </td>
                                        <td>
                                            <form action="UpdateCartServlet" method="POST">
                                                <input type="number" name="txtQuantity" id="input-quantity" value="${dto.quantity}" min="1" />
                                                <input type="hidden" name="txtProductID" value="${pro.key}" />
                                            </form>
                                        </td>
                                        <td>
                                            ${currencyFormat.formatCur(dto.price)}
                                        </td>
                                        <td>
                                            ${currencyFormat.formatCur(dto.price * dto.quantity)}
                                        </td>
                                        <td>                    
                                            <form action="RemoveSelectedProductsServlet" class="mx-auto my-3">
                                                <input type="hidden" name="txtProductID" value="${pro.key}" />
                                                <input class="btn btn-danger" style="width:128px;"data-toggle="modal" data-target="#deleteConfirmationModal${pro.key}" value="Remove"/>
                                                <div class="modal fade" id="deleteConfirmationModal${pro.key}" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body text-center font-weight-bold">
                                                                Do you want to remove them from cart? 
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                <button class="btn btn-danger" value="Remove Selected Products" name="btAction" >Delete</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <c:set var="invalid" value="${requestScope.ADD_TO_CART_ERROR}" />
                        <c:if test="${not empty invalid}">
                            <div class="alert alert-danger d-flex justify-content-center" role="alert">
                                <small>${invalid}</small>
                            </div>
                        </c:if>


                        <c:set var="totalQuantity" value="${sessionScope.TOTAL_QUANTITY}"/>
                        <c:set var="totalPrice" value="${sessionScope.TOTAL_PRICE}"/>
                        <div class="mt-2">Total quantity:   <strong>${totalQuantity}</strong> </div>
                        <div class="mt-2">Total price:   <strong>${currencyFormat.formatCur(totalPrice)}</strong></div>

                        <div class="text-center my-3">
                            <button class="btn btn-success" data-toggle="modal" 
                                    data-target="#checkOutModal">Check Out</button>
                        </div>
                        <div class="modal fade" id="checkOutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title font-weight-bold">Order's Information:</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <form action="CheckOutServlet" method="POST">
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label for="name">Name:</label>
                                                <input type="text" class="form-control" id="name" required name="txtName" 
                                                       value="<c:if test="${not empty user}">${user.name}</c:if>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="address">Address:</label>
                                                    <input type="text" class="form-control" id="address" required name="txtAddress"
                                                           value="<c:if test="${not empty user}">${user.address}</c:if>">
                                                </div>
                                                <div class="form-group">
                                                    <label for="phone">Phone:</label>
                                                    <input type="number" class="form-control" id="phone" required name="txtPhone" 
                                                           value="<c:if test="${not empty user}">${user.phone}</c:if>">
                                                </div>
                                                <div class="form-group">
                                                    <h4 class="">Payment: </h4>
                                                <c:set var="listPayment" value="${sessionScope.LIST_PAYMENTS}"/>
                                                <c:if test="${not empty listPayment}">
                                                    <c:forEach var="paymentDTO" items="${listPayment}">
                                                        <input type="radio" id="${paymentDTO.name}" name="rdPayment" value="${paymentDTO.name}" 
                                                               <c:if test="${paymentDTO.name == 'Cash'}">checked="checked"</c:if>
                                                                   />
                                                               <label for="${paymentDTO.name}">${paymentDTO.name}</label><br>
                                                    </c:forEach>
                                                </c:if>
                                            </div>
                                            <input type="hidden" name="txtTotal" value="${totalPrice}"/>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-success" value="Check Out" name="btAction" >Check Out</button>
                                        </div>
                                    </form>

                                </div>
                            </div>
                        </div>

                    </c:if>
                    <c:if test="${empty cart.items}">
                        <div class="text-center my-5 alert alert-danger p-5 font-weight-bold w-100">
                            Empty Cart... Go shopping!
                        </div>
                    </c:if>
                    <c:set var="checkoutResult" value="${requestScope.CHECKOUT_RESULT}" />
                    <c:if test="${checkoutResult == 'suscess'}">
                        <c:set var="orderID" value="${requestScope.ORDERID}" />

                        <div class="text-center my-5 alert alert-success p-5 font-weight-bold">
                            Check out successfully!<br>
                            Here are your orderID: ${orderID}<br>
                            Remember this to track your order...<br>
                            (Login to track your order)
                        </div>
                    </c:if>
                    <c:if test="${checkoutResult == 'fail'}">
                        <div class="text-center my-5 alert alert-danger p-5 font-weight-bold w-100">
                            Oops...Something happens. Try again!
                        </div>
                    </c:if>
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