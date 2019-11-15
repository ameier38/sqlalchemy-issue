create schema test;
create table test.ach_event
(
	"_id" bigint,
	"_loaded_at" timestamp,
	"_cohort" date,
	"_source_file" varchar(256),
	event_type varchar(20),
	file_id varchar(10),
	file_creation_date varchar(6),
	file_creation_time varchar(4),
	file_id_modifier varchar(1),
	company_service_class_code varchar(3),
	company_name varchar(16),
	company_custom_data varchar(20),
	company_id varchar(10),
	company_sec_code varchar(3),
	company_entry_description varchar(10),
	company_entry_effective_date varchar(6),
	company_batch_number varchar(7),
	entry_transaction_code varchar(2),
	entry_rdfi_routing_number varchar(8),
	entry_rdfi_routing_check_digit varchar(1),
	entry_rdfi_account_number varchar(17),
	entry_amount varchar(10),
	entry_individual_id varchar(15),
	entry_individual_name varchar(22),
	entry_trace_number varchar(15),
	addenda_type_code varchar(2),
	addenda_payment_information varchar(80),
	addenda_sequence_number varchar(4)
);
