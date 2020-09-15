package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.techblog.entities.User;

public class UserDao {

	private Connection conn;

	public UserDao(Connection conn) {
		this.conn = conn;
	}

	public boolean saveUser(User user) {
		boolean f = false;
		try {
			String query = "insert into user(name, email, password, gender, about) values(?,?,?,?,?)";
			PreparedStatement pstmt = this.conn.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());

			pstmt.executeUpdate();

			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	// get user by useremail and userpassword
	public User getUserByEmailAndPassword(String email, String passwrod) {
		User user = null;

		try {

			String query = "select * from user where email = ? and password = ?";
			PreparedStatement pstmt = this.conn.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, passwrod);

			ResultSet set = pstmt.executeQuery();
			if (set.next()) {

				user = new User();
				user.setName(set.getString("name"));
				user.setId(set.getInt("id"));
				user.setEmail(set.getNString("email"));
				user.setPassword(set.getString("password"));
				user.setGender(set.getString("gender"));
				user.setAbout(set.getString("about"));
				user.setDateTime(set.getTimestamp("rdate"));
				user.setProfile(set.getString("profile"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	public boolean updateUser(User user) {
		boolean f = false;
		try {
			
			String query = "update user set name = ?, email = ?, password = ?, gender = ?, about = ?, profile = ? where id = ?";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());
			pstmt.setString(6, user.getProfile());
			pstmt.setInt(7, user.getId());
			
			pstmt.executeUpdate();
			f = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return f;

	}

}
