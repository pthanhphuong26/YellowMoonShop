<%-- 
    Document   : home
    Created on : Oct 6, 2020, 2:09:33 AM
    Author     : PhuongPT 
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
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
                                        <path fill-rule="evenodd" fill="white" d="M3 3.25c0-.966.784-1.75 1.75-1.75h5.5a.75.75 0 010 1.5h-5.5a.25.25 0 00-.25.25v17.5c0 .138.112.25.25.25h5.5a.75.75 0 010 1.5h-5.5A1.75 1.75 0 013 20.75V3.25zm16.006 9.5l-3.3 3.484a.75.75 0 001.088 1.032l4.5-4.75a.75.75 0 000-1.032l-4.5-4.75a.75.75 0 00-1.088 1.032l3.3 3.484H10.75a.75.75 0 000 1.5h8.256z"></path>
                                        </svg>
                                    </a>   
                                </c:if>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
            <div class="main-controller d-flex h-100 container">
                <div class="sidebar">
                    <form action="SearchCakeServlet">
                        <div class="search-box d-flex justify-content-center">
                            <input type="text" name="txtSearchValue" placeholder="Search...">
                        </div>
                        <hr>
                        <div class="category-box">
                            <h4 class="d-flex justify-content-center mb-2">Category</h4>
                            <c:set var="listCate" value="${sessionScope.LIST_CATEGORIES}"/>
                            <c:if test="${not empty listCate}">
                                <c:forEach var="cateDTO" items="${listCate}">
                                    <input type="radio" id="${cateDTO.name}" name="rdCategory" value="${cateDTO.name}" />
                                    <label for="${cateDTO.name}">${cateDTO.name}</label><br>
                                </c:forEach>
                            </c:if>
                        </div>
                        <hr>
                        <div class="money-box">
                            <h4 class="d-flex justify-content-center mb-2">Price</h4>
                            <input type="radio" id="range1" name="rdPrice" value="range1" />
                            <label for="range1">Below 100.000 VND</label><br>
                            <input type="radio" id="range2" name="rdPrice" value="range2" />
                            <label for="range2">100.000 - 500.000 VND</label><br>
                            <input type="radio" id="range3" name="rdPrice" value="range3" />
                            <label for="range3">500.000 - 1.000.000 VND</label><br>
                            <input type="radio" id="range4" name="rdPrice" value="range4" />
                            <label for="range">Above 1.000.000 VND</label>
                        </div>
                        <div class="d-flex justify-content-center">
                            <button type="submit" name="btAction" value="Search" class="btn btn-primary btn-search">Search</button>
                        </div>
                    </form>
                </div>
                <div class="main-content">
                    <div>
                        <c:if test="${user.role == 'Admin'}">
                            <div class="mx-auto col-md-8 add-cake"> 
                                <a href="" class="btn btn-link w-100 mx-auto" data-toggle="modal" data-target="#addCakeModal" type="button">+ Add new Cake</a>
                                <!-- Modal -->
                                <div class="modal fade" id="addCakeModal" tabindex="-1" role="dialog" aria-labelledby="addCakeModal" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title font-weight-bold">Add new Cake</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>

                                            <form action="AddCakeServlet" method="POST" enctype="multipart/form-data">
                                                <div class="modal-body">
                                                    <div class="form-group">
                                                        <label for="name">Name:</label>
                                                        <input type="text" class="form-control" id="name" required name="txtName" value="">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="price">Price:</label>
                                                        <input type="number" class="form-control" id="price" required name="txtPrice" min="1000" value="">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="quantity">Quantity:</label>
                                                        <input type="number" class="form-control" id="quantity" required name="txtQuantity" min="0" value="">
                                                    </div>
                                                    <div class="form-group">
                                                        <c:if test="${not empty listCate}">
                                                            <label for="category">Category:</label>
                                                            <select class="form-control" name="cbCategory" id="category">
                                                                <c:forEach var="cateDTO" items="${listCate}">
                                                                    <option value="${cateDTO.name}">${cateDTO.name}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </c:if>
                                                    </div>
                                                    <c:set var="curDate" value="${requestScope.CURRENT_DATE}"/>
                                                    <div class="form-group">
                                                        <label for="creationDate">Creation Date:</label>
                                                        <input class="form-control" type="date" id="creationDate" max="${curDate}" required name="pdCreationDate">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="expirationDate">Expiration Date:</label>
                                                        <input class="form-control" type="date" id="expirationDate" min="${curDate}" required name="pdExpirationDate">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="description">Description:</label>
                                                        <textarea class="form-control" id="description" rows="2" name="txtDescription"></textarea>
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
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-color" name="btAction" value="Add Cake">Add</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <div class="cake-list">
                            <c:set var="listProducts" value="${requestScope.LIST_PRODUCTS}"/>
                            <c:if test="${not empty listProducts}">
                                <c:forEach var="pro" items="${listProducts}">
                                    <div class="card" style="width: 30%">
                                        <img class="card-img-top" src="${pro.image}" alt="Card image cap">
                                        <div class="card-body">
                                            <h5 class="card-title">
                                                <a href="ShowDetailServlet?id=${pro.proID}">${pro.name}</a>
                                            </h5>
                                            <p class="card-text"><strong>${currencyFormat.formatCur(pro.price)}</strong></p>
                                                    <c:if test="${user.role != 'Admin'}">
                                                <a href="ShowDetailServlet?id=${pro.proID}" class="btn btn-primary">Buy</a>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <nav class="pagination-container">
                                <ul class="pagination justify-content-center" id="pagination">
                                    <c:set var="curPage" value="${requestScope.CURRENT_PAGE}"/>
                                    <c:set var="pages" value="${requestScope.NO_OF_PAGES}"/>
                                    <c:set var="searchValue" value="${requestScope.SEARCH_VALUE}"/>
                                    <c:set var="category" value="${requestScope.CATEGORY}"/>
                                    <c:set var="rangeMoney" value="${requestScope.RANGE_MONEY}"/>
                                    <c:if test="${curPage != 1}">
                                        <li class="pagination-item pagination-item-previous">
                                            <c:url var="previousUrl" value="SearchCakeServlet">
                                                <c:param name="page" value="${curPage - 1}" />
                                                <c:param name="txtSearchValue" value="${searchValue}" />
                                                <c:param name="rdCategory" value="${category}" />
                                                <c:param name="rdPrice" value="${rangeMoney}" />
                                            </c:url>
                                            <a class="pagination-link" href="${previousUrl}">
                                                <span>←</span>Previous
                                            </a>
                                        </li>
                                    </c:if>
                                    <c:forEach var="i" begin="${1}" end="${pages}">
                                        <li class="pagination-item pagination-item-num">
                                            <c:url var="pageUrl" value="SearchCakeServlet">
                                                <c:param name="page" value="${i}" />
                                                <c:param name="txtSearchValue" value="${searchValue}" />
                                                <c:param name="rdCategory" value="${category}" />
                                                <c:param name="rdPrice" value="${rangeMoney}" />
                                            </c:url>
                                            <a class="pagination-link ${i == curPage ? 'active' : ''} " 
                                               href="${pageUrl}">${i}
                                            </a>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${curPage lt pages}">
                                        <li class="pagination-item pagination-item-next">
                                            <c:url var="nextUrl" value="SearchCakeServlet">
                                                <c:param name="page" value="${curPage + 1}" />
                                                <c:param name="txtSearchValue" value="${searchValue}" />
                                                <c:param name="rdCategory" value="${category}" />
                                                <c:param name="rdPrice" value="${rangeMoney}" />
                                            </c:url>
                                            <a class="pagination-link" href="${nextUrl}">
                                                Next<span>→</span>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>
                        <c:if test="${empty listProducts}">
                            <div class="text-center my-5 alert alert-danger p-5 font-weight-bold w-100">
                                Can't find any cake!
                            </div>
                        </c:if>
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
