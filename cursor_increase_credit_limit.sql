declare 
    cursor c_cant_ordenes is
        select customer_id, count(order_id) as cantidad from sales_order 
        group by customer_id;        
   
begin 
    for i in c_cant_ordenes loop  
        if i.cantidad > 5 then
            update customer
            set credit_limit = credit_limit * 0.95
             where customer_id = i.customer_id;
        end if;
    end loop;
end;