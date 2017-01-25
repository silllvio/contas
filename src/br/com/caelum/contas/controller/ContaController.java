package br.com.caelum.contas.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.com.caelum.contas.dao.ContaDAO;
import br.com.caelum.contas.modelo.Conta;

@RequestMapping("contas")
@Controller
public class ContaController {

	// Método adicional feito na segunda aula.
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView getContas(Conta conta) {

		ContaDAO dao = new ContaDAO();
		List<Conta> contas = dao.lista();
		ModelAndView modelAndView = new ModelAndView("conta/contas");
		modelAndView.addObject("contas", contas);

		return modelAndView;
	}

	@RequestMapping(method = RequestMethod.POST)
	public ModelAndView gravaConta(@Valid Conta conta, BindingResult result, RedirectAttributes attributes) {

		if (result.hasErrors()) {
			return form(conta);
		}
		ContaDAO dao = new ContaDAO();
		dao.adiciona(conta);
		return new ModelAndView("redirect:/contas");
	}

	@RequestMapping("removeConta")
	public String removeConta(Conta conta, Model model) {
		ContaDAO dao = new ContaDAO();
		model.addAttribute("conta", conta);
		dao.remove(conta);
		// return "conta/conta-apagada";
		// return "forward:/contas"; // faz um redirecionamento pelo servidor.
		return "redirect:/contas"; // faz uma nova requisição pelo cliente.
	}

	@RequestMapping("lista")
	public ModelAndView lista() {
		ContaDAO dao = new ContaDAO();
		List<Conta> contas = dao.lista();
		ModelAndView modelAndView = new ModelAndView("conta/lista");
		modelAndView.addObject("contas", contas);
		return modelAndView;
	}

	@RequestMapping("/modelsimples")
	public String modelSimples(Model model) {
		ContaDAO dao = new ContaDAO();
		List<Conta> contas = dao.lista();
		model.addAttribute("contas", contas);
		return "conta/lista";
	}

	@RequestMapping(value = "buscaconta", method = RequestMethod.POST)
	public String buscaConta(Model model, Conta conta) {
		ContaDAO dao = new ContaDAO();
		Conta conta2 = dao.buscaPorId(conta.getId());
		model.addAttribute("conta", conta2);
		System.out.println("funcionei");
		System.out.println(conta2.getDescricao());
		return "conta/buscaconta";
	}

	@RequestMapping(value = "buscaconta", method = RequestMethod.GET)
	public String buscaConta() {
		return "conta/buscaconta";
	}

	@RequestMapping("/alteraConta")
	public String altera(Conta conta) {
		ContaDAO dao = new ContaDAO();
		dao.altera(conta);
		return "redirect:/contas";
	}

	@RequestMapping("/form")
	public ModelAndView form(Conta conta) {
		ModelAndView modelAndView = new ModelAndView("conta/contas");
		modelAndView.addObject("conta", conta);
		return modelAndView;
	}

	@RequestMapping("pagaConta")
	public void pagaConta(Long id, HttpServletResponse response){
		ContaDAO dao = new ContaDAO();
		dao.paga(id);
		response.setStatus(200);
	}
}
