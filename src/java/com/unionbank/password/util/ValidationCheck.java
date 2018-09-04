/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.unionbank.mtportal.util;

/**
 *
 * @author aojinadu
 */
public class ValidationCheck {

    public static String checkNull(String value) {
        String retVal = "";
        if (!value.contains("NULL")) {
            retVal = (!value.isEmpty() || value != null ? value : "");
        }
        return retVal;
    }

    public static int checkNull(int value) {
        int retVal = (value != 0 ? value : 0);
        return retVal;
    }
}
