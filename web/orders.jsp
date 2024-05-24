<%-- 
    Document   : orders
    Created on : Apr 15, 2024, 10:11:08 PM
    Author     : ADMIN
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.OrderDao"%>
<%@page import="config.dbConnection"%>
<%@page import="dao.ProductDao"%>
<%@page import="models.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    User auth = (User) request.getSession().getAttribute("auth");
    List<Order> orders = null;
    if (auth != null) {
        request.setAttribute("person", auth);
        OrderDao orderDao = new OrderDao(dbConnection.openConnection());
        orders = orderDao.userOrders(auth.getId());
        
    } else {
        response.sendRedirect("login.jsp");
    }
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="/include/head.jsp"%>
    </head>
    <body>
        <%@include file="/include/navbar.jsp"%>
        <div class="container">
            <div class="card-header my-3">All Orders</div>
            <table class="table table-light">
                <thead>
                    <tr>
                        <th scope="col">Date</th>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Price</th>
                        <th scope="col">Cancel</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (orders != null) {
                            for (Order o : orders) {%>
                    <tr>
                        <td><%=o.getDate()%></td>
                        <td><%=o.getName()%></td>
                        <td><%=o.getCategory()%></td>
                        <td><%=o.getQuantity()%></td>
                        <td><%=dcf.format(o.getPrice())%></td>
                        <td><a class="btn btn-sm btn-danger" href="cancel-order?id=<%=o.getOrderId()%>">Cancel Order</a></td>
                    </tr>
                    <%}
                        }
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>
