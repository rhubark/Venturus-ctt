class AddDepartamentoIdToProduto < ActiveRecord::Migration[6.1]
  def change
    add_column :produtos, :departamento_id, :integer
  end
end
