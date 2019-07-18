# README

Objetivo:
El objetivo de este ejercicio es evaluar la capacidad de análisis, definición de arquitectura y practicas de desarrollo que tiene un candidato

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

<p>Como ejecutar el test suite</p>
<ul>
    <li>Todos - rspec spec/services</li>
    <li>Alguno - rspec/services/transfer_services.rb</li>
</ul>

<h2>Demo</h2>
<ul>
    <li><a href="https://ewalletconekta.herokuapp.com/" target="_blank">Ir al demo</a></li>
</ul>

<h2>¿Cómo usar?</h2>

<p><a href="https://ewalletconekta.herokuapp.com/api/customers">Recurso customer (api/customers)</a></p>
<ul>
    <li>GET</li>
    <li>POST</li>
    <li>PATCH</li>
</ul>

<p><a href="https://ewalletconekta.herokuapp.com/api/customers">Recurso credit card (api/customers/:account_number/credit_cards)</a></p>
<ul>
    <li>GET</li>
    <li>POST</li>
</ul>

<p><a href="https://ewalletconekta.herokuapp.com/api/customers">Recurso back (api/customers/:account_number/backs)</a></p>
<ul>
    <li>GET</li>
    <li>POST</li>
</ul>