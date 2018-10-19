package com.elevysi.site.auth.dao;

import javax.persistence.metamodel.SingularAttribute;

import com.elevysi.site.auth.entity.OauthClientDetail;
import com.elevysi.site.commons.pojo.OffsetPage;
import com.elevysi.site.commons.pojo.Page.SortDirection;

public interface OauthClientDetailDAO extends AbstractDAO<OauthClientDetail, Integer>{
	
	public OauthClientDetail findByClientID(String clientID);
	public OffsetPage buildOffsetPage(int pageIndex, int size,  SingularAttribute sortField, SortDirection sortDirection);

}
