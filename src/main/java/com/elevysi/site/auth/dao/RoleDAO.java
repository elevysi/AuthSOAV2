package com.elevysi.site.auth.dao;

import java.util.List;

import javax.persistence.metamodel.SingularAttribute;

import com.elevysi.site.auth.entity.Role;
import com.elevysi.site.commons.pojo.OffsetPage;
import com.elevysi.site.commons.pojo.Page;
import com.elevysi.site.commons.pojo.Page.SortDirection;

public interface RoleDAO extends AbstractDAO<Role, Integer>{
	
//	public Role save(Role roole);
	public OffsetPage buildOffsetPage(int pageIndex, int size,  SingularAttribute sortField, SortDirection sortDirection);
	public List<Role> findPaginatedItems(Page page);

}
