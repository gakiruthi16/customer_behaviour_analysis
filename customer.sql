select *from customer limit 10 ;
select count(*) from customer;
select gender,avg(purchase_amount_usd) from customer group by gender;

select count(DISTINCT customer_id) from customer where discount_applied='Yes';
select customer_id from customer where discount_applied='Yes' and purchase_amount_usd > 
              (select avg(purchase_amount_usd) from customer);
select item_purchased ,avg(review_rating) from customer group by item_purchased order by avg(review_rating) desc limit 5;

select shipping_type,avg(purchase_amount_usd) from customer group by shipping_type;
select shipping_type,avg(purchase_amount_usd) from customer 
              where shipping_type in ('Standard','Express') group by shipping_type;
select subscription_status,count(*) as total_customer,avg(purchase_amount_usd) as average_spend,
sum(purchase_amount_usd) as total_revenue from customer group by subscription_status;
select item_purchased,discount_applied from customer;

SELECT item_purchased,count(*) as total_count ,sum(case when discount_applied = 'Yes' then 1 else 0 end)*100.0/count(*)
as percentage from customer GROUP BY item_purchased
ORDER BY percentage DESC LIMIT 5;
select customer_id ,case 
                         when count(*)<=5 then 'New'
					     when count(*) between 6 and 10 then 'Returning' 
						 else 'loyal' 
end as cust_segment from customer group by customer_id;
with purchased_count as(
            select category,item_purchased,
			count(*) as purchase_count from customer 
			group by category,item_purchased),
ranked as (
            select category,item_purchased ,purchase_count,
            Rank() over( partition by category order by purchased_count Desc) as product_rank
            from purchased_count)
select category,item_purchased,purchase_count from ranked where  product_rank <=3 order by category,item_purchased Desc;
select subscription_status,count(distinct customer_id)  as repeat_buyer from customer 
            where previous_purchases > 5 group by subscription_status;
select age_group,sum(purchase_amount_usd) as total_revenue from customer group by age_group order by total_revenue desc ;