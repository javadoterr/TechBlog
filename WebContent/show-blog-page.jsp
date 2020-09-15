<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="com.techblog.entities.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page errorPage="error_page.jsp" %>
<%
	User user = (User)session.getAttribute("currentUser");
	if(user == null){
		response.sendRedirect("login-page.jsp");
	}
%>
<%
int postId = Integer.parseInt(request.getParameter("post_id"));
PostDao postDao = new PostDao(ConnectionProvider.getConnection());

Post post =  postDao.getPostByPostId(postId);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/mystyle.css">
<title><%= post.getpTitle() %> || TechBlog</title>
<style type="text/css">
	body {
		background-image: url("img/back.jpg");
		background-size: cover;
		background-attachment: fixed;
	}
  	.banner-background {
   		clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 53% 100%, 23% 91%, 0 100%, 0 0);
   	}
   	.post-title{
   		font-weight: 100;
   		font-size: 30px;
   	}
   	.post-content {
   		font-weight: 100;
   		font-size: 25px;
   	}
   	.post-date {
   		font-style: italic;
   		font-weight: bold;
   	}
   	.post-user-info{
   		font-size: 20px;
   		
   	}
   	.row-user{
   		border: 1px solid #e2e2e2;
   		padding-top: 15px;
   	}
</style>
</head>
<body>
<!-- navbar start -->
<nav class="navbar navbar-expand-lg navbar-dark primary-background">
	<a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span>TechBlog</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="profile.jsp"><span class="fa fa-bell-o"></span>LearnCode With lbs
					<span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"><span class="	fa fa-check-square-o"></span> Categories </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#">Programming Language</a> <a
						class="dropdown-item" href="#">Project Implementation</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">Data Structure</a>
				</div></li>
			<li class="nav-item"><a class="nav-link" href="#"><span class="	fa fa-address-card"></span>Contact</a></li>
			<li class="nav-item"><a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-clipboard"></span>Do Post</a></li>
		</ul>
		<ul class="navbar-nav mr-right">
			<li class="nav-item"><a class="nav-link" href="#" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span><%= user.getName()  %></a></li>
			<li class="nav-item"><a class="nav-link" href="logoutServlet"><span class="fa fa-user-plus"></span>Logout</a></li>
		</ul>
	</div>
</nav>
<!-- navbar end -->
<!-- main content of body -->
<div class="container">
	<div class="row my-4">
		<div class="col-md-6 offset-md-3">
			<div class="card">
				<div class="card-header primary-background text-white">
					<h4 class="post-title"><%= post.getpTitle() %></h4>
				</div>
				<div class="card-body">
					<img class="card-img-top my-2" src="blog_pics/<%= post.getpPic()%>" alt="Card image cap" style="max-height: 250px;">
					<div class="row my-3 row-user">
						<div class="col-md-6">
							<p class="post-user-info"><a href="#"><%= user.getName() %> </a> has posted</p>
						</div>
						<div class="col-md-6">
							<p class="post-date"><%= post.getpDate().toLocaleString() %></p>
						</div>
					</div>
					<p class="post-content"><%= post.getpContent() %></p>
					<br>
					<br>
					<div class="post-code">
						<pre><%= post.getpCode() %></pre>
					</div>
				</div>
				<div class="card-footer primary-background">
					<a href="#" class="btn btn-outline-light btn-small"><i class="fa fa-thumbs-o-up"></i><span>10</span></a>
					<a href="#" class="btn btn-outline-light btn-small"><i class="fa fa-commenting-o"></i><span>20</span></a>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- end of main content of body -->
</body>
</html>