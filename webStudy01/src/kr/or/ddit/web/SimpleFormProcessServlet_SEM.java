package kr.or.ddit.web;

import java.io.IOException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.vo.AlbasengVO;

@WebServlet("/albamon")
public class SimpleFormProcessServlet_SEM extends HttpServlet {
	public static Map<String, String> gradeMap;
	public static Map<String, String> licenseMap;
	static {
		gradeMap = new HashMap<String, String>();
		licenseMap = new LinkedHashMap<>();
		
		gradeMap.put("G001", "고졸");
		gradeMap.put("G002", "대졸");
		gradeMap.put("G003", "석사");
		gradeMap.put("G004", "박사");
		
		licenseMap.put("L001", "정보처리산업기사");
		licenseMap.put("L002", "정보처리기사");
		licenseMap.put("L003", "정보보안산업기사");
		licenseMap.put("L004", "정보보안기사");
		licenseMap.put("L005", "SQLD");
		licenseMap.put("L006", "SQLP");
	}
	public static Map<String, AlbasengVO> albasengs = new LinkedHashMap<>();	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		//resp.setContentType("text/html;charset=UTF-8");
		
	/*		
 		1)하드코딩
	*/
		String name =  req.getParameter("name");
		String age =  req.getParameter("age");
		String tel =  req.getParameter("tel");
		String addr =  req.getParameter("address");
		String gender =  req.getParameter("gender");
		String grade =  req.getParameter("grade");
		String career =  req.getParameter("career");
		String[] license = req.getParameterValues("license");
		AlbasengVO vo = new AlbasengVO();
		vo.setName(name);
		if(age!=null && age.matches("\\d{1,2}")) {
			vo.setAge(new Integer(age));
		} 
		vo.setAddress(addr);
		vo.setTel(tel);
		vo.setGender(gender);
		vo.setGrade(grade);
		vo.setLicense(license);
		vo.setCareer(career);
		boolean valid = true;
		if(StringUtils.isBlank(vo.getName())) {
			valid = false;
		}
		if(StringUtils.isBlank(vo.getTel())) {
			valid = false;
		}
		if(StringUtils.isBlank(vo.getAddress())) {
			valid = false;
		}
		boolean redirect = false;
		String goPage = null;
		if(valid) {
			vo.setCode(String.format("alba_%03d", albasengs.size()+1));
			albasengs.put(vo.getCode(), vo);
			goPage = "/05/albaList.jsp";
			redirect = true;
		}else {
			goPage = "/01/simpleForm.jsp";
		}
		if(redirect) {
			resp.sendRedirect(req.getContextPath() + goPage);
		}else {
			RequestDispatcher rd = req.getRequestDispatcher(goPage);
			rd.forward(req, resp);
		}
	}
}
