<%--
  Created by IntelliJ IDEA.
  User: bowman
  Date: 14-5-21
  Time: 上午4:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>留言板 - 用户登录</title>

    <!-- Bootstrap -->
    <link href="css/bootplus.min.css" rel="stylesheet">

    <link href="css/guestbook_common.css" rel="stylesheet">
    <link href="../assets/css/bootplus-responsive.css" rel="stylesheet">
    <link href="../assets/css/font-awesome-ie7.min.css" rel="stylesheet">
    <!--[if IE 7]>
    <link rel="stylesheet" href="css/bootplus-ie7.min.css">
    <![endif]-->
    <script language="javascript">

        <% Integer i = (Integer)session.getAttribute("ErrorCode");
        if(i!=null && i.intValue() == 1){%>
        alert("用户名或密码错误");
        <%}%>


    </script>
</head>
<body>
<div class="container">

    <form class="form-signin" role="form" method="post" action="/mainServlet">
        <h2 class="form-signin-heading">用户登录</h2>
        <input type="email" class="input-block-level" placeholder="请输入您的邮箱" required autofocus name="email">
        <input type="password" class="input-block-level" placeholder="请输入您的密码" required name="password">

        <label class="checkbox">
        <input type="checkbox" value="remember-me"> 下次自动登录
        </label>
        <button class="btn  btn-primary " type="submit">登录
            <i class="icon-circle-arrow-right"></i>
        </button>
    </form>
    <script src="http://code.jquery.com/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>