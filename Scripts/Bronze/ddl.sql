Create or Alter procedure bronze.load_bronze as 
begin
declare @start_time datetime, @end_time datetime
begin try
	Print'====================================';
	print'Loading Bronze Layer';
	print'====================================';

	print'------------------------------------';
	print'Loading CRM Tables';
	print'------------------------------------';

	set @start_time=GETDATE();
	print'>> Truncating Table: bronze.crm_prd_info';
	truncate table bronze.crm_prd_info;
	bulk insert bronze.crm_prd_info
	from 'C:\Users\mikeo\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	with(
	firstrow=2,
	fieldterminator=',',
	Tablock
	);
		set @end_time=GETDATE();
		print'>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) AS Nvarchar) + ' seconds';
		print'>>------------';

	print'>> Truncating Table: bronze.crm_cust_info';
	truncate table bronze.crm_cust_info;
	bulk insert bronze.crm_cust_info
	from 'C:\Users\mikeo\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	with(
	firstrow=2,
	fieldterminator=',',
	Tablock
	);

	print'>> Truncating Table: bronze.crm_sales_details';
	truncate table bronze.crm_sales_details;
	bulk insert bronze.crm_sales_details
	from 'C:\Users\mikeo\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	with(
	firstrow=2,
	fieldterminator=',',
	Tablock
	);

	print'------------------------------------';
	print'Loading ERP Tables';
	print'------------------------------------';

	print'>> Truncating Table: bronze.erp_cust_az12';
	truncate table bronze.erp_cust_az12;
	bulk insert bronze.erp_cust_az12
	from 'C:\Users\mikeo\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.CSV'
	with(
	firstrow=2,
	fieldterminator=',',
	Tablock
	);

	print'>> Truncating Table: bronze.erp_loc_A101';
	truncate table bronze.erp_loc_A101;
	bulk insert bronze.erp_loc_A101
	from 'C:\Users\mikeo\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\LOC_A101.CSV'
	with(
	firstrow=2,
	fieldterminator=',',
	Tablock
	);

	print'>> Truncating Table: bronze.erp_px_cat_g1v2';
	truncate table bronze.erp_px_cat_g1v2;
	bulk insert bronze.erp_px_cat_g1v2
	from 'C:\Users\mikeo\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.CSV'
	with(
	firstrow=2,
	fieldterminator=',',
	Tablock
	);
	End try
	Begin catch
		print'=================================='
		print'Error Occured during loading'
		print'Error Message' + error_message();
		print'Error Message' + cast(error_number() as Nvarchar);
		print'Error Message' + cast(error_state() as Nvarchar)
		print'=================================='
	end catch
End
