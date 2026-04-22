package Controller;

import Model.ToyDTO;
import DAO.ToyDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DetailController", urlPatterns = {"/detail"})
public class DetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String toyIDParam = request.getParameter("toyID");

        if (toyIDParam == null || toyIDParam.trim().isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        try {
            int toyID = Integer.parseInt(toyIDParam);
            ToyDAO toyDAO = new ToyDAO();
            ToyDTO toy = toyDAO.getToyDetail(toyID);

            if (toy == null) {
                // Đồ chơi không tồn tại
                request.setAttribute("ERROR", "Không tìm thấy đồ chơi này!");
                response.sendRedirect("home");
                return;
            }

            request.setAttribute("TOY", toy);
            request.getRequestDispatcher("detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
