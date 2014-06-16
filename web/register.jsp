<%--
  Created by IntelliJ IDEA.
  User: bowman
  Date: 14-5-21
  Time: 上午4:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String alert_msg = (String)session.getAttribute("alert_msg");
 %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>留言板 - 用户注册</title>

    <!-- Bootstrap -->
    <link href='css/fonts.css' rel='stylesheet' type='text/css'>
    <link href="css/bootplus.css" rel="stylesheet">

    <link href="css/guestbook_common.css" rel="stylesheet">

    <link href="../assets/css/bootplus-responsive.css" rel="stylesheet">
    <link href="../assets/css/font-awesome-ie7.min.css" rel="stylesheet">
    <!--[if IE 7]>
    <link rel="stylesheet" href="css/bootplus-ie7.min.css">
    <![endif]-->
    <script src="js/holder.js"></script>
</head>
<body>
<div class="container">
    <% if(alert_msg != null){ %>
        <div class="alert">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <strong>Warning!</strong> <%=alert_msg%>
        </div>
     <%}%>

    <form class="form-signin" role="form" method="post" action="/registerServlet">
        <h2 class="form-signin-heading">账户注册</h2>
        <input type="email" class="input-block-level" placeholder="请输入您的邮箱" required autofocus name="email">
        <input type="password" class="input-block-level" placeholder="请输入您的密码" required name="password">
        <input type="password" class="input-block-level" placeholder="请再次输入密码" required name="password2">

        <label class="checkbox">
            <input type="checkbox" value="remember-me"> 同意服务条款
        </label>
        <button class="btn  btn-primary " type="submit">提交
            <i class="icon-circle-arrow-right"></i>
        </button>
    </form>

    <script src="http://code.jquery.com/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>