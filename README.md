# Tourism Package and Travel Booking Management System

## Project Overview
A database-driven web application for managing tourism packages, customers, bookings, payments, destinations, hotels and transportation.

## Technologies Used
- Python
- Flask
- MySQL
- HTML
- CSS
- JavaScript

## Main Features
- View tourism packages
- View package details
- Book travel packages
- Enter traveler details
- Process payments
- Customer management
- Admin dashboard
- MySQL database integration
- Booking and payment tracking
- SQL joins, aggregation and views

## Database
Database Name: tourism_booking_db

### Main Tables
- customer
- destination
- package
- package_destination
- booking
- payment
- hotel
- package_hotel
- transport
- package_transport

### Database Views
- booking_summary
- package_details
- customer_booking_history

## Database Design
The database uses primary keys, foreign keys, unique constraints, NOT NULL constraints and normalized relational tables.

## How to Run
cd Tourism-Booking-Management-System
source venv/bin/activate
python backend/app.py

Open http://127.0.0.1:5000

## Project Flow
Customer → Select Package → Enter Traveler Details → Create Booking → Payment → Booking Confirmation → MySQL Database
