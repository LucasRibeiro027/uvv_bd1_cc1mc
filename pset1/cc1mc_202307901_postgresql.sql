--Verificar se o database(uvv) existe e excluí-lo
DROP DATABASE IF EXISTS uvv ;

--Verifique se o usuário 'lucas' existe e exclua-o
DROP USER IF EXISTS lucas ;

--Verifique se a role existe e a exclua 
DROP ROLE IF EXISTS lucas ; 

--Crie o usuário 'lucas'
CREATE USER lucas WITH CREATEDB CREATEROLE ENCRYPTED PASSWORD 'raiz2211';

--Coloque a role como 'lucas'
set role lucas;

--Crie o Banco de Dados
 CREATE DATABASE uvv 
  WITH OWNER = lucas
  TEMPLATE   = template0
  ENCODING   = "UTF8"
  LC_COLLATE = 'pt_BR.UTF-8'
  LC_CTYPE   = 'pt_BR.UTF-8'
  ALLOW_CONNECTIONS = true;

--Altere o dono do Banco de Dados uvv para seu usuário
alter database uvv owner to lucas;

--Entrar com a senha criptografada
\setenv PGPASSWORD raiz2211

--Faça o comentário para o banco de dados
COMMENT ON DATABAS IS 'Banco de dados Uvv';

--Use o Banco de dados com seu usuário
\c uvv lucas;

--Verifique se o schema lojas existe e apague-o
DROP SCHEMA IF EXISTS lojas;

--Crie o Schema Lojas
CREATE SCHEMA Lojas AUTHORIZATION lucas;

--Faça o comentário do Schema
COMMENT ON SCHEMA  IS 'Schema da Lojas Uvv';

--Defina o Search_Path
set search_path to Lojas,"$user",public;

--Utilize seu usuário
alter user lucas


--Faça que seu usuário seja o dono do schema
set search_path to Lojas,"$user",public;
alter schema lojas owner to lucas;

