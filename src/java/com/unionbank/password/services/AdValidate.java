/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.unionbank.password.services;

import com.unionbank.webpay.utils.PBEncrytor;
import com.unionbankng.applications.ws.UBNSMSService;
import com.unionbankng.applications.ws.UBNSMSService_Service;
import org.datacontract.schemas._2004._07.ubn_security.Response;
import org.datacontract.schemas._2004._07.ubn_security.UserProfile;

/**
 *
 * @author aojinadu
 */
public class AdValidate {

	static PBEncrytor pb = new PBEncrytor();
	public static boolean validate(String user, String pass, String moduleid) {
		boolean valid = false;
		try {
			valid = checkExist(user, moduleid) && AdAuthenticate(user, pass, moduleid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return valid;
	}
	
	public static Integer TwoFactor(String user, String token, String moduleid){
		Integer resp = 0;
		String tokendecy = pb.PBDecrypt(token);
		try {
			resp = TwoFactorAuth(user, tokendecy, moduleid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resp;
	}

	public UserProfile getUserProfile(String username, String moduleid) {
		UserProfile usP = new UserProfile();
		try {
			usP = userProfile(username, moduleid);
			System.out.println("getUserProfile >> " + usP.getFirstName().getValue());
		} catch (Exception e) {
			System.out.println("Error " + e.getMessage());
		}
		return usP;
	}

	public static boolean checkExist(String username, String moduleid) {
		UBNSMSService_Service _service = new UBNSMSService_Service();
		UBNSMSService _port = _service.getBasicHttpBindingUBNSMSService();
		return _port.isUserExist(username, moduleid);
	}

	private static boolean AdAuthenticate(String username, String password, String moduleid) {
		UBNSMSService_Service _service = new UBNSMSService_Service();
		UBNSMSService _port = _service.getBasicHttpBindingUBNSMSService();
		return _port.adAuthenticate(username, password, moduleid);
	}

	private static UserProfile userProfile(String username, String moduleid) {
		UBNSMSService_Service _service = new UBNSMSService_Service();
		UBNSMSService _port = _service.getBasicHttpBindingUBNSMSService();
		return _port.getUserProfile(username, moduleid);
	}
	
	private static Integer TwoFactorAuth(String username, String token, String moduleid){
		UBNSMSService_Service _service = new UBNSMSService_Service();
		UBNSMSService _port = _service.getBasicHttpBindingUBNSMSService();
		return _port.twoXtorAuth(username, token, moduleid).getStatus();
	}
}
