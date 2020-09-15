<%@page import="com.techblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="com.techblog.entities.Message"%>
<%@page import="com.techblog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	User user = (User)session.getAttribute("currentUser");
	if(user == null){
		response.sendRedirect("login-page.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>profile</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/mystyle.css">
<title>index | Home</title>
<style type="text/css">
	body {
		background-image: url("img/back.jpg");
		background-size: cover;
		background-attachment: fixed;
	}
  	.banner-background {
   		clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 53% 100%, 23% 91%, 0 100%, 0 0);
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
			<li class="nav-item active"><a class="nav-link" href="#"><span class="fa fa-bell-o"></span>LearnCode With lbs
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

	<%
		Message msg = (Message) session.getAttribute("msg");
	if (msg != null) {
	%>
	<div class="alert <%=msg.getCssClass()%>" role="alert">
		<%=msg.getContent()%>
	</div>

	<%
		session.removeAttribute("msg");
	}
	%>
	
<!-- main body of the page -->
<main>
	<div class="container">
		<div class="row mt-4">
		
			<!-- first col -->
			<div class="col-md-3">
				<!-- list of categories -->
				<div class="list-group">
				  <a onclick="getPosts(0, this)" href="#" class="c-link list-group-item list-group-item-action active">
				    All Posts
				  </a>
				  <!-- categories -->
				  <%
				  	PostDao pDao = new PostDao(ConnectionProvider.getConnection());
				  	ArrayList<Category> list =  pDao.getAllCategories();
				  	for(Category cc: list){
				  	
				  	%>
				  		<a href="#" onclick="getPosts(<%= cc.getCid() %>, this)" class="c-link list-group-item list-group-item-action"><%= cc.getName() %></a>	
				  	<% 
				  	}
				  %>
				</div>
			</div>
			
			<!-- second col -->
			<div class="col-md-9">
				<!-- posts -->
				<div class="container text-center" id="loader">
					<i class="fa fa-refresh fa-4x fa-spin"></i>
					<h3 class="mt-2">Loading...</h3>
				</div>
				<div class="container-fluid"  id="post-container">
				
				</div>
			</div>
		</div>
	</div>
</main>

<!-- end of main body of the page -->

<!-- profile modal start  -->
<!-- Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header primary-background text-white text-center">
        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<div class="container text-center">
      		<img alt="" src="pics/<%= user.getProfile()%>" class="img-fluid mt-3" style="max-width:100px; border-radius: 50%;">
      		<h5 class="modal-title" id="modalLabel"><%=user.getName() %></h5>
      		<!--details  -->
      		<div id="profile-details">
				<table class="table">
					<tbody>
						<tr>
							<th scope="row">ID :</th>
							<td><%= user.getId() %></td>
						</tr>
						<tr>
							<th scope="row">Email :</th>
							<td><%= user.getEmail() %></td>
						</tr>
						<tr>
							<th scope="row">Gender :</th>
							<td><%= user.getGender() %></td>
						</tr>
						<tr>
							<th scope="row">About :</th>
							<td><%= user.getAbout() %></td>
						</tr>
						<tr>
							<th scope="row">Registered on :</th>
							<td><%= user.getDateTime().toString() %></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- end of details -->
			<!-- profile edit -->
			<div id="profile-edit" style="display: none;"> 
				<h3 class="mt-2">Please Edit Carefully</h3>
				<form action="editServlet" method="post" enctype="multipart/form-data">
					<table class="table">
						<tr>
							<td>ID : </td>
							<td><%= user.getId() %></td>
						</tr>
						<tr>
							<td>Email : </td>
							<td><input class="form-control" type="email" name="user_email" value="<%= user.getEmail()%>"></td>
						</tr>
						<tr>
							<td>Name : </td>
							<td><input class="form-control" type="text" name="user_name" value="<%= user.getName()%>"></td>
						</tr>
						<tr>
							<td>Password : </td>
							<td><input class="form-control" type="password" name="user_password" value="<%= user.getPassword()%>"></td>
						</tr>
						<tr>
							<td>Gender : </td>
							<td><%= user.getGender().toUpperCase() %></td>
						</tr>
						<tr>
							<td>About : </td>
							<td><textarea name="user_about" class="form-control" rows="" cols=""><%=user.getAbout() %></textarea>
							</td>
						</tr>
						<tr>
							<td>New Profile: </td>
							<td><input type="file" name="user_image" class="form-control"></textarea>
							</td>
						</tr>
					</table>
					<div class="container">
						<button type="submit" class="btn btn-outline-primary">Save</button>
					</div>
				</form>
			</div>
			<!-- profile edit end -->						
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
      </div>
    </div>
  </div>
</div>
</div>
<!-- end of profile modal -->

<!-- post model start -->
<!-- Modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Provide the post details..</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
        <form id="add-post-form" action="addPostServlet" method="post">
        	<div class="form-group">
        		<select class="form-control" name="cid">
        			<option selected="selected" disabled="disabled">--- select category ---</option>
        			<%
        				PostDao postDao = new PostDao(ConnectionProvider.getConnection());
        				ArrayList<Category> categories = postDao.getAllCategories();
        				for(Category c: categories)
        				{
        			%>
        			<option value="<%= c.getCid()%>"><%= c.getName() %></option>
        			<%
        				}
        			%>
        		</select>
        	</div>
        	<div class="form-group">
        		<input name="pTitle" type="text" placeholder="Enter post title" class="form-control">
        	</div>
        	<div class="form-group">
        		<textarea name="pContent" class="form-control" style="height: 100px;" rows="" cols="" placeholder="Enter your content"></textarea>
        	</div>
        	<div class="form-group">
        		<textarea name="pCode" class="form-control" style="height: 100px;" rows="" cols="" placeholder="Enter your programm (if any)"></textarea>
        	</div>
        	<div class="form-group">
        		<label>Select your pic :</label><br>
        		<input class="form-control" type="file" name="pic">
        	</div>
        	<div class="container text-center">
        		<button type="submit" class="btn btn-outline-primary">Post</button>
        	</div>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- end of post model -->

	<!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <script type="text/javascript" src="js/myjs.js"></script>
    <script type="text/javascript">
    	$(document).ready(function(){
        	let editStatus = false;
			$('#edit-profile-btn').click(function(){
				if(editStatus == false){
					$('#profile-details').hide();
					$('#profile-edit').show();
					editStatus = true;
					$(this).text('Back');
				}else{
					$('#profile-details').show();
					$('#profile-edit').hide();
					editStatus = false;
					$(this).text('Edit');
				}
				
			});
        });		
    </script>
    <!-- add post js -->
    <script type="text/javascript">
		$(document).ready(function(){
			$('#add-post-form').on("submit", function(event){
				//this code get called when form submitted
				event.preventDefault();
				
				let form = new FormData(this);
				//now requesting to server
				$.ajax({

					url: "addPostServlet",
					type: "POST",
					data: form,
					success: function(data, textStatus, jqXHR){
						//success
						//console.log(data);
						if(data.trim() == 'done'){
							swal("Good job!", "saved successfully!", "success");		
						}else{
							swal("Error!", "Something went wrong try arain....!", "error");	
						}
					},
					error: function(jqXHR, textStatus, errorThrown){
						//error
						swal("Error!", "Something went wrong try arain....!", "error");
					},
					processData: false,
					contentType: false
				});
			});
		});
    </script>
    
    <!-- loading posts using ajax -->
    <script type="text/javascript">

		function getPosts(catId, temp) {
			$("#loader").show();
			$("#post-container").hide();

			$(".c-link").removeClass('active');

			$.ajax({
				url:"load_posts.jsp",
				data:{cid:catId},
				method: "GET",
				success: function(data, textStatus, jqXHR){
					//console.log(data);
					$("#loader").hide();
					$("#post-container").show();
					$("#post-container").html(data);
					$(temp).addClass('active');
				}
			});
		}

	
		$(document).ready(function(e){
			let allPostRef = $('.c-link')[0];
			getPosts(0, allPostRef);
			
		});
    </script>
</body>
</html>