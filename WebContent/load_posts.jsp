<%@page import="com.techblog.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>

<div class="row">

<% 
	PostDao postDao = new PostDao(ConnectionProvider.getConnection());
	ArrayList<Post> posts = null; 
	int cid = Integer.parseInt(request.getParameter("cid"));
	if(cid == 0){
		 posts = postDao.getAllPosts();	
	}else{
		posts = postDao.getPostByCatId(cid);
	}
	
	if(posts.size() == 0){
		out.println("<h3 class='display-4 text-center'>No posts in this category..</h3>");
		return;
	}

	for(Post p: posts){
		
%>
<div class="col-md-6 mt-2">
	<div class="card">
		<img class="card-img-top" src="blog_pics/<%= p.getpPic()%>" alt="Card image cap" style="max-height: 250px;">
		<div class="card-body">
			<b><%= p.getpTitle() %></b>
			<p><%= p.getpContent() %></p>
			<%-- <pre><%= p.getpCode() %></pre> --%>
		</div>
		<div class="card-footer primary-background text-center">
			<a href="#" class="btn btn-outline-light btn-small"><i class="fa fa-thumbs-o-up"></i><span>10</span></a>
			<a href="show-blog-page.jsp?post_id=<%= p.getPid() %>" class="btn btn-outline-light btn-small">Read More...</a>
			<a href="#" class="btn btn-outline-light btn-small"><i class="fa fa-commenting-o"></i><span>20</span></a>
		</div>
	</div>
</div>
<%		
	}

%>
</div>