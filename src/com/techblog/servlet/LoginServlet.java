package com.techblog.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.techblog.dao.UserDao;
import com.techblog.entities.Message;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;

public class LoginServlet extends HttpServlet{
	
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter writer = resp.getWriter();
		
		//fetch email and passwrod 
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		
		UserDao dao = new UserDao(ConnectionProvider.getConnection());
		User user = dao.getUserByEmailAndPassword(email, password);
		if(user == null) {
			//error
			Message msg = new Message("Invalid Details ! try with others", "error", "alert-danger");
			HttpSession session = req.getSession();
			session.setAttribute("msg", msg);
			
			
			resp.sendRedirect("login-page.jsp");
			
			
		}else {
			//success
			HttpSession session = req.getSession();
			session.setAttribute("currentUser", user);
			resp.sendRedirect("profile.jsp");
			
		}
		
		
		
	}

}
