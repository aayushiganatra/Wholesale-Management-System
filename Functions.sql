select stock_manage.sc_id
		from stock_manage and sub_category
		where (stock_manage.sc_id = sub_category.sc_id) and (stock_manage.sc_id = )




DELIMITER $
Create function total_amount(ID varchar(20), quantity int, unit float)
returns float
		begin
		declare id varchar(20);
		declare unit_product, total_amount float;
		declare qty int;
		declare c1 int;
		declare cur1 cursor for select sc_id, quantity_purchased, unit_price from product_expense;
		declare continue handler for not found set c1 = 1;
		set c1 = 0; 
		set qty = 0;
		set unit_product = 0.0;
		set total_amount = 0.0;
		open cur1;

		while c1 = 0  do
		fetch cur1 into id, qty, unit_product;

		set qty = (select quantity_purchased
				from product_expense
				where ID = sc.id);
		set unit_product = (select unit_price
				from product_expense
				where ID = sc.id);
		set total_amount = (qty * unit_product);
		
		end while;
		close cur1;
		return (total_amount);
	end $






DELIMITER $
Create function stock_quantity(ID varchar(20))
returns int
		begin
		declare stock_id varchar(20);
		declare qoh int;
		declare c int;
		
		declare cur1 cursor for select sc_id, quantity_on_hand from stock_manage;
		declare continue handler for not found set c = 1;
		set stock_id = 0;
		set qoh = 0;
		set c = 0;
 		open cur1;
	 
		while c = 0 do
		fetch cur1 into stock_id, qoh;
		
		if(ID = stock_manage.sc_id) then	
		set qoh = (select quantity_on_hand
				from stock_manage
				where new.sc_id = ID);		

		end if;
		end while;
		close cur1;
		return (qoh);
	end $



select sc_id, sum(quantity) from income group by sc_id;
		
DELIMITER $
Create function highest_selling_item()
returns varchar(100)
		begin
		declare qty int;
		declare id varchar(20);
		declare name varchar(100);
		declare c int;
		declare cur1 cursor for select quantity from income;
		declare continue handler for not found set c = 1;
		set c = 0; 
		set qty = 0;
		open cur1;

		while c = 0  do
		fetch cur1 into qty;

		if (qty = (select MAX(quantity) from income)) then
		set qty = (select MAX(quantity) from income);
		set id = (select sc_id
				from income
				where quantity = (select MAX(quantity) from income));
		set name = (select product_name
				from sub_category
				where (id = sub_category.sc_id));
		end if;
		end while;
		close cur1;
		return (name);
	end $



DELIMITER $
Create function total_amount(ID varchar(20), quantity_purchased int, unit_price float)
returns float
		begin
		declare total_amount float;

		set total_amount = (quantity_purchased * unit_price);

		return (total_amount);
	end $


DELIMITER $
Create function payable_amount(ID varchar(20), quantity_sold int, unit_sp float)
returns float
		begin
		declare payable_amount float;

		set payable_amount = (quantity_sold * unit_sp);

		return (payable_amount);
	end $