--Crie a tabela lojas
CREATE TABLE    Lojas.lojas (
                loja_id                                    NUMERIC(38)  NOT NULL,
                nome                                       VARCHAR(255) NOT NULL,
                endereco_web                               VARCHAR(100),
                endereco_fisico                            VARCHAR(512),
                latitude                                   NUMERIC,
                longitude                                  NUMERIC,
                logo                                       BYTEA,
                logo_mime_type                             VARCHAR(512),
                logo_arquivo                               VARCHAR(512),
                logo_charset                               VARCHAR(512),
                logo_ultima_atualizacao                    DATE,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

--Faça os comentários da tabela e das colunas
COMMENT ON TABLE  Lojas.lojas                              IS 'Tabela lojas do Banco de Dados Uvv, contêm os dados das lojas';
COMMENT ON COLUMN Lojas.lojas.loja_id                      IS 'Coluna loja_id da tabela lojas,Pk da tabela lojas, contêm o id da loja';
COMMENT ON COLUMN Lojas.lojas.nome                         IS 'Coluna nome da tabela lojas, contêm o nome da loja';
COMMENT ON COLUMN Lojas.lojas.endereco_web                 IS 'Coluna endereco_web da tabela lojas, contêm o endereço web da loja';
COMMENT ON COLUMN Lojas.lojas.endereco_fisico              IS 'Coluna endereco_fisico da tabela lojas, contêm o endereço físico da loja';
COMMENT ON COLUMN Lojas.lojas.latitude                     IS 'Coluna latitude da tabela lojas, contêm as coordenadas de latitude';
COMMENT ON COLUMN Lojas.lojas.longitude                    IS 'Coluna longitude da tabela lojas, contêm as coordenadas de longitude';
COMMENT ON COLUMN Lojas.lojas.logo                         IS 'Coluna logo da tabela lojas, contêm a logo';
COMMENT ON COLUMN Lojas.lojas.logo_mime_type               IS 'Coluna logo_mime_type da tabela lojas, contêm o tipo mime da logo';
COMMENT ON COLUMN Lojas.lojas.logo_arquivo                 IS 'Coluna logo_arquivo da tabela lojas, contêm o arquivo da logo';
COMMENT ON COLUMN Lojas.lojas.logo_charset                 IS 'Coluna logo_charset da tabela lojas, contêm o charset da logo';
COMMENT ON COLUMN Lojas.lojas.logo_ultima_atualizacao      IS 'Coluna logo_ultima_atualizacao da tabela lojas, contêm ultima atualizaçao da logo';

--Crie a tabela produtos
CREATE TABLE    Lojas.produtos (
                produto_id 	                               NUMERIC(38)  NOT NULL,
                nome 		                                   VARCHAR(255) NOT NULL,
                preco_unitario                             NUMERIC(10,2),
                detalhes 	                                 BYTEA,
                imagem 		                                 BYTEA,
                imagem_mime_type                           VARCHAR(512),
                imagem_arquivo                             VARCHAR(512),
                imagem_charset                             VARCHAR(512),
                imagem_ultima_atualizacao                  DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);

--Faça os comentários da tabela e das colunas
COMMENT ON TABLE  Lojas.produtos                           IS 'Tabela produtos do Banco de Dados Uvv, contêm os dados dos produtos';
COMMENT ON COLUMN Lojas.produtos.produto_id                IS 'Coluna produto_id da tabela produtos, Pk da tabela produtos, contêm o id do produto';
COMMENT ON COLUMN Lojas.produtos.nome                      IS 'Coluna nome da tabela produtos, contêm nome do produto';
COMMENT ON COLUMN Lojas.produtos.preco_unitario            IS 'Coluna preco_unitario da tabela produtos, contêm o preço do produto';
COMMENT ON COLUMN Lojas.produtos.detalhes                  IS 'Coluna detalhes da tabela produtos, contêm detalhes do produto';
COMMENT ON COLUMN Lojas.produtos.imagem                    IS 'Coluna imagem da tabela produtos, contêm os dados da imagem do produto';
COMMENT ON COLUMN Lojas.produtos.imagem_mime_type          IS 'Coluna imagem_mime_type da tabela produtos, contêm o tipo mime da imagem do produto';
COMMENT ON COLUMN Lojas.produtos.imagem_arquivo            IS 'Coluna imagem_arquivo da tabela produtos, contêm o arquivo da imagem do produto';
COMMENT ON COLUMN Lojas.produtos.imagem_charset            IS 'Coluna imagem_charset da tabela produtos, contêm o charset da imagem do produto';
COMMENT ON COLUMN Lojas.produtos.imagem_ultima_atualizacao IS 'Coluna imagem_charset da tabela produtos, contêm ultima atualizaçao da logo ';



--Crie a tabela estoques
CREATE TABLE    Lojas.estoques (
                estoque_id                                 NUMERIC(38) NOT NULL,
                loja_id                                    NUMERIC(38) NOT NULL,
                produto_id                                 NUMERIC(38) NOT NULL,
                quantidade                                 NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

--Faça os comentários da tabela e das colunas
COMMENT ON TABLE  Lojas.estoques                           IS 'Tabela estoques do Banco de Dados Uvv, contêm os dados dos estoques';
COMMENT ON COLUMN Lojas.estoques.estoque_id                IS 'Coluna estoque_id da tabela estoques, Pk da tabela estoques, contêm o id do estoque';
COMMENT ON COLUMN Lojas.estoques.loja_id                   IS 'Coluna loja_id da tabela estoques, FK para a tabela lojas, contêm o id da loja';
COMMENT ON COLUMN Lojas.estoques.produto_id                IS 'Coluna produto_id da tabela estoques, FK para a tabela produtos, contêm o id do produto';
COMMENT ON COLUMN Lojas.estoques.quantidade                IS 'Coluna quantidade da tabela estoques, contêm a quantidade em estoque';

--Crie a tabela clientes
CREATE TABLE    Lojas.clientes (
                cliente_id 	                               NUMERIC(38)  NOT NULL,
                email 		                                 VARCHAR(255) NOT NULL,
                nome 		                                   VARCHAR(255) NOT NULL,
                telefone1 	                               VARCHAR(20),
                telefone2 	                               VARCHAR(20),
                telefone3 	                               VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);

--Faça os comentários da tabela e das colunas
COMMENT ON TABLE  Lojas.clientes 	                         IS 'Tabela clientes do Banco de Dados Uvv, contêm os dados dos clientes';
COMMENT ON COLUMN Lojas.clientes.cliente_id                IS 'Coluna cliente_id da tabela clientes, PK da tabela clientes, contêm o id do cliente';
COMMENT ON COLUMN Lojas.clientes.email 	                   IS 'Coluna email da tabela clientes, contêm o email do cliente';
COMMENT ON COLUMN Lojas.clientes.nome                      IS 'Coluna nome da tabela clientes, contêm o nome do cliente como no RG';
COMMENT ON COLUMN Lojas.clientes.telefone1                 IS 'Coluna telefone1 da tabela clientes, contêm o telefone1 do cliente';
COMMENT ON COLUMN Lojas.clientes.telefone2                 IS 'Coluna telefone2 da tabela clientes, contêm o telefone2 do cliente';
COMMENT ON COLUMN Lojas.clientes.telefone3                 IS 'Coluna telefone3 da tabela clientes, contêm o telefone3 do cliente';

--Crie a tabela pedidos
CREATE TABLE Lojas.pedidos (
                pedido_id                                  NUMERIC(38)   NOT NULL,
                data_hora                                  TIMESTAMP     NOT NULL,
                cliente_id                                 NUMERIC(38)   NOT NULL,
                status                                     VARCHAR(15)   NOT NULL,
                loja_id                                    NUMERIC(38)   NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);

--Faça os comentários da tabela e das colunas
COMMENT ON TABLE  Lojas.pedidos                            IS 'Tabela pedidos do Banco de Dados Uvv, contêm dados dos pedidos';
COMMENT ON COLUMN Lojas.pedidos.pedido_id                  IS 'Coluna pedido_id da tabela pedidos, PK da tabela pedidos, contêm o id do pedido';
COMMENT ON COLUMN Lojas.pedidos.data_hora                  IS 'Coluna data_hora da tabela pedidos, contêm a hora/dia/mês/ano do pedido';
COMMENT ON COLUMN Lojas.pedidos.cliente_id                 IS 'Coluna cliente_id da tabela pedidos, FK para a tabela clientes, contêm o id do cliente';
COMMENT ON COLUMN Lojas.pedidos.status                     IS 'Coluna status da tabela pedidos, contêm o status do pedido';
COMMENT ON COLUMN Lojas.pedidos.loja_id                    IS 'Coluna loja_id da tabela pedidos, FK para a tabela lojas, contêm o id da loja';

--Crie a tabela pedidos_itens
CREATE TABLE Lojas.pedidos_itens (
                pedido_id                                  NUMERIC(38)   NOT NULL,
                produto_id                                 NUMERIC(38)   NOT NULL,
                numero_da_linha                            NUMERIC(38)   NOT NULL,
                preco_unitario                             NUMERIC(10,2) NOT NULL,
                quantidade                                 NUMERIC(38)   NOT NULL,
                envio_id                                   NUMERIC(38),
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);

--Faça os comentários da tabela e das colunas
COMMENT ON TABLE  Lojas.pedidos_itens                      IS 'Tabela pedidos_itens do Banco de Dados Uvv, contêm dados dos itens pedidos';
COMMENT ON COLUMN Lojas.pedidos_itens.pedido_id            IS 'Coluna pedido_id da tabela pedidos_itens, PFK da tabela pedidos_itens, FK para a tabela pedidos, contêm o id do pedido';
COMMENT ON COLUMN Lojas.pedidos_itens.produto_id           IS 'Coluna produto_id da tabela pedidos_itens, PFK da tabela pedidos_itens, FK para a tabela produtos, contêm o id do produto';
COMMENT ON COLUMN Lojas.pedidos_itens.numero_da_linha      IS 'Coluna numero_da_linha da tabela pedidos_itens, contêm o numero da linha do item pedido';
COMMENT ON COLUMN Lojas.pedidos_itens.preco_unitario       IS 'Coluna preco_unitario da tabela pedidos_itens, contêm o peço unitario do item pedido';
COMMENT ON COLUMN Lojas.pedidos_itens.quantidade           IS 'Coluna quantidade da tabela pedidos_itens, contêm a quantidade de intens pedidos';
COMMENT ON COLUMN Lojas.pedidos_itens.envio_id             IS 'Coluna envio_id da tabela pedidos_itens, FK para a tabela envios , contêm o id do envio ';

--Crie a tabela envios
CREATE TABLE Lojas.envios (
                envio_id                                   NUMERIC(38)  NOT NULL,
                loja_id                                    NUMERIC(38)  NOT NULL,
                cliente_id                                 NUMERIC(38)  NOT NULL,
                endereco_entrega                           VARCHAR(512) NOT NULL,
                status                                     VARCHAR(15)  NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);

--Faça os comentários da tabela e das colunas
COMMENT ON TABLE  Lojas.envios                             IS 'Tabela envios do Banco de Dados Uvv, contêm dados dos envios';
COMMENT ON COLUMN Lojas.envios.envio_id                    IS 'Coluna envio_id da tabela envios, PK da tabela envios, contêm o id dos envios';
COMMENT ON COLUMN Lojas.envios.loja_id                     IS 'Coluna loja_id da tabela envios, FK para a tabela lojas, contêm o id da loja';
COMMENT ON COLUMN Lojas.envios.cliente_id                  IS 'Coluna cliente_id da tabela envios, FK para a tabela clientes, contêm o id do cliente';
COMMENT ON COLUMN Lojas.envios.endereco_entrega            IS 'Coluna endereco_entrega da tabela envios, contêm o endereço de entrega do pedido';
COMMENT ON COLUMN Lojas.envios.status                      IS 'Coluna status da tabela envios, contêm o status do envio';

--Faça as constraints de Foreign Keys 
ALTER TABLE Lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES Lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES Lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES Lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES Lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES Lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES Lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Faça os checks das colunas da tabela clientes

ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_cliente_id
CHECK ( cliente_id >= 0);

ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_email
CHECK ( email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') ;

ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_nome
CHECK ( nome ~* '^[A-Za-z\s]+$') ;

ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_telefone1
CHECK ( telefone1 ~* '^\+?\d{1,3}[-.\s]?\(?\d{1,3}\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}$') ;

ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_telefone2
CHECK ( telefone2 ~* '^\+?\d{1,3}[-.\s]?\(?\d{1,3}\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}$') ;

ALTER TABLE clientes
ADD CONSTRAINT cc_clientes_telefone3
CHECK ( telefone3 ~* '^\+?\d{1,3}[-.\s]?\(?\d{1,3}\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}$') ;

--Faça os checks das colunas da tabela lojas

ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_loja_id
CHECK ( loja_id >= 0) ;

ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_nome
CHECK ( nome ~* '^[A-Za-z\s]+$') ;

ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_endereco_web
CHECK ( endereco_web ~* '^(https?://)?[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+(/[a-zA-Z0-9]+)*$' ) ;

ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_endereco_fisico
CHECK ( endereco_fisico ~* '^[A-Za-z0-9\s.,#-]+$') ;

ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_lojas_endereco
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL) ;

ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_latitude
CHECK ( latitude >= -90 AND latitude <= 90)  ;

ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_longitude
CHECK ( longitude >= -180 AND longitude <= 180) ;

ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_logo_mime_type
CHECK ( logo_mime_type ~* '^[a-zA-Z0-9]+/[a-zA-Z0-9.-]{0,511}$') ;

ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_logo_arquivo
CHECK ( logo_arquivo ~* '^[a-zA-Z0-9]+/[a-zA-Z0-9.-]{0,511}$') ;

ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_logo_charset
CHECK ( logo_charset ~* '^[a-zA-Z0-9]+/[a-zA-Z0-9.-]{0,511}$') ;

ALTER TABLE lojas 
ADD CONSTRAINT cc_lojas_logo_ultima_atualizacao
CHECK ( logo_ultima_atualizacao <= CURRENT_DATE) ;

--Faça os checks das colunas da tabela produtos

ALTER TABLE produtos
ADD CONSTRAINT cc_produtos_produto_id
CHECK ( produto_id >=0) ;

ALTER TABLE produtos
ADD CONSTRAINT cc_produtos_nome
CHECK ( nome ~* '^[A-Za-z\s]+$') ;

ALTER TABLE produtos
ADD CONSTRAINT cc_produtos_preco_unitario
CHECK ( preco_unitario >= 0.00) ;

ALTER TABLE produtos
ADD CONSTRAINT cc_produtos_imagem_mime_type
CHECK ( imagem_mime_type ~* '^[a-zA-Z0-9]+/[a-zA-Z0-9.-]{0,511}$') ;

ALTER TABLE produtos
ADD CONSTRAINT cc_produtos_imagem_arquivo
CHECK ( imagem_arquivo ~* '^[a-zA-Z0-9]+/[a-zA-Z0-9.-]{0,511}$') ;

ALTER TABLE produtos
ADD CONSTRAINT cc_produtos_imagem_charset
CHECK ( imagem_charset ~* '^[a-zA-Z0-9]+/[a-zA-Z0-9.-]{0,511}$') ;

ALTER TABLE produtos
ADD CONSTRAINT cc_produtos_imagem_ultima_atualizacao
CHECK ( imagem_ultima_atualizacao <= CURRENT_DATE) ;

--Faça os checks das colunas da tabela estoques

ALTER TABLE estoques
ADD CONSTRAINT cc_estoques_estoque_id
CHECK ( estoque_id >=0) ;

ALTER TABLE estoques
ADD CONSTRAINT cc_estoques_loja_id
CHECK ( loja_id >= 0) ;

ALTER TABLE estoques
ADD CONSTRAINT cc_estoques_produto_id
CHECK ( produto_id >= 0) ;

ALTER TABLE estoques
ADD CONSTRAINT cc_estoques_quantidade
CHECK ( quantidade >= 0) ;

--Faça os checks das colunas da tabela pedidos

ALTER TABLE pedidos
ADD CONSTRAINT cc_pedidos_pedido_id
CHECK ( pedido_id >=0) ;

ALTER TABLE pedidos
ADD CONSTRAINT cc_pedidos_data_hora
CHECK ( data_hora >= '1900-01-01 00:00:00' AND data_hora <= '2999-12-31 23:59:59') ;

ALTER TABLE pedidos
ADD CONSTRAINT cc_pedidos_cliente_id
CHECK ( cliente_id >=0) ;

ALTER TABLE pedidos
ADD CONSTRAINT cc_pedidos_status
CHECK ( status IN ('CANCELADO, COMPLETO, ABERTO, PAGO, REEMBOLSADO, ENVIADO')) ;

ALTER TABLE pedidos
ADD CONSTRAINT cc_pedidos_loja_id
CHECK ( loja_id >=0) ;

--Faça os checks das colunas da tabela pedidos_itens

ALTER TABLE pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_pedido_id
CHECK ( pedido_id >=0) ;

ALTER TABLE pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_produto_id
CHECK ( produto_id >=0) ;

ALTER TABLE pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_numero_da_linha
CHECK ( numero_da_linha >=0 AND numero_da_linha <= 99999999999999999999999999999999999999) ;

ALTER TABLE pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_preco_unitario
CHECK ( preco_unitario >=0.00) ;

ALTER TABLE pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_quantidade
CHECK ( quantidade >=0) ;

ALTER TABLE pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_envio_id
CHECK ( envio_id >=0) ;

--Faça os checks das colunas da tabela envios

ALTER TABLE envios
ADD CONSTRAINT cc_envios_envio_id
CHECK ( envio_id >=0) ;

ALTER TABLE envios
ADD CONSTRAINT cc_envios_loja_id
CHECK ( loja_id >=0) ;


ALTER TABLE envios
ADD CONSTRAINT cc_envios_cliente_id
CHECK ( cliente_id >=0) ;

ALTER TABLE envios
ADD CONSTRAINT cc_envios_endereco_entrega
CHECK ( endereco_entrega ~* '^[A-Za-z0-9\s.,#-]+$') ;

ALTER TABLE envios
ADD CONSTRAINT cc_envios_status
CHECK ( status IN ('CRIADO, ENVIADO, TRANSITO, ENTREGUE')) ;

--FIM