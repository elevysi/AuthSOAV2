package com.elevysi.site.auth.dao;

import com.elevysi.site.auth.entity.User;
import com.elevysi.site.commons.pojo.OffsetPage;
import com.elevysi.site.commons.pojo.Page;
import com.elevysi.site.commons.pojo.Page.SortDirection;

import java.util.List;

import javax.persistence.metamodel.SingularAttribute;

import com.elevysi.site.auth.dao.AbstractDAO;

public interface UserDAO extends AbstractDAO<User, Integer>{
	
	public User save(User user);
	public User loadByUsername(String username);
	public User findByEmail(String email);
	public OffsetPage buildOffsetPage(int pageIndex, int size,  SingularAttribute sortField, SortDirection sortDirection);
	public List<User> findPaginatedItems(Page page);
	public List<User> findMatching(String term, Page page);
}
