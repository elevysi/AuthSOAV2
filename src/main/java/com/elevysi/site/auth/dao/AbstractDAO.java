package com.elevysi.site.auth.dao;

import java.util.List;

import com.elevysi.site.commons.pojo.Page;

public interface AbstractDAO<E, K> {
	
	public E findByID(K key);
	public E save(E entity);
	public E saveEdited(E entity);
	public long getCount();
	public void delete(K key);
	public void remove(E entity);
	public List<E> findAll();
	public List<E> findPaginatedItems(Page page);
	
	
	
}
