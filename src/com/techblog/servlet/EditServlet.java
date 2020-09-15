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

import com.techblog.dao.UserDao;
import com.techblog.entities.Message;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.Helper;

@MultipartConfig
public class EditServlet extends HttpServlet {

	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		PrintWriter writer = resp.getWriter();

		// fetch form data
		String email = req.getParameter("user_email");
		String name = req.getParameter("user_name");
		String password = req.getParameter("user_password");
		String about = req.getParameter("user_about");
		Part part = req.getPart("user_image");
		String imageName = part.getSubmittedFileName();

		// get user from session
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("currentUser");

		user.setEmail(email);
		user.setName(name);
		user.setPassword(password);
		user.setAbout(about);
		String oldProfilePicPath = user.getProfile();
		user.setProfile(imageName);

		// update database....
		UserDao dao = new UserDao(ConnectionProvider.getConnection());
		boolean updateUser = dao.updateUser(user);
		if (updateUser) {
			
			String pathOldFile = req.getRealPath("/") + "pics" + File.separator + oldProfilePicPath;
			String path = req.getRealPath("/") + "pics" + File.separator + user.getProfile();
			
			if(!oldProfilePicPath.equals("defalut.png")) {
				Helper.deleteFile(pathOldFile);
			}
			
			if (Helper.saveFile(part.getInputStream(), path)) {
				writer.println("profile updated...");
				Message msg = new Message("Profile details updated....", "success", "alert-success");
				session.setAttribute("msg", msg);

			} else {
				System.out.println("profile not updated....");
				Message msg = new Message("Something went wrong....", "error", "alert-danger");
				session.setAttribute("msg", msg);
			}

		} else {
			writer.println("not updated to db...");
			Message msg = new Message("Something went wrong....", "error", "alert-danger");
			session.setAttribute("msg", msg);
		}
		
		resp.sendRedirect("profile.jsp");

	}

}
