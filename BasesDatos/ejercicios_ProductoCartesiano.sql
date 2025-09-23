-- Franjas horarias
SELECT days.day, times.time, employees.employee_name
FROM days
CROSS JOIN times
CROSS JOIN employees;


-- Agrupacion de productos para promocion
SELECT
    o.product_id as office_supplies_id,
    o.product_name as office_supplies_name,
    o.price as office_price as supplies_price,
    e.product_id as electronics_id,
    e.product_name as electronics_name,
    e.price as electronics_price
FROM office_supplies o
CROSS JOIN electronics
WHERE o.price < 50;


-- Planificacion de comidas
SELECT
    mains.dish_name as main_dish,
    side_dishes.dish_name as side_dish
FROM mains
CROSS JOIN side_dishes; 


-- Asignacion de proyectos
SELECT
    p.project_id as project_id,
    e.employee_id as employee_id,
    e.employee_name as employee_name
FROM projects p
CROSS JOIN employees e
WHERE e.received_training = "Yes";


-- Recomendaciones de productos premium
SELECT
    c.customer_id as customer_id,
    pp.product_id as product_id,
    pp.product_name as product_name
FROM customers c
CROSS JOIN premium_products pp
WHERE c.suscription_status = "Gold";