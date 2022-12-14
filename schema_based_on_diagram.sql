create table medical_histories (
id int GENERATED BY DEFAULT AS IDENTITY,
admitted_at timestamp,
patient_id int not null,
status varchar,
primary key(id)
);

create table patients (
id int generated by default as identity,
name varchar,
date_of_birth date,
primary key(id));

create table treatments (
id int generated by default as identity,
type varchar,
name varchar,
primary key(id));

create table invoices (
    id int generated by default as identity,
    total_amount decimal,
    generated_at timestamp,
    payed_at timestamp,
    medical_history_id int,
    primary key(id)
    );

--  Add foreign keys to existing tables
ALTER TABLE
    medical_histories
ADD FOREIGN KEY (patient_id) REFERENCES patients(id);

ALTER TABLE
    invoices
ADD FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id);

--  Create join table
create table medical_history_treatments (
    medical_history_id int,
    treatment_id int,
    primary key(medical_history_id, treatment_id)
);

--  Add foreign keys to join table
ALTER TABLE
    medical_history_treatments
ADD FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id);

ALTER TABLE
    medical_history_treatments
ADD FOREIGN KEY (treatment_id) REFERENCES treatments(id);


create table invoice_items (
id int generated by default as identity,
unit_price decimal,
quantity int,
total_price decimal,
invoice_id int,
treatment_id int,
primary key(id));

ALTER TABLE invoice_items
ADD FOREIGN KEY (invoice_id) REFERENCES invoices(id);

ALTER TABLE invoice_items
ADD FOREIGN KEY (treatment_id) REFERENCES treatments(id);
