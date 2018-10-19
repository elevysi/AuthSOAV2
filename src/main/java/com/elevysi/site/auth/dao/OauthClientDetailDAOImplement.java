package com.elevysi.site.auth.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.persistence.metamodel.SingularAttribute;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.elevysi.site.auth.entity.OauthClientDetail;
import com.elevysi.site.auth.entity.OauthClientDetail_;
import com.elevysi.site.commons.pojo.OffsetPage;
import com.elevysi.site.commons.pojo.Page.SortDirection;

@Transactional
@Repository
public class OauthClientDetailDAOImplement extends AbstractDAOImpl<OauthClientDetail, Integer> implements OauthClientDetailDAO{
	
	@PersistenceContext
	private EntityManager em;
	
	public OauthClientDetail findByClientID(String clientID) {
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<OauthClientDetail> criteria = cb.createQuery(OauthClientDetail.class);
		Root<OauthClientDetail> queryRoot = criteria.from(OauthClientDetail.class);
		
		Predicate condition = cb.equal(queryRoot.get(OauthClientDetail_.client_id), clientID);
		criteria.where(condition);
		TypedQuery<OauthClientDetail> query = em.createQuery(criteria);
		List<OauthClientDetail> results = query.getResultList();
		
		if(! results.isEmpty()){
			OauthClientDetail oauthClientDetail = results.get(0);
			
			return oauthClientDetail;
		}
		
		return null;
	}
	
	public OffsetPage buildOffsetPage(int pageIndex, int size,  SingularAttribute sortField, SortDirection sortDirection) {
		return new OffsetPage(pageIndex, size, getCount(), sortField, sortDirection, OauthClientDetail_.client_id);
		
	}

}
