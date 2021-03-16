class ProdutosController < ApplicationController

  before_action :set_produto, only: [:edit, :update, :destroy]

  def index
    @produtos = Produto.order(nome: :asc).limit 10
    @produto_com_desconto = Produto.order(:preco).limit 2
  end

  def new
    @produto = Produto.new
    @departamentos = Departamento.all
  end


  def create
    @produto = Produto.new produto_params
    if @produto.save
      flash[:notice] = "Produto salvo com sucesso!"
      redirect_to root_url
    else
      renderiza :new
    end
  end

  def edit
    renderiza :edit
  end

  def update
    if @produto.update produto_params
      redirect_to root_url
      flash[:notice] = "Produto atualizado"
    else
      renderiza :edit
    end

  end

  def destroy
    @produto.destroy
    redirect_to root_url
  end

  def busca
    @nome = params[:nome]
    @produtos = Produto.where "nome like ?", "%#{@nome}%"
  end

  private

  def set_produto
    @produto = Produto.find(params[:id])
  end

  def produto_params
    params.require(:produto).permit(:nome,
    :descricao, :preco, :quantidade, :departamento_id)
  end

  def renderiza(view)
    @departamentos = Departamento.all
    render view
  end

end
