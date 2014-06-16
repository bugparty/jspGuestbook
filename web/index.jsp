<%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User"%>
<%@ page import="model.Note"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="db.DAO"%>
<%
    User user=null;
    ArrayList<Note> notes=null;
    DAO dao = new DAO();
    try{
     user = (User)session.getAttribute("user");
     notes   = dao.getNotes();
    }catch(Exception e){
        e.printStackTrace();
    }
    String title;
    if(user == null){
        title = "我的留言板";
    }else{title = user.getEmail()+"的留言板";}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title><%=title%></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootplus -->
    <link href="css/bootplus.min.css" rel="stylesheet" media="screen">
    <link href="css/bootplus-responsive.min.css" rel="stylesheet" media="screen">

    <!--[if IE 7]>
    <link rel="stylesheet" href="css/bootplus-ie7.min.css">
    <![endif]-->
    <link href="css/guestbook_common.css" rel="stylesheet">
    <script src="js/holder.js"></script>
</head>
<body>
<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="brand" href="#">留言板</a>
            <div class="nav-collapse collapse">
                <% if(user != null){%>
                <p class="navbar-text pull-right">
                    登陆为 <a href="#" class="navbar-link"><%=user.getEmail()%></a>
                </p>
                <%} else { %>
                <p class="navbar-text pull-right">
                    请 <a href="login.jsp" class="navbar-link">登录</a> 或者
                    <a href="register.jsp" class="navbar-link">注册</a>
                </p>
                <% } %>
                <ul class="nav">
                    <li class="active"><a href="#">主页</a></li>
                    <li><a href="#about">关于</a></li>
                    <li><a href="#contact">联系我</a></li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </div>
</div>
<div class="container">
    <h1><%=title%>!</h1>


    <%if(notes != null)
        for(Note note:notes){
    %>
    <div class="card">
        <div class="card-heading image">
            <img src="holder.js/46x46" alt=""/>
            <div class="card-heading-header">
                <h3><%=note.getTitle() %></h3>
                <span>Published <%=note.getDate()%></span>
            </div>
        </div>
        <div class="card-body">
            <%=note.getContent()%>
        </div>

        <div class="card-comments card-actions">
            <div class="comments-collapse-toggle">
                <button class="btn">+1</button>
                <button class="btn">分享</button>
                <a data-toggle="collapse" data-target="#c1-comments" href="#c1-comments">34 回复 <i class="icon-angle-down"></i></a>
            </div>
            <div id="c1-comments" class="comments collapse">
                <div class="media">
                    <a class="pull-left" href="#">
                        <img class="media-object" data-src="holder.js/28x28" alt="avatar"/>
                    </a>
                    <div class="media-body">
                        <h4 class="media-heading">这个好眼熟啊</h4>
                        <p> 好像是王欣欣...</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%}%>
    <div class="card">
        <h3 class="card-heading simple">
            Leave your commment
        </h3>
        <div class="card-body">
            <form action="/Note" method="post" >
                <input type="hidden" name="_method" value="put"/>
                <input type="text" class="input-block-level" placeholder="在此写下想要说的话" name="content"/>
                <button class="btn btn-primary" type="submit" >提交</button>
            </form>
        </div>


    </div>
</div><!--end of container-->
<script src="http://code.jquery.com/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>