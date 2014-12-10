package com.project.stickynotes.dao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;

import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;


import com.project.stickynotes.customConnection.CustomMongoConnection;
import com.project.stickynotes.forms.LoginForm;


public class CustomMongoOperations {
	
	DBCollection coll;
	DBCollection coll2;
	DBCollection coll3;
	DBCollection coll4;
	public CustomMongoOperations(){
		
		CustomMongoConnection cust1= new CustomMongoConnection();
		coll=cust1.getMongoUserDetails();
		coll2=cust1.getMongoCollection2();
		coll3=cust1.getMongoCollection3();
		coll4=cust1.getMongoCollection4();
	}
	
}