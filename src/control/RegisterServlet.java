package control;

import db.DAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by bowman on 14-5-31.
 */
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String pwd = req.getParameter("password");
        DAO DAO =null;
        User u;
        HttpSession s = req.getSession();
        u = (User)s.getAttribute("user");

        try{
            DAO = new DAO();
            if(DAO.hasUser(email)){
               s.setAttribute("alert_msg","用户存在");
                resp.sendRedirect("register.jsp");
                return;
            }
            DAO.createUser(email,pwd);
            resp.sendRedirect("login.jsp");


        }catch(Exception e){
            System.out.println("error when create DAO object"+e.getStackTrace());


            resp.sendRedirect("500.jsp");
            return;
        }

    }
}
