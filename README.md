# README

Objetivo:
Evaluar la capacidad de análisis, definición de arquitectura y practicas de desarrollo que tiene un candidato

<h2>Instalar</h2>

<p>Ruby versión</p>
<ul>
    <li>2.5.1</li>
</ul>

<p>Configuración</p>
<ul>
    <li>bundle install</li>
</ul>

<p>Database</p>
<ul>
    <li>rails db:create</li>
    <li>rails db:migrate</li>
    <li>rails db:seed</li>
</ul>

<h2>Demo</h2>
<ul>
    <li><a href="https://ewalletconekta.herokuapp.com/" target="_blank">Ir al demo</a></li>
</ul>
<p>Datos de prueba</p>
<pre>
// Customers
{
    "id": 1,
    "account_number": "583036",
    "name": "Gabriel",
    "access_token": "dnJRWlpXYTFwTXFGVENvb3hzdS9nOEdpbUxqOXdadU80ejRBS0JxUTVvREYwSHI2c211Q2tkbERoVE5WSkxJVi0tcmwwR3lkZ1pkNHNmbFdUQjVlRjBXUT09--4aa576e440e46ffb1c1f4b9d8a75a07003fa6530"
}
{
    "id": 2,
    "account_number": "305133",
    "name": "Geovanni",
    "access_token": "N2kzWHRCdWtMeU9jTzVNYVN0WGM1a0t6R01uZnZIdUVMVFQwLzVYTk5lM2FDWWhhclp1SFludDNHVFd2OHZ2WS0tNVRkV1ZmenIrT0dkR2RIcElsWklGQT09--b641e90a369365825d5580d9e95ab3ebdafeffed"
}
</pre>
<pre>
// Credit cards
{
    "id": 1,
    "customer_id": 1
}
{
    "id": 2,
    "customer_id": 2
}
</pre>

<h2>¿Cómo usar?</h2>
<p><a href="https://ewalletconekta.herokuapp.com/api/customers">Recurso customer (api/customers)</a></p>

<pre>
// POST
api/customers
{
	"customer": {
		"name": "Gabriel",
		"email": "gabriel@gmail.com"
	}
}
</pre>
<pre>
// PATCH
api/customers/:account_number?token=:access_token
{
	"customer": {
		"name": "Gabriel Jiménez",
		"email": "gabriel@gmail.com"
	}
}
</pre>
<pre>
// GET 
api/customers/:account_number?token=:access_token
</pre>

<p><a href="https://ewalletconekta.herokuapp.com/api/customers/:account_number/credit_cards">Recurso credit card (api/customers/:account_number/credit_cards)</a></p>

<pre>
// POST
api/customers/:account_number/credit_cards?token=:access_token
{
	"credit_card": {
		"brand": "visa",
		"kind": "credit_card",
		"expiration_date": "10/20",
		"number": "203201203103",
		"cvc": "123"
	}
}
</pre>

<pre>
// GET
api/customers/:account_number/credit_cards/:id?token=:access_token
api/customers/:account_number/credit_cards?token=:access_token
</pre>

<p><a href="https://ewalletconekta.herokuapp.com/api/customers/:account_number/backs">Recurso back (api/customers/:account_number/backs)</a></p>
<p><em>value_in_cents: Monto a transferir o depositar.</em></p>
<p><em>account_recipient: Número de cuenta del cliente a transferir.</em></p>
<p><em>credit_card_id: Tarjeta para abonar o hacer un cargo.</em></p>
<pre>
// POST
api/customers/:account_number/backs?type=deposit&token=:access_token
{
	"back": {
		"value_in_cents": 1000,
		"credit_card_id": :credit_card_id 
	}
}
</pre>

<pre>
// POST
api/customers/:account_number/backs?type=transfer&token=:access_token
{
	"back": {
		"value_in_cents": 1000,
		"account_recipient": :account_number
	}
}
</pre>

<pre>
// POST
api/customers/:account_number/backs?type=withdraw&token=:access_token
{
	"back": {
		"value_in_cents": 1000,
		"credit_card_id": :credit_card_id
	}
}
</pre>

<pre>
// GET 

- Historial de transacciones
api/customers/:account_number/backs?token=:access_token

- Balance
api/customers/:account_number/backs?scope=balance&token=:access_token

</pre>

<h2>Test</h2>
<p>Configuración</p>
<ul>
    <li>rails db:test:prepare</li>
    <li>rails RAILS_ENV=test db:seed</li>
</ul>

<p>Ejecutar</p>
<ul>
    <li>Todos - rspec spec/services</li>
    <li>Alguno - rspec/services/transfer_services.rb</li>
</ul>