/* Projeto Prático - Dados */

create database boticario;


create table cliente(
	email varchar(50) primary key NOT NULL,
	nome varchar(20) NOT NULL,
	sobrenome varchar(20) NOT NULL,
	cpf varchar(11) NOT NULL,
	data_nascimento date NOT NULL,
	celular varchar(13),
	senha varchar(20) NOT NULL,
	genero char(1) NOT NULL,
	clubeviva boolean default false,
	notificacao boolean default false
);


create table endereco(
    idEndereco integer primary key auto_increment NOT NULL,
    tipo_local_entrega varchar(15) NOT NULL,
    cep varchar(8) NOT NULL,
    rua varchar(50) NOT NULL,
    numero integer,
    sem_numero boolean,
    complemento varchar(50),
    bairro varchar(20) NOT NULL,
    cidade varchar(20) NOT NULL,
    uf char(2) NOT NULL,
    ponto_referencia varchar(50),
    titular_recebedor boolean default false,
    nome_recebedor varchar(20),
    sobrenome_recebedor varchar(20),
    endereco_principal boolean default false,
    endereco_cobranca boolean default false
);

create table cliente_endereco (
    cliente_email varchar(20) not null,
    endereco_idEndereco integer not null,
    titulo_endereco varchar(20) not null,
    constraint fk_cliente_email foreign key (cliente_email) references cliente(email),
    constraint fk_endereco_idEndereco foreign key (endereco_idEndereco) references endereco(idEndereco),
    primary key (cliente_email, endereco_idEndereco, titulo_endereco)
);

create table cartao (
    numero_cartao integer primary key NOT NULL,
    nome_titular varchar(20) NOT NULL,
    data_validade varchar(20) NOT NULL,
    cvv varchar(20) NOT NULL,
    cartao_principal boolean NOT NULL
);

create table cliente_cartao (
    cliente_email varchar(20) not null,
    cartao_numero_cartao integer not null,
    constraint fk_cliente_email_cartao foreign key (cliente_email) references cliente(email),
    constraint fk_cartao_numero_cartao foreign key (cartao_numero_cartao) references cartao(numero_cartao),
    primary key (cliente_email, cartao_numero_cartao)
);


create table pedidos (
    numero_pedido integer primary key auto_increment NOT NULL,
    cliente_email varchar(50),
    data_compra date,
    valor_pedido decimal(10,2) not null,
    cupom_desconto varchar(20),
    pagto_aprovado boolean not null,
    constraint fk_cliente_email_pedidos foreign key (cliente_email) references cliente(email)
);


create table status_pedido (
    id_statusPedido integer primary key auto_increment NOT NULL,
    pedidos_numero_pedido integer not null,
    dt_aprovacao_pagto date,
    dt_prevista_entrega date,
    dt_embalagem date,
    dt_envio_transporte date,
    dt_entrega date,
    constraint fk_pedidos_numero_pedido foreign key (pedidos_numero_pedido) references pedidos(numero_pedido)
);

create table pedido_presente (
    id_pedidopresente integer primary key auto_increment NOT NULL,
    pedidos_numero_pedido integer not null,
    embalagem_produto boolean default false,
    embalar_produto boolean default false,
    constraint fk_pedidos_numero_pedido_presente foreign key (pedidos_numero_pedido) references pedidos(numero_pedido)
);

create table categoria (
    idCategoria integer primary key auto_increment NOT NULL,
    descricao varchar(20) not null
);

create table produtos (
    idProduto integer primary key auto_increment NOT NULL,
    descricao varchar(20) not null,
    categoria_idCategoria integer not null,
    preco decimal(10,2) not null,
    constraint fk_categoria_idCategoria foreign key (categoria_idCategoria) references categoria(idCategoria)
);

create table produtos_categoria (
    categoria_idCategoria integer not null,
    produtos_idProduto integer not null,
    constraint fk_categoria_idCategoria_produtos foreign key (categoria_idCategoria) references categoria(idCategoria),
    constraint fk_produtos_idProduto_categoria foreign key (produtos_idProduto) references produtos(idProduto),
    primary key (categoria_idCategoria, produtos_idProduto)
);

create table pedidos_produtos (
    pedidos_numero_pedido integer not null,
    produtos_idProduto integer not null,
    quantidade integer not null,
    constraint fk_pedidos_numero_pedido_produtos foreign key (pedidos_numero_pedido) references pedidos(numero_pedido),
    constraint fk_produtos_idProduto foreign key (produtos_idProduto) references produtos(idProduto),
    primary key (pedidos_numero_pedido, produtos_idProduto)
);

create table pagamento (
    id_Pagamento integer primary key auto_increment NOT NULL,
    pedidos_numero_pedido integer not null,
    pagar_cartaoCredito boolean,
    cartao_numero_cartao integer,
    pagar_Pix boolean,
    codigo_pix varchar(20),
    pagar_boleto boolean,
    boleto_codigoBarra varchar(20),
    constraint fk_pedidos_numero_pedido_pagamento foreign key (pedidos_numero_pedido) references pedidos(numero_pedido),
    constraint fk_cartao_numero_cartao_pagamento foreign key (cartao_numero_cartao) references cartao(numero_cartao)
);


create table pontos (
    id_pontos integer primary key auto_increment NOT NULL,
    pedidos_numero_pedido integer not null,
    data_compra date not null,
    pontos_gerados integer not null,
    pontos_utilizados integer,
    constraint fk_pedidos_numero_pedido_pontos foreign key (pedidos_numero_pedido) references pedidos(numero_pedido)
);

create table troca_pontos (
    id_troca_pontos integer primary key auto_increment NOT NULL,
    data_utilizacao date not null,
    qtd_pontos integer not null,
    pontos_id_pontos integer not null,
    constraint fk_pontos_id_pontos foreign key (pontos_id_pontos) references pontos(id_pontos)
);

create table estoque (
    produtos_idProduto integer not null,
    data_validade date not null,
    qtd_estoque integer,
    constraint fk_produtos_idProduto_estoque foreign key (produtos_idProduto) references produtos(idProduto),
    primary key (data_validade, produtos_idProduto)
);



