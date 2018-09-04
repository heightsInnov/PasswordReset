/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.unionbank.password.param;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

/**
 *
 * @author aojinadu
 */
;

public class Settings {

    public static String getPropString(String Key) {
        Properties prop = new Properties();
        String value = "";
        try {
            String propFile = "C:\\Users\\aojinadu\\Documents\\NetBeansProjects\\UserPasswordReset\\src\\java\\com\\unionbank\\password\\param\\passreset.properties";
            //FileInputStream fileinputstream = new FileInputStream(new File(propFile));
            prop.load(new FileInputStream(propFile));

            value = prop.getProperty(Key);
            System.out.println("value is " + value);
            
        } catch (Exception e) {
            System.out.println("Error occured here " + e.getMessage());
        }
        return value;
    }
}
