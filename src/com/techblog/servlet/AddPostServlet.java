package com.techblog.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.techblog.dao.PostDao;
import com.techblog.entities.Post;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.Helper;

@MultipartConfig
public class AddPostServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter writer = resp.getWriter();

		int cid = Integer.parseInt(req.getParameter("cid"));
		String pTitle = req.getParameter("pTitle");
		String pContent = req.getParameter("pContent");
		String pCode = req.getParameter("pCode");
		Part part = req.getPart("pic");
		//getting current useId
		HttpSession session = req.getSession();
		User user = (User)session.getAttribute("currentUser");
		
		Post post = new Post(pTitle, pContent, pCode, part.getSubmittedFileName(), null, cid, user.getId());
		
		
		PostDao pdao = new PostDao(ConnectionProvider.getConnection());
		if(pdao.savePost(post)) { 
			
			String path = req.getRealPath("/")+"blog_pics"+File.separator+part.getSubmittedFileName();
			System.out.println(path);
			Helper.saveFile(part.getInputStream(), path);
			
			writer.println("done");
		}else {
			writer.println("error"); 
		}
		 
	}

}
