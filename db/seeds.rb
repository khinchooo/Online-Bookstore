# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Book.create(book_title: 'Python Programming', image: '1.jpg', price: '3700',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 450)
Book.create(book_title: 'Javascript Quick Steps', image: '2.jpg', price: '5400',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 500)
Book.create(book_title: 'C# Quick Steps', image: '3.jpg', price: '4500',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 420)
Book.create(book_title: 'Cyber Security learning', image: '4.jpg', price: '5700',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 450)
Book.create(book_title: 'Vue.js Programming', image: '5.jpg', price: '3500',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 500)
Book.create(book_title: 'Java Programming', image: '6.jpg', price: '6000',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 420)
Book.create(book_title: 'Ruby Programming', image: '7.jpg', price: '2950',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 500)
Book.create(book_title: 'Project Managemnet', image: '8.jpg', price: '4600',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 420)
Book.create(book_title: 'ASP.NET MVC 5', image: 'ASP.Net.jpg', price: '3600',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 450)
Book.create(book_title: 'Bootstrap 4 ', image: 'bootstrap.jpg', price: '6500',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 500)
Book.create(book_title: 'HTML/CSS', image: 'html.jpg', price: '3200',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 420)
Book.create(book_title: 'Kotlin learning', image: 'kotlin.jpg', price: '4300',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 450)
Book.create(book_title: 'Laravel Programming', image: 'laravel.jpg', price: '5100',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 500)
Book.create(book_title: 'PHP Programming', image: 'php_book.jpg', price: '6200',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 420)
Book.create(book_title: 'Spring Boot Programming', image: 'spring_boot.jpg', price: '2860',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 500)
Book.create(book_title: 'VB.Net Book', image: 'VB.Net.jpg', price: '3400',description: 'Put your quarantine time to good use by picking up some programming skills or spend quality time learning.',delivery_fee: 420)

User.create(name: 'Khin Cho Oo', email: 'khinchooo@gmail.com', password: '123456', address: 'Kanagawa ken Tsurumi ku Teraonakadai', phone_number: '09959776754')
User.create(name: 'user1', email: 'user1@gmail.com', password: '123456', address: 'Kanagawa ken Tsurumi ku Kajiyama', phone_number: '09959776773')