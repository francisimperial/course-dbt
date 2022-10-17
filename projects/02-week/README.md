# Week 2 Project

### 1) What is our user repeat rate?

#### Answer: 79.83%

```
select 
    sum(case when num_of_orders > 1 then 1 else 0 end) /
        sum(case when num_of_orders > 0 then 1 else 0 end) as repeat_rate
from
    dev_db.dbt_franciswong17.dim_users
```

### 2) DAG for models

![dbt-dag](https://user-images.githubusercontent.com/44100072/196254336-62460071-cbb0-4391-b41c-247ad552e2f1.png)

### 3) Test

The only tests I included in my models were default unique and not_null tests for my guid fields.