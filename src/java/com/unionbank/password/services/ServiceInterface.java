/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.unionbank.password.services;

import com.union.gateway.ResetDao;
import com.union.gateway.SecretDao;

/**
 *
 * @author aojinadu
 */
public interface ServiceInterface {

	boolean generateOTP(String username, String displayname);

	boolean saveRegistration(SecretDao sec);

	boolean saveReset(ResetDao sec);

	boolean validateOTP(String username, String otp);
	
}
