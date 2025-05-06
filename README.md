# Telecommunication Database in SQL

This repository contains SQL scripts for creating, populating, and querying a telecommunication database. The database models a telecommunication company's operations, including customers, employees, contracts, and marketing agreements.

## Table of Contents

- [Overview](#overview)
- [Database Schema](#database-schema)
- [Scripts](#scripts)
  - [Create and Delete Tables](#create-and-delete-tables)
  - [Insert Data](#insert-data)
  - [Select Queries](#select-queries)
- [Usage](#usage)
- [Requirements](#requirements)

## Overview

The database is designed to manage information about:

- Customers and their personal details.
- Employees and their roles in the company.
- Contracts, offers, and packages provided to customers.
- Marketing agreements and customer consents.
- Communication methods and interactions with customers.

## Database Schema

The database consists of the following tables:

- **Adres**: Stores address details.
- **Osoba**: Stores personal information (name, surname).
- **Klient**: Represents customers.
- **Pracownik**: Represents employees.
- **Forma_kontatku**: Represents forms of communication (e.g., phone, email).
- **Kontakt**: Logs interactions between employees and customers.
- **Numer_telefonu**: Stores phone numbers associated with customers.
- **Pakiet**: Represents telecommunication packages.
- **Oferta**: Represents offers made to customers.
- **Umowa**: Represents contracts signed by customers.
- **Zgoda_marketingowa**: Represents marketing consents.
- **Zgoda_klient**: Links customers to their marketing consents.

## Scripts

### Create and Delete Tables

The script [`RBD_projekt_create_delete.sql`](RBD_projekt_create_delete.sql) contains:

- SQL commands to create all tables with their respective constraints (primary keys, foreign keys).
- Commands to drop tables and constraints if needed.

### Insert Data

The script [`RBD_projekt_insert.sql`](RBD_projekt_insert.sql) contains:

- SQL commands to populate the database with sample data for testing and demonstration purposes.

### Select Queries

The script [`RBD_projekt_select.sql`](RBD_projekt_select.sql) contains:

- SQL queries to retrieve insights from the database, such as:
  - Employees who served more customers than the average.
  - The number of marketing consents expressed by customers.
  - The most effective communication methods for sales.
  - The most frequently offered packages.
  - Average number of phone numbers per customer.
  - Percentage of offers resulting in contracts.
  - Customers whose contracts are expiring soon.
  - Annual payments made by customers.
  - Monthly customer interactions.

## Usage

1. **Set Up the Database**:
   - Run the `RBD_projekt_create_delete.sql` script to create the database schema.
   - Run the `RBD_projekt_insert.sql` script to populate the database with sample data.

2. **Query the Database**:
   - Use the queries in `RBD_projekt_select.sql` to analyze the data and retrieve insights.

3. **Modify the Database**:
   - Update the scripts as needed to adapt the database to your specific requirements.

## Requirements

- A relational database management system (RDBMS) that supports SQL (e.g., Oracle Database, PostgreSQL).
- SQL client or IDE for executing the scripts.
