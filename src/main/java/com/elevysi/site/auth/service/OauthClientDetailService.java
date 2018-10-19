package com.elevysi.site.auth.service;

import java.util.Date;

import javax.persistence.metamodel.SingularAttribute;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.elevysi.site.auth.dao.OauthClientDetailDAO;
import com.elevysi.site.auth.entity.OauthClientDetail;
import com.elevysi.site.commons.pojo.OffsetPage;
import com.elevysi.site.commons.pojo.Page.SortDirection;

@Service
public class OauthClientDetailService extends AbstractServiceImpl<OauthClientDetail, Integer>{
	
	private OauthClientDetailDAO oauthClientDetailDAO;
	
	@Autowired
	public OauthClientDetailService(OauthClientDetailDAO oauthClientDetailDAO) {
		this.oauthClientDetailDAO = oauthClientDetailDAO;
	}
	
	public OffsetPage buildOffsetPage(int pageIndex, int size,  SingularAttribute sortField, SortDirection sortDirection){
		return oauthClientDetailDAO.buildOffsetPage(pageIndex, size, sortField, sortDirection);
	}

	@PreAuthorize("hasRole('ADMIN')")
	public OauthClientDetail updateClientDetailsAdmin(OauthClientDetail editedOauthClientDetail) {
		OauthClientDetail dbOauthClientDetail = oauthClientDetailDAO.findByID(editedOauthClientDetail.getId());
		if(dbOauthClientDetail != null) {
			copyOauthClientDetailFields(editedOauthClientDetail, dbOauthClientDetail);
			return oauthClientDetailDAO.saveEdited(dbOauthClientDetail);
		}
		
		return null;
	}
	
	public OauthClientDetail copyOauthClientDetailFields(OauthClientDetail editedOauthClientDetail, OauthClientDetail dbOauthClientDetail) {
		dbOauthClientDetail.setClient_id(editedOauthClientDetail.getClient_id());
		dbOauthClientDetail.setResource_ids(editedOauthClientDetail.getResource_ids());
		dbOauthClientDetail.setScope(editedOauthClientDetail.getScope());
		dbOauthClientDetail.setAuthorized_grant_types(editedOauthClientDetail.getAuthorized_grant_types());
		dbOauthClientDetail.setWeb_server_redirect_uri(editedOauthClientDetail.getWeb_server_redirect_uri());
		dbOauthClientDetail.setAuthorities(editedOauthClientDetail.getAuthorities());
		dbOauthClientDetail.setAccess_token_validity(editedOauthClientDetail.getAccess_token_validity());
		dbOauthClientDetail.setRefresh_token_validity(editedOauthClientDetail.getRefresh_token_validity());
		dbOauthClientDetail.setAdditional_information(editedOauthClientDetail.getAdditional_information());
		dbOauthClientDetail.setAutoapprove(editedOauthClientDetail.getAutoapprove());
		
		Date now = new Date();
		dbOauthClientDetail.setModified(now);
		
		return dbOauthClientDetail;
	}
	
	@PreAuthorize("hasRole('ADMIN')")
	public OauthClientDetail updateSecretAdmin(Integer id, String newPassword){
		
		OauthClientDetail dbOauthClientDetail = oauthClientDetailDAO.findByID(id);
		if(dbOauthClientDetail != null) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			dbOauthClientDetail.setClient_secret(encoder.encode(newPassword));
			Date now = new Date();
			dbOauthClientDetail.setModified(now);
			OauthClientDetail savedOauthClientDetail = oauthClientDetailDAO.saveEdited(dbOauthClientDetail);
			
			return savedOauthClientDetail;
		}
		return null;
	}
	
	@PreAuthorize("hasRole('ADMIN')")
	public OauthClientDetail findByClientID(String clientID) {
		return oauthClientDetailDAO.findByClientID(clientID);
	}
	
	@PostAuthorize("returnObject.client_id == principal.username || hasRole('ADMIN')")
	public OauthClientDetail saveClient(OauthClientDetail oauthClientDetail) {
		Date now = new Date();
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		oauthClientDetail.setClient_secret(encoder.encode(oauthClientDetail.getClient_secret()));
		oauthClientDetail.setCreated(now);
		oauthClientDetail.setModified(now);
		return oauthClientDetailDAO.save(oauthClientDetail);
		
	}
}
