package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.techblog.entities.Category;
import com.techblog.entities.Post;

public class PostDao {
	Connection conn;

	public PostDao(Connection conn) {
		this.conn = conn;
	}

	public ArrayList<Category> getAllCategories() {
		ArrayList<Category> list = new ArrayList<Category>();

		try {
			String query = "select * from categories";
			Statement stmt = this.conn.createStatement();
			ResultSet set = stmt.executeQuery(query);

			while (set.next()) {
				int cid = set.getInt("cid");
				String name = set.getString("name");
				String description = set.getString("description");
				Category category = new Category(cid, name, description);
				list.add(category);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean savePost(Post post) {
		boolean f = false;

		try {
			String query = "insert into posts(pTitle, pContent, pCode, pPic, catId, userId) values(?,?,?,?,?,?)";
			PreparedStatement pstmt = this.conn.prepareStatement(query);
			pstmt.setString(1, post.getpTitle());
			pstmt.setString(2, post.getpContent());
			pstmt.setString(3, post.getpCode());
			pstmt.setString(4, post.getpPic());
			pstmt.setInt(5, post.getCatId());
			pstmt.setInt(6, post.getUserId());

			pstmt.executeUpdate();
			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	// get all posts
	public ArrayList<Post> getAllPosts() {
		ArrayList<Post> list = new ArrayList<Post>();

		// fetch all the posts
		try {
			PreparedStatement pstmt = conn.prepareStatement("select * from posts order by pDate desc");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int pId = rs.getInt("pid");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp pDate = rs.getTimestamp("pDate");
				int catId = rs.getInt("catId");
				int userId = rs.getInt("userId");

				Post post = new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId);

				list.add(post);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// post by catid
	public ArrayList<Post> getPostByCatId(int catId) {
		ArrayList<Post> list = new ArrayList<Post>();
		// fetch all post by id
		try {
			PreparedStatement pstmt = conn.prepareStatement("select * from posts where catId=?");
			pstmt.setInt(1, catId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int pId = rs.getInt("pid");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp pDate = rs.getTimestamp("pDate");
				int userId = rs.getInt("userId");

				Post post = new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId);

				list.add(post);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// post by postId
	public Post getPostByPostId(int postId) {
		Post post = null;
		String query = "select * from posts where pid=?";
		try {
			PreparedStatement pstmt = this.conn.prepareStatement(query);
			pstmt.setInt(1, postId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {

				int pId = rs.getInt("pid");
				String pTitle = rs.getString("pTitle");
				String pContent = rs.getString("pContent");
				String pCode = rs.getString("pCode");
				String pPic = rs.getString("pPic");
				Timestamp pDate = rs.getTimestamp("pDate");
				int catId = rs.getInt("catId");
				int userId = rs.getInt("userId");

				post = new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return post;
	}
}
