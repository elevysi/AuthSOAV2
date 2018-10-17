package com.elevysi.site.auth.service;

import java.util.List;

import javax.persistence.metamodel.SingularAttribute;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

import com.elevysi.site.auth.dao.RoleDAO;
import com.elevysi.site.auth.entity.Role;
import com.elevysi.site.commons.pojo.OffsetPage;
import com.elevysi.site.commons.pojo.Page;
import com.elevysi.site.commons.pojo.Page.SortDirection;

@Service
public class RoleService extends AbstractServiceImpl<Role, Integer>{
	
	
	private ModelMapper modelMapper;
	private RoleDAO roleDAO;
	
	@Autowired
	public RoleService(RoleDAO roleDAO) {
		this.roleDAO = roleDAO;
	}
	
	public OffsetPage buildOffsetPage(int pageIndex, int size,  SingularAttribute sortField, SortDirection sortDirection){
		return roleDAO.buildOffsetPage(pageIndex, size, sortField, sortDirection);
	}
	
	@PreAuthorize("hasRole('ADMIN')")
	public List<Role> findAll(){
		return roleDAO.findAll();
	}
	
	@PreAuthorize("hasRole('ADMIN')")
	public List<Role> findPaginatedItems(Page page){
		return roleDAO.findPaginatedItems(page);
	}
}
