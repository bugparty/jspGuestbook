package control;

import db.DAO;
import model.Note;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by bowman on 14-5-21.
 */
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String pwd = req.getParameter("password");
        DAO dao;
        User u;
        HttpSession s = req.getSession();
        //u = (User)s.getAttribute("email");

        try{
            dao = new DAO();
        }catch(Exception e){
            e.printStackTrace();
            System.out.println("error when create DAO object");
            resp.sendRedirect("500.jsp");
            return;
        }

        u  = dao.validateUser(email, pwd);


        if(u == null){
            s.setAttribute("ErrorCode",1);
            s.setAttribute("ErrorMessage","账户或者密码错误");
            resp.sendRedirect("login.jsp");
        }else {
        s.setAttribute("ErrorCode",0);
        s.setAttribute("user",u);
        ArrayList<Note> notes = dao.getNotes();
        s.setAttribute("notes",notes);
        resp.sendRedirect("index.jsp");
        }

    }
}
