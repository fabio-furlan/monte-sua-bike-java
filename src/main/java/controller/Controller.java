package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DAO;
import model.JavaBeans;

@WebServlet(urlPatterns = {"/Controller","/main","/insert","/consulta"})
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DAO dao = new DAO();

	public Controller() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// teste de conexao
		String action = request.getServletPath();
		System.out.println(action);
		if (action.equals("/main")) {
			pecas (request, response);
		}else if (action.equals("/insert")) {
			novoCadastro(request,response);
		}else if (action.equals("/consulta")) {
			consultarPecas(request,response);
		} else {
			response.sendRedirect("pecas.jsp");
		}
	}

	// Listar contatos
	protected void pecas (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("index.jsp");
	}
	// Novo Cadastro
	protected void novoCadastro (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//teste de recebimento dos dados do formulario
		System.out.println(request.getParameter("cars"));
		System.out.println(request.getParameter("fabricante"));
		System.out.println(request.getParameter("valor"));

		//setar as variaveis JavaBeans
		JavaBeans pecas = new JavaBeans();
		pecas.setProduto(request.getParameter("cars"));
		pecas.setFabricante(request.getParameter("fabricante"));
		pecas.setValor(request.getParameter("valor"));
		// invocar o metodo inserirProduto passando o objeto pecas
		dao.inserirProduto(pecas);

		response.sendRedirect("pecas.jsp?cadastrado=1");
	}
	// Consultar Pecas cadastradas
	protected void consultarPecas (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<JavaBeans> listaPecas = dao.listarProdutos();
		request.setAttribute("listaPecas", listaPecas);
		RequestDispatcher rd = request.getRequestDispatcher("consulta.jsp");
		rd.forward(request, response);
	}
}
