<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/mystyle.css">
<title>sory ! something went wrong</title>
<style type="text/css">
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 53% 100%, 23% 91%, 0 100%, 0 0);
}
</style>
</head>
<body>
	
	<div class="container text-center">
		<img alt="" src="img/error-404.png" class="img-fluid" style="height: 300px;width: 300px;">
		<h3 class="display-4">Sorry ! Something went wrong...</h3>
		<%= exception %>
		<a  href="index.jsp" class="btn btn-primary btn-lg mt-3">Home</a>
	</div>
	
</body>
</html>