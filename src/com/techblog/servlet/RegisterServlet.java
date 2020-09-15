package com.techblog.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.techblog.dao.UserDao;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;

@MultipartConfig
public class RegisterServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter writer = resp.getWriter();
		
		// fetch all form data
		String check = req.getParameter("check");
		if(check == null) {
			writer.println("box not checked.....");
		}else {
			
			String name = req.getParameter("user_name");
			String email = req.getParameter("user_email");
			String password = req.getParameter("user_password");
			String gender = req.getParameter("gender");
			String about = req.getParameter("about");
			//create user object and set all data
			User user = new User(name, email, password, gender, about);
					
			// create a UserDao 
			UserDao dao = new UserDao(ConnectionProvider.getConnection());
			boolean saveUserRetValue = dao.saveUser(user);
			
			try {
				Thread.sleep(2000);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if(saveUserRetValue) {
				writer.println("done");
			}else {
				writer.println("error");
			}
		}
		
		
	}

}
