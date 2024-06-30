# membuat tabel analisis
with sub_query as (
      select *,
      case
            when price > 50000 and price <= 100000 then 0.15
            when price > 100000 and price <= 300000 then 0.20
            when price > 300000 and price <= 500000 then 0.25
            when price > 500000 then 0.3
            else 0.10
            end as persentase_gross_laba
      from `kimia_farma.kf_final_transaction`
)
select ft.transaction_id, ft.date, ft.branch_id, 
      kc.branch_name, kc.kota, kc.provinsi, kc.rating rating_cabang,
      ft.customer_name, ft.product_id, 
      p.product_name, p.price, ft.discount_percentage,
      ft.persentase_gross_laba,
      ft.price - (ft.price * ft.discount_percentage) net_sales,
      ft.price - (ft.price * ft.persentase_gross_laba) net_profit,
      ft.rating rating_transaksi
from sub_query ft
join `kimia_farma.kf_kantor_cabang` kc on ft.branch_id=kc.branch_id
join `kimia_farma.kf_product`p on ft.product_id = p.product_id
order by ft.date asc;
