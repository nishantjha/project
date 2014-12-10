package com.project.stickynotes;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dropbox.core.DbxException;
import com.project.stickynotes.forms.FilesForm;
import com.project.stickynotes.forms.LoginForm;
import com.project.stickynotes.service.DropBoxService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private static final String APP_KEY = "z7fbx59ihvmdpgo";
	private static final String APP_SECRET = "f6b7wd2f1m5hdbg";
	
	DropBoxService dbxService = new DropBoxService();
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		return "home";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView loginPage() {
		logger.info("HomeController class --->>> loginPage() Method Start");
		LoginForm loginForm = new LoginForm();
		logger.info("HomeController class --->>> loginPage() Method End");
        return new ModelAndView("login" , "loginForm", loginForm);
    }
	
	@RequestMapping(value = "/home", method = RequestMethod.POST)
    public String login(HttpServletRequest request, HttpServletResponse response) {
		logger.info("HomeController class --->>> login() Method Start");
		
		String authorizeUrl = null;
		
		try { 
		    HttpSession session = request.getSession(true);
		    authorizeUrl = dbxService.getAuthorizeUrl(APP_KEY, APP_SECRET, session);
		} catch(Exception expt) {
			System.out.println("Error in Login");
		}
	    
	    logger.info("HomeController class --->>> login() Method End");
	    
		return "redirect:" + authorizeUrl;
    }
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/callback", params = "code", method = RequestMethod.GET)
	@ResponseBody
    public ModelAndView accessCode(@RequestParam("code") String code, HttpServletRequest request, HttpServletResponse response) {
		logger.info("HomeController class --->>> accessCode() Method Start");

		ModelAndView modelView = null;
		Map map = null;
		try {
			map = request.getParameterMap();
			dbxService.linkAccount(map);
		} catch (DbxException dbxExp) {
			dbxExp.printStackTrace();
		} catch (Exception exp) {
			exp.printStackTrace();
//			modelView = loginPage();
		}
		
		modelView = getAllFiles();
		
		logger.info("HomeController class --->>> accessCode() Method End");
		return modelView;
		
    }
	
	@RequestMapping(value = "/callback", params = "error_reason", method = RequestMethod.GET)
	@ResponseBody
    public ModelAndView error(@RequestParam("error_reason") String errorReason, @RequestParam("error") String error, @RequestParam("error_description") String description) {
		try {
			System.out.println("\nIn callback Error\n\n");
			System.out.println(errorReason);
			System.out.println(error);
			System.out.println(description);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return loginPage();
    }
	
	@RequestMapping(value = "/upload", method = RequestMethod.GET)
    public ModelAndView upload() {
		logger.info("HomeController class --->>> upload() Method");
		
		FilesForm filesForm = null;
		try {
			filesForm = getFormDetails();
		} catch (DbxException e) {
			System.out.println("DropBox Exception");
			filesForm = new FilesForm();
		}
        return new ModelAndView("uploadFile", "filesForm", filesForm);
    }
	
	@RequestMapping(value = "/savefile", method = RequestMethod.POST)
    public ModelAndView save(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
		logger.info("HomeController class --->>> save() Method Start");
		
		ModelAndView modelView = null;
		boolean isUploaded = false;
		String folderPath = null;
        
		try {
			if(file.getSize() <= 1000000) {
				folderPath = request.getParameter("selectedFolder");
				if(folderPath != null && !"".equalsIgnoreCase(folderPath)) {
					folderPath = "/" + request.getParameter("selectedFolder") + "/";
				} else {
					folderPath = "/";
				}
				
				isUploaded = dbxService.uploadFile(file, folderPath);
			} else {
				System.out.println("File size exceeds 1MB limit");
			}
		} catch(IOException ioExp) {
			System.out.println("File not found");
		} catch(DbxException dbxExp) {
        	System.out.println("DropBox Exception");
        } catch (Exception exp) {
			System.out.println("General Exception while upload");
		}
		
		modelView = getAllFiles();
		
		logger.info("HomeController class --->>> save() Method End");
		return modelView;
    }
	
	@RequestMapping(value = "/getFiles", method = RequestMethod.GET)
	public ModelAndView getAllFiles() {
		logger.info("HomeController class --->>> getAllFiles() Method Start");
		
		FilesForm filesForm = null;
		try {
			filesForm = getFormDetails();
		} catch (DbxException dbxExp) {
			System.out.println("DropBox Exception");
			filesForm = new FilesForm();
		}
		
		logger.info("HomeController class --->>> getAllFiles() Method End");
		
		return new ModelAndView("stickynotes", "filesForm", filesForm);		
	}
	
	public FilesForm getFormDetails() throws DbxException {
		FilesForm filesForm = new FilesForm();
		filesForm.setLoggedInUser(dbxService.getLoggedInUser());
		filesForm.setFilesToList(dbxService.getFiles());
		return filesForm;
	}
	
	@RequestMapping(value = "delete", method = RequestMethod.POST)
    public ModelAndView deleteFileFromDbx(HttpServletRequest request) {
		logger.info("HomeController class --->>> deleteFileFromDbx() Method Start");
		
//		FilesForm filesForm = new FilesForm();
		String folderName = request.getParameter("folderName");
		String file = request.getParameter("fileName");
		String ext = request.getParameter("extn");
		
		try {
			dbxService.deleteFile(folderName, file+"."+ext);
			
//			filesForm.setLoggedInUser(dbxService.getLoggedInUser());
//			filesForm.setFilesToList(dbxService.getFiles());
		} catch (DbxException dbxExp) {
			System.out.println("DropBox Exception");
		}
		
		logger.info("HomeController class --->>> deleteFileFromDbx() Method End");
		return getAllFiles();//new ModelAndView("stickynotes" , "filesForm", filesForm);	
    }
	
}
