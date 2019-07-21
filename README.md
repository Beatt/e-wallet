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
api/customers/:account_number
{
	"customer": {
		"name": "Gabriel Jiménez",
		"email": "gabriel@gmail.com"
	}
}
</pre>
<pre>
// GET 
api/customers/:account_number
</pre>

<p><a href="https://ewalletconekta.herokuapp.com/api/customers/:account_number/credit_cards">Recurso credit card (api/customers/:account_number/credit_cards)</a></p>

<pre>
// POST
api/customers/:account_number/credit_cards
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
api/customers/:account_number/credit_cards/:id
</pre>

<p><a href="https://ewalletconekta.herokuapp.com/api/customers/:account_number/backs">Recurso back (api/customers/:account_number/backs)</a></p>
<p><em>value_in_cents: Monto a transferir o depositar</em></p>
<p><em>account_recipient: Número de cuenta del cliente a transferir</em></p>
<pre>
// POST
api/customers/:account_number/backs?type=deposit
{
	"back": {
		"value_in_cents": 1000,
		"credit_card_id": :credit_card_id
	}
}
</pre>

<pre>
// POST
api/customers/:account_number/backs?type=transfer
{
	"back": {
		"value_in_cents": 1000,
		"credit_card_id": 2,
		"account_recipient": :account_number
	}
}
</pre>

<pre>
// GET 

- Historial de transacciones
api/customers/:account_number/backs

- Balance
api/customers/:account_number/backs?scope=balance

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