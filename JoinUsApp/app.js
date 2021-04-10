const express = require('express');
const app = express();
const path = require('path')
const faker = require('faker');
const mysql = require('mysql');

const connection = mysql.createConnection({
	host: 'localhost',
	user: 'bhavya',
	password: 'password',
	database: 'join_us'
});

app.use(express.urlencoded({ extended: true }))
app.use(express.static(path.join(__dirname, 'public')))

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

//Inserting lots of data

// for (let i = 0; i < 100; i++) {
//     let person = {
//         email: faker.internet.email(),
//         created_at: faker.date.past()
//     }

//     connection.query('INSERT INTO users SET ?', person, function (err, results, field) {
//         if (err)
//             throw err
//     })

// }

//Inserting lots of data using a single query

// const data = []

// for (let i = 0; i < 500; i++) {
//     data.push([
//         faker.internet.email(),
//         faker.date.past()
//     ])
// }

// connection.query('INSERT INTO users(email, created_at) VALUES ?', [data], function (err, res) {
//     if (err)
//         throw err
//     console.log(res)
// })



app.get('/', (req, res) => {
	const q = 'SELECT COUNT(*) AS count FROM users'
	let data = 0;
	connection.query(q, (err, result) => {
		if (err)
			throw err
		data = result[0].count;
		res.render('home', { data })
	})
})

app.post('/register', (req, res) => {
	// const { email } = req.body;
	// const q = `INSERT INTO users(email) VALUES("${email}")`

	const person = {
		email: req.body.email
	}

	connection.query('INSERT INTO users SET ?', person, (err, result) => {
		if (err)
			throw err
		console.log(result)
	})

	res.redirect('/')
})

app.listen('3000', () => {
	console.log('Server running')
})






