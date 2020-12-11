1) To check the quantity on hand of a specific product and also display the message for reordering if it is below reorder level.
2)To display total sales of entire day and profit of entire day.
3)To display monthly profit, expenditure and income.
4)To display top 10 customers.
5)To display the bill summary of a specific customer.
6)To find the profit over a specific product.
7)To give the tracking/delivery details of a product.
8)To update the qoh field of stock_manage table with updates in product table.


          


	create trigger p1 after insert on product for each row
	begin
	update stock_manage
	set quantity_on_hand=quantity_on_hand + new.quantity_purchased where product_id=new.product_id;
	end $
	
	create trigger di1 after insert on delivery for each row
	begin 
	update stock_manage 
	set quantity_on_hand = quantity_on_hand - new.quantity where product_id=new.prod_id;
	end $
	
	create trigger r1 after update on stock_manage for each row
	begin
	declare msg varchar(150);
                  declare a, b int;
	set a=old.reorder_level; 
	set b=new.quantity_on_hand; 
	if  b< a then
	set msg = 'Alert : Reorder level has been reached';
	 signal sqlstate '45001' set message_text = msg;
	end if;
	end $
	


10)To add current date and time of  purchase of the product

delimiter $
create trigger t1 before insert on product for each row
begin
if(new.date_of_purchase is null) then
set new.date_of_purchase= now();
end if;
end$

create trigger t2 before insert on product for each row
begin
if(new.time_of_purchase is null) then
set new.time_of_purchase= current_timestamp();
end if;
end$
delimiter ;


delimiter ;
