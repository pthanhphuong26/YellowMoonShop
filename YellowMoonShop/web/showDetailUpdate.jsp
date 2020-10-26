<%-- 
    Document   : showDetail
    Created on : Oct 10, 2020, 1:30:25 AM
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
            <div class="main-controller d-flex h-100 container">
                <c:set var="proDTO" value="${requestScope.PRODUCT_DTO}"/>
                <div class="detail-container w-100">
                    <form action="UpdateCakeServlet" method="POST" enctype="multipart/form-data" class="col-md-8 mx-auto my-4">
                        <h2 class="text-center mb-4">Moon Cake's Detail</h2>
                        <div class="form-group">
                            <label for="name">Name:</label>
                            <input type="text" class="form-control" id="name" required name="txtName" value="${proDTO.name}">
                        </div>
                        <div class="form-group">
                            <label for="price">Price:</label>
                            <input type="number" class="form-control" id="price" required name="txtPrice" min="1000" value="${proDTO.price}">
                        </div>
                        <div class="form-group">
                            <label for="quantity">Quantity:</label>
                            <input type="number" class="form-control" id="quantity" required name="txtQuantity" min="0" value="${proDTO.quantity}">
                        </div>
                        <div class="form-group">
                            <c:set var="listCate" value="${sessionScope.LIST_CATEGORIES}"/>
                            <c:if test="${not empty listCate}">
                                <label for="category">Category:</label>
                                <select class="form-control" name="cbCategory" id="category">
                                    <c:forEach var="cateDTO" items="${listCate}">
                                        <option value="${cateDTO.name}" ${proDTO.category == cateDTO.name ? 'selected' : ''}>${cateDTO.name}</option>
                                    </c:forEach>
                                </select>
                            </c:if>
                        </div>
                        <c:set var="curDate" value="${requestScope.CURRENT_DATE}"/>
                        <div class="form-group">
                            <label for="creationDate">Creation Date:</label>
                            <input class="form-control" type="date" id="creationDate" max="${curDate}" value="${proDTO.creationDate}" required name="pdCreationDate">
                        </div>
                        <div class="form-group">
                            <label for="expirationDate">Expiration Date:</label>
                            <input class="form-control" type="date" id="expirationDate" min="${curDate}" value="${proDTO.expirationDate}" required name="pdExpirationDate">
                        </div>
                        <div class="form-group">
                            <label for="description">Description:</label>
                            <textarea class="form-control" id="description" rows="2" name="txtDescription" value="${proDTO.description}">${proDTO.description}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="upload_file">Upload Image:</label>
                            <div class="panel">
                                <div class="button_outer">
                                    <div class="btn_upload">
                                        <input type="file" id="upload_file" name="fileImage" accept="image/png, image/jpeg, image/gif" value="${proDTO.image}">
                                        Upload Image
                                    </div>
                                    <div class="processing_bar"></div>
                                    <div class="success_box"></div>
                                </div>
                            </div>
                            <div class="uploaded_file_view" id="uploaded_view">
                                <span class="file_remove">X</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="status">Status:</label>
                            <select class="form-control" name="cbStatus" id="status">
                                <option value="Active" ${proDTO.status == 'Active' ? 'selected' : ''}>Active</option>
                                <option value="Inactive" ${proDTO.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>
                        <input type="hidden" name="txtProID" value="${proDTO.proID}" />
                        <input type="hidden" name="txtImage" value="${proDTO.image}" />
                        <hr>
                        <div class="detail-footer">
                            <a class="btn btn-back" href="SearchCakeServlet" type="reset">Back</a>
                            <button type="submit" class="btn btn-primary" name="btAction" value="Update Cake">Save</button>
                        </div>
                    </form>
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
