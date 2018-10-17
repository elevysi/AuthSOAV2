package com.elevysi.site.auth.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.persistence.metamodel.SingularAttribute;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.elevysi.site.auth.entity.Role;
import com.elevysi.site.auth.entity.Role_;
import com.elevysi.site.commons.pojo.OffsetPage;
import com.elevysi.site.commons.pojo.Page;
import com.elevysi.site.commons.pojo.Page.SortDirection;


@Repository
@Transactional
public class RoleDAOImplement extends AbstractDAOImpl<Role, Integer> implements RoleDAO{
	
	@PersistenceContext
	private EntityManager em;
	
	public OffsetPage buildOffsetPage(int pageIndex, int size,  SingularAttribute sortField, SortDirection sortDirection){
		return new OffsetPage(pageIndex, size, getCount(), sortField, sortDirection, Role_.id);
	}
	
	public List<Role> findPaginatedItems(Page page){
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Role> criteria = cb.createQuery(Role.class);
		Root<Role> roleRoot = criteria.from(Role.class);
		criteria.select(roleRoot);
		
		TypedQuery<Role> query = page.createQuery(em, criteria, roleRoot);
		List<Role> roles =  query.getResultList();
		
		
		return roles;
	}

}
