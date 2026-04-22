package Controller;

import Model.CategoryDTO;
import Model.ToyDTO;
import DAO.CategoryDAO;
import DAO.ToyDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        ToyDAO toyDAO = new ToyDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        // Lấy danh sách danh mục để hiển thị bộ lọc
        List<CategoryDTO> categories = categoryDAO.getAllCategories();
        request.setAttribute("CATEGORY_LIST", categories);

        // Lấy tham số tìm kiếm và lọc
        String search = request.getParameter("search");
        String categoryParam = request.getParameter("categoryID");

        List<ToyDTO> toyList;

        if (search != null && !search.trim().isEmpty()) {
            // Tìm kiếm theo tên
            toyList = toyDAO.searchToysByName(search.trim());
            request.setAttribute("SEARCH_KEY", search.trim());
        } else if (categoryParam != null && !categoryParam.trim().isEmpty()) {
            // Lọc theo danh mục
            try {
                int catID = Integer.parseInt(categoryParam);
                toyList = toyDAO.getToysByCategory(catID);
                request.setAttribute("SELECTED_CATEGORY", catID);
            } catch (NumberFormatException e) {
                toyList = toyDAO.getAllToys();
            }
        } else {
            // Mặc định: lấy tất cả
            toyList = toyDAO.getAllToys();
        }

        request.setAttribute("TOY_LIST", toyList);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
