# Criação e Carregamento de Banco de Dados ERP MySQL

Este repositório contém o script SQL (`erp_db_setup.sql`) projetado para criar a estrutura completa de um Banco de Dados (BD) de Sistema de Planejamento de Recursos Empresariais (ERP) e carregar os dados iniciais.

O banco de dados principal criado pelo script é nomeado **`erp_db`**.

## ⚙️ Tecnologias Utilizadas

*   **Banco de Dados:** MySQL
*   **Linguagem:** SQL

## 📝 Pré-requisitos para Execução

Para que o script de carregamento de dados funcione corretamente, é necessário que os arquivos CSV de dados (ex: `categories.csv`, `customers.csv`, `Orders.csv`, etc.) estejam localizados em um diretório específico acessível pelo MySQL Server, conforme indicado nas instruções `LOAD DATA INFILE`.

O caminho de arquivo especificado no script é: `C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/`.

## 📋 Estrutura do Banco de Dados

O script cria um total de oito tabelas principais, utilizando o ponto e vírgula (`;`) como delimitador de campo (`FIELDS TERMINATED BY ';'`) e ignorando a primeira linha de cabeçalho (`IGNORE 1 ROWS`) em todos os carregamentos.

### Tabelas Criadas

1.  **`Categories`**: Contém `CategoryID` (chave primária) e informações como `CategoryName` e `Description`.
2.  **`Customers`**: Contém `CustomerID` (chave primária), nome, contato, endereço, cidade, código postal e país.
3.  **`Employees`**: Contém `EmployeeID` (chave primária), nome (`FirstName`, `LastName`), `BirthDate`, `Photo` e `Notes`.
4.  **`Shippers`**: Contém `ShipperID` (chave primária auto-incrementada), `ShipperName` e `Phone`.
5.  **`Suppliers`**: Contém `SupplierID` (chave primária), `SupplierName`, informações de contato, endereço e telefone.
6.  **`Products`**: Contém `ProductID` (chave primária), `ProductName`, `Unit` e `Price`. Esta tabela possui chaves estrangeiras para `SupplierID` e `CategoryID`. **Nota sobre Carregamento:** Há um tratamento específico para o campo `Price`, onde vírgulas (`,`) são substituídas por pontos (`.`) antes da inserção.
7.  **`Orders`**: Contém `OrderID` (chave primária), informações sobre o pedido, e chaves estrangeiras para `CustomerID`, `EmployeeID` e `ShipperID`.
8.  **`OrderDetails`**: Tabela de ligação (muitos para muitos) que contém `OrderDetailID` (chave primária), `OrderID`, `ProductID` e `Quantity`. Esta tabela liga pedidos e produtos.

### Relacionamentos (Chaves Estrangeiras)

O script SQL estabelece as seguintes restrições de chave estrangeira (`FOREIGN KEY`) para garantir a integridade referencial:

| Tabela Fonte | Campo(s) FK | Referência (Tabela/Campo) | Descrição | Fontes |
| :--- | :--- | :--- | :--- | :--- |
| `Products` | `SupplierID` | `Suppliers(SupplierID)` | Ligação com a tabela de fornecedores. | |
| `Products` | `CategoryID` | `Categories(CategoryID)` | Ligação com a tabela de categorias. | |
| `Orders` | `CustomerID` | `Customers(CustomerID)` | Ligação com a tabela de clientes. | |
| `Orders` | `EmployeeID` | `Employees(EmployeeID)` | Ligação com a tabela de funcionários. | |
| `Orders` | `ShipperID` | `Shippers(ShipperID)` | Ligação com a tabela de transportadoras. | |
| `OrderDetails`| `OrderID` | `Orders(OrderID)` | Ligação com a tabela de pedidos. | |
| `OrderDetails`| `ProductID` | `Products(ProductID)` | Ligação com a tabela de produtos. | |

<img alt="Exemplo de imagem" width="800" height="1200" src=https://github.com/Kelvincs742/ERP-Project-/blob/main/der-png.png>
