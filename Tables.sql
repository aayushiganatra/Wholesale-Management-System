create table user(name varchar(50), contact_num bigint unique, user_id varchar(20),city varchar(20) default 'ahmedabad',
	           primary key( user_id)); 


create table producer(prod_name varchar(50), producer_id varchar(20),  contact bigint unique, city varchar(20), area varchar(20),
		 primary key(producer_id));


create table retailer(retailer_name varchar(50), retailer_id varchar(20), contact bigint unique,  city varchar(20), area varchar(20),
	                primary key(retailer_id ));


create table customer(cust_name varchar(50), cust_id varchar(20),cust_contact bigint unique, city varchar(20), area varchar(20),
		  primary key(cust_id));

create table category(c_id varchar(20), category_type varchar(100),
		primary key(c_id));

create table sub_category( sc_id varchar(20), c_id varchar (20), product_name varchar(100),
		         primary key(sc_id),
		         foreign key(c_id) references category(c_id));

create table product_expense(product_id varchar(20),sc_id varchar(20),user_id varchar(20), quantity_purchased int, p_id varchar(20) , date_of_purchase 					date null, time_of_purchase time  null ,unit_price float, total_amount bigint,
			primary key(product_id),
			foreign key (p_id) references producer(producer_id),
			foreign key (user_id) references user(user_id),
			foreign key(sc_id) references sub_category(sc_id));


create table stock_manage(sc_id varchar(20), quantity_on_hand int, reorder_level int,
		          foreign key(sc_id) references sub_category(sc_id));
	              


create table income(id int ,sc_id varchar(20) , quantity int, bill_date date, bill_time time, r_id varchar (20) null,
	                cust_id varchar(20) null, unit_sp float, user_id varchar(20),payable_amt bigint,
		primary key (id),
		 foreign key(sc_id  ) references sub_category(sc_id),
		  foreign key(r_id) references retailer(retailer_id),
		   foreign key(cust_id) references customer(cust_id),
		   foreign key (user_id) references user(user_id));


