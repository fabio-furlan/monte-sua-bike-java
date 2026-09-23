package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DAO {
	/**Modulo de conecção**/
	
	//Parâmetros de conexão//
	private String driver = "com.mysql.cj.jdbc.Driver";
	private String url = "jdbc:mysql://127.0.0.1:3306/dbbike?useTimezone=true&serverTimezone=UTC";
	private String user = "root";
	private String password = "adm1234";
	
	//Método de conexão
	private Connection conectar() {
		Connection con = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			return con;
		} catch (Exception e) {
			System.out.println(e);
			return null;	
		}
	}
	/** CRUD CREATE **/
	public void inserirProduto(JavaBeans pecas) {
		String create = "insert into pecas(produto,fabricante,valor) values (?,?,?)";
		try (Connection con = conectar();
				PreparedStatement pst = con.prepareStatement(create)) {
			pst.setString(1, pecas.getProduto());
			pst.setString(2, pecas.getFabricante());
			pst.setString(3, pecas.getValor());
			pst.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	/** CRUD READ **/
	public List<JavaBeans> listarProdutos() {
		List<JavaBeans> lista = new ArrayList<>();
		String select = "select idcon, produto, fabricante, valor from pecas order by idcon desc";
		try (Connection con = conectar();
				PreparedStatement pst = con.prepareStatement(select);
				ResultSet rs = pst.executeQuery()) {
			while (rs.next()) {
				JavaBeans peca = new JavaBeans();
				peca.setIdcon(rs.getString("idcon"));
				peca.setProduto(rs.getString("produto"));
				peca.setFabricante(rs.getString("fabricante"));
				peca.setValor(rs.getString("valor"));
				lista.add(peca);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return lista;
	}

}
