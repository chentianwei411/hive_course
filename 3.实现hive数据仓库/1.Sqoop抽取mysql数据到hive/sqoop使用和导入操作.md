### Sqoop是什么?

- Sqoop：SQL-to-Hadoop
- 连接 传统关系型数据库 和 Hadoop 的工具
- Sqoop是一个转换工具，用于在关系型数据库与Hive等之间进行数据转换



&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;![](https://upload-images.jianshu.io/upload_images/12312683-0b1812471d46f9f7.png)





---

### Sqoop导入操作 
现在阿里云服务器的MYSQL中创建一个数据表叫做**日期维度表**（dim_date_df），里面有17个字段,我们需要把这些数据迁入到HIVE中的ods库中

&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;![](https://upload-images.jianshu.io/upload_images/12312683-bc8a9ef2ba124a34.png)


### **知识点：**
Sqoop import  迁入  
将数据从关系型数据库导入Hadoop（如hive等）中

- 步骤1：Sqoop与数据库Server通信，获取数据库表的元数据信息；

- 步骤2：Sqoop启动一个Map-Only的MR作业，利用元数据信息并行将数据写入Hadoop。

- 特点：可以指定hdfs路径，指定关系数据库的表，字段，连接数（不压垮数据库），可以导入多个表，支持增量导入（手动指定起始id、事件，或自动记录上次结束位置，自动完成增量导入）



#### 下面是一个shell脚本代码（sqoop_dim_date_df.sh）

```
#### 导入查询出来的数据到Hive

hive -e "drop table if exists ods.dim_date_df" # 删除hive原有的旧表
sqoop import \ 
--hive-import \ 
## 告诉jdbc，连接mysql的url
--connect jdbc:mysql://106.15.121.232:3306/adventure_ods?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&tinyInt1isBit=false&dontTrackOpenResources=true&defaultFetchSize=50000&useCursorFetch=true" \  
--driver com.mysql.jdbc.Driver \ # Hadoop根目录
--username frogdata05 \ 	 ## 连接mysql的用户名
--password Frogdata!123 \   ## 连接mysql的密码
--query \  ## 构建表达式<sql语句 >执行
"select * from dim_date_df where "'$CONDITIONS'" " \
--fetch-size 50000 \  ## 一次从数据库读取 n 个实例，即n条数据
--hive-table ods.dim_date_df \ ## 创建dim_date_df表（默认也会自动创建表）
--hive-drop-import-delims \  ## 在导入数据到hive时，去掉数据中的\r\n\013\010这样的字符
--delete-target-dir \  ## 如果目标文件已存在就把它删除
--target-dir /user/hadoop/sqoop/dim_date_df \  ## 指定的目录下面并没有数据文件，数据文件被放在了hive的默认/user/hadoop/sqoop/dim_date_df下面
-m 1  ## 迁移过程使用1个map（开启一个线程）
```



### **注：**
- **以上的命令中后面的##部分是注释，执行的时候需要删掉；另外，命令的所有内容不能换行，只能一行才能执行。**
- 一般是写到shell脚本上，在linux 系统中运行即可

- 命令执行完后，再去观察hive中的数据表，是不是已经有数据存在了！

- Sqoop的更多详细参数请看 https://www.cnblogs.com/alexzhang92/p/10927884.html


---


### 作业：

>我们需要从MYSQL里把 **日期维度表**、**每日新增用户表**、**订单明细表**分别通过sqoop把这些表的数据给迁入到Hive的ods库中，现在文档里有两个表导入的shell脚本已经写好了，是**日期维度表**（sqoop_dim_date_df.sh）、**每日新增用户表**（sqoop_ods_customer.sh），剩下的**订单明细表**（ods_sales_orders）导入需要独立完成，可参考文档里的代码。