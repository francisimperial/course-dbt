# Week 3 Project

### 1a) What is our overall conversion rate?

#### Answer: **57.9585%**

```
select 
    sum(packages_shipped)/count(session_guid) as conversion_rate
from
    dev_db.dbt_franciswong17.fact_sessions
```

### 1b) What is our conversion rate by product?

#### I created a new model called `fact_product_events` which tracks user activity by product name so I could count event types by product.

```
select 
    product_name,
    count(distinct session_guid) as total_sessions,
    count(distinct (case when event_type = 'add_to_cart' then session_guid end)) as converted_sessions,
    converted_sessions/total_sessions as conversion_rate
from 
    dev_db.dbt_franciswong17.fact_product_events
group by 1
```

resulting table:

```
PRODUCT_NAME	CONVERSION_RATE
String of pearls	0.6875
Bamboo	0.626866
Arrow Head	0.619048
Calathea Makoyana	0.603774
Rubber Plant	0.592593
Cactus	0.581818
Majesty Palm	0.567164
ZZ Plant	0.555556
Aloe Vera	0.553846
Bird of Paradise	0.55
Dragon Tree	0.548387
Boston Fern	0.539683
Fiddle Leaf Fig	0.535714
Devil's Ivy	0.533333
Monstera	0.530612
Peace Lily	0.530303
Alocasia Polly	0.529412
Pilea Peperomioides	0.525424
Angel Wings Begonia	0.52459
Jade Plant	0.521739
Philodendron	0.516129
Ficus	0.514706
Birds Nest Fern	0.512821
Spider Plant	0.508475
Pink Anthurium	0.5
Orchid	0.493333
Snake Plant	0.465753
Money Tree	0.464286
Ponytail Palm	0.428571
Pothos	0.393443
```

### 2) Macros

