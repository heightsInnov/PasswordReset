/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.unionbank.password.services;

import com.union.gateway.ResetDao;
import com.union.gateway.SecurityReset;
import com.union.gateway.SecurityResetService;
import com.union.gateway.SecretDao;

/**
 *
 * @author aojinadu
 */
public class SecurityService implements ServiceInterface {

	private SecurityResetService service;
	private SecurityReset port;

	public SecurityResetService getService() {
		return service;
	}

	public void setService(SecurityResetService service) {
		this.service = service;
	}

	public SecurityReset getPort() {
		return port;
	}

	public void setPort(SecurityReset port) {
		this.port = port;
	}

	@Override
	public boolean generateOTP(String username, String displayname) {
		return getService().getSecurityResetPort().generatePasswordResetOTP(username, displayname);
	}

	@Override
	public boolean validateOTP(String username, String otp) {
		return getService().getSecurityResetPort().validateResetOTP(username, otp);
	}

	@Override
	public boolean saveRegistration(SecretDao sec) {
		return getService().getSecurityResetPort().saveRegistration(sec);
	}
	
	@Override
	public boolean saveReset(ResetDao sec) {
		return getService().getSecurityResetPort().saveReset(sec);
	}
}
