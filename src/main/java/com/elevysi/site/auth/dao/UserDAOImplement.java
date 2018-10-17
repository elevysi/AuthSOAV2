package com.elevysi.site.auth.dao;

import java.util.ArrayList;
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

import org.hibernate.Hibernate;
import org.springframework.stereotype.Repository;
import com.elevysi.site.auth.entity.User;
import com.elevysi.site.auth.entity.User_;
import com.elevysi.site.commons.pojo.OffsetPage;
import com.elevysi.site.commons.pojo.Page;
import com.elevysi.site.commons.pojo.Page.SortDirection;


@Repository
@Transactional
public class UserDAOImplement extends AbstractDAOImpl<User, Integer> implements UserDAO{
	
	@PersistenceContext
	private EntityManager em;
	
	public User save(User user){
		em.persist(user);
		em.flush();
		return user;
	}
	
	public User loadByUsername(String username){
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<User> criteria = cb.createQuery(User.class);
		Root<User> queryRoot = criteria.from(User.class);
		Predicate condition = cb.equal(queryRoot.get(User_.username), username);
		criteria.where(condition);
		TypedQuery<User> query = em.createQuery(criteria);
		List<User> results = query.getResultList();
		
		if(! results.isEmpty()){
			User user = results.get(0);
			Hibernate.initialize(user.getRoles());
			
			return user;
		}
		
		return null;
	}
	
	public User findByEmail(String email){
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<User> criteria = cb.createQuery(User.class);
		Root<User> queryRoot = criteria.from(User.class);
		Predicate condition = cb.equal(queryRoot.get(User_.email), email);
		criteria.where(condition);
		TypedQuery<User> query = em.createQuery(criteria);
		List<User> results = query.getResultList();
		
		if(! results.isEmpty()){
			User user = results.get(0);
			Hibernate.initialize(user.getRoles());
			
			return user;
		}
		
		return null;
	}
	
	
	public OffsetPage buildOffsetPage(int pageIndex, int size,  SingularAttribute sortField, SortDirection sortDirection){
		return new OffsetPage(pageIndex, size, getCount(), sortField, sortDirection, User_.created, User_.modified, User_.id);
	}

	public List<User> findPaginatedItems(Page page){
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<User> criteria = cb.createQuery(User.class);
		Root<User> userRoot = criteria.from(User.class);
		criteria.select(userRoot);
		
		TypedQuery<User> query = page.createQuery(em, criteria, userRoot);
		List<User> users =  query.getResultList();
		
		for(User user : users){
			Hibernate.initialize(user.getRoles());
		}
		
		return users;
	}
	
	public List<User> findMatching(String term, Page page){
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<User> criteria = cb.createQuery(User.class);
		Root<User> userRoot = criteria.from(User.class);
		criteria.select(userRoot);
		
		List<Predicate> predicates = new ArrayList<Predicate>();
		
		predicates.add(cb.like(userRoot.get(User_.first_name), "%"+term+"%"));
		predicates.add(cb.like(userRoot.get(User_.last_name), "%"+term+"%"));
		predicates.add(cb.like(userRoot.get(User_.username), "%"+term+"%"));
		predicates.add(cb.like(userRoot.get(User_.email), "%"+term+"%"));
		predicates.add(cb.like(userRoot.get(User_.country), "%"+term+"%"));
		predicates.add(cb.like(userRoot.get(User_.town), "%"+term+"%"));
		
		criteria.where(cb.or(predicates.toArray(new Predicate[predicates.size()])));
		
			
		TypedQuery<User> query = page.createQuery(em, criteria, userRoot);
		List<User> users =  query.getResultList();
		
		for(User user : users){
			Hibernate.initialize(user.getRoles());
		}
		
		return users;
	}
	
//	public long getCountForCondition(){
//		CriteriaBuilder cb = em.getCriteriaBuilder();
//		CriteriaQuery<Long> cq = cb.createQuery(Long.class);
//		cq.select(cb.count(cq.from(type)));
//		return em.createQuery(cq).getSingleResult();
//	} 
			
}
