package com.sist.dao;

import java.lang.reflect.Method;

public class MainClass {
class A{
	public void dispaly() {
		System.out.println("A:display Call...");
	}
}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			Class clsName=Class.forName("com.sist.dao.A");
			Object obj = clsName.newInstance();
			//A클래스에 대한 객체 생성 
			Method[] m = clsName.getDeclaredMethods();
			m[0].invoke(obj,null);
		}catch(Exception ex) {
			
		}
	}

}
