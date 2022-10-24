use Ejemplo
show collections

db.Clientes.find()
db.Clientes.find({},{"name":1,_id:0})
db.Clientes.findOne()
db.Clientes.insertOne({

    "id":"C3",
    "name":"Tania Vasquez",
    "ciudad":"Lima",
    "distrito":"Surco",
    "cuentas":[
        {
        "no_cuenta":4,
        "tipo":"Cheques",
        "saldo":15000
        }
    ]
    }
)
db.Clientes.insertMany([
    {"id":"C5","name":"Juan Diego Carassa","ciudad":"Trujillo","distrito":"Miraflores"},
    {"id":"C6","name":"Angeles Tasaico","ciudad":"Lima","distrito":"Jesus Maria"}
])